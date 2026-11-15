-- sauwordline.lua
-- Microsoft Word satir modelini LuaLaTeX'te taklit eder:
--  1) Acgozlu (greedy / first-fit) satir kirma: Word her satira dogal genislikte
--     sigabilecek en fazla kelimeyi koyar, sonra iki yana yaslar. TeX'in Knuth-Plass
--     algoritmasi paragrafi butun olarak optimize ettiginden satir sonlari farkli olur.
--  2) Satir kutusu modeli: Word'de her satirin taban cizgisinin ustunde sabit
--     "ascent" (TNR 12pt icin 11.22pt), altinda (satir araligi - ascent) kadar yer
--     vardir. Iki satir arasi = onceki satirin satir yuksekligi + paragraf araligi.
local sau = {}
sau.enabled = true

local glyph_id   = node.id("glyph")
local glue_id    = node.id("glue")
local kern_id    = node.id("kern")
local penalty_id = node.id("penalty")
local disc_id    = node.id("disc")
local math_id    = node.id("math")
local hlist_id   = node.id("hlist")
local vlist_id   = node.id("vlist")
local rule_id    = node.id("rule")
local par_id     = node.id("local_par") or node.id("whatsit")

local slack = tex.sp("0.05pt")
sau.shrinkfrac = 0.227   -- Word: bosluklar en fazla %22.7 sikisabilir (Word ciktisindan istatistiksel)

local function nodewidth(n)
  local id = n.id
  if id == glyph_id or id == hlist_id or id == vlist_id or id == rule_id or id == kern_id then
    return n.width or 0
  elseif id == glue_id then
    return n.width
  elseif id == math_id then
    return n.surround or 0
  elseif id == disc_id then
    local w = 0
    local r = n.replace
    while r do w = w + nodewidth(r); r = r.next end
    return w
  end
  return 0
end

local function listwidth(l)
  local w = 0
  while l do w = w + nodewidth(l); l = l.next end
  return w
end

-- line width for line number k (1-based) honouring hangindent/hangafter
local function linewidth(k, hsize, ls, rs)
  local hi, ha = tex.hangindent, tex.hangafter
  local w = hsize - ls - rs
  if hi ~= 0 then
    if (ha >= 0 and k > ha) or (ha < 0 and k <= -ha) then
      w = w - math.abs(hi)
    end
  end
  return w
end

local function greedy(head)
  if not sau.enabled then return true end
  local ps = tex.parshape
  if type(ps) == "table" and #ps > 0 then return true end
  if type(ps) == "number" and ps > 0 then return true end
  -- skip paragraphs that already contain a forced linebreak handled by TeX? we treat them as hard breaks
  local hsize = tex.hsize
  local ls = (tex.leftskip and tex.leftskip.width) or 0
  local rs = (tex.rightskip and tex.rightskip.width) or 0
  local line = 1
  local avail = linewidth(line, hsize, ls, rs)
  local frac = sau.shrinkfrac or 0
  local width, shr = 0, 0          -- natural width and allowed shrink of the current line
  local inmath = false
  local lastbreak = nil            -- last legal breakpoint (glue or disc)
  local w_after, s_after = 0, 0    -- width/shrink consumed up to and including lastbreak
  local n = head
  local breaks = {}
  local function fits() return width - shr <= avail + slack end
  while n do
    local id = n.id
    if id == math_id then
      inmath = (n.subtype == 0)
      width = width + (n.surround or 0)
    elseif id == penalty_id and n.penalty <= -10000 then
      line = line + 1
      avail = linewidth(line, hsize, ls, rs)
      width, shr = 0, 0; lastbreak = nil
    elseif id == glue_id and (not inmath) and n.prev and n.prev.id ~= glue_id
           and not (n.prev.id == penalty_id and n.prev.penalty >= 10000) then
      if (not fits()) and lastbreak then
        breaks[#breaks+1] = lastbreak
        line = line + 1
        avail = linewidth(line, hsize, ls, rs)
        width, shr = width - w_after, shr - s_after
      end
      lastbreak = n
      local gs = math.min(n.shrink or 0, frac * n.width)
      w_after, s_after = width + n.width, shr + gs
      width, shr = w_after, s_after
    elseif id == disc_id and not inmath and (n.subtype == 1 or n.subtype == 2) then
      local pw = listwidth(n.pre)
      width = width + pw
      if (not fits()) and lastbreak then
        width = width - pw
        breaks[#breaks+1] = lastbreak
        line = line + 1
        avail = linewidth(line, hsize, ls, rs)
        width, shr = width - w_after, shr - s_after
        width = width + pw
      end
      width = width - pw + nodewidth(n)
      lastbreak = n
      w_after, s_after = width, shr
    else
      width = width + nodewidth(n)
      if id == glue_id then shr = shr + math.min(n.shrink or 0, frac * n.width) end
    end
    n = n.next
  end
  if (not fits()) and lastbreak then
    breaks[#breaks+1] = lastbreak
  end
  -- forbid all other breakpoints, force the chosen ones
  local chosen = {}
  for _, b in ipairs(breaks) do chosen[node.direct.todirect(b)] = true end
  n = head
  inmath = false
  while n do
    local nx = n.next
    if n.id == math_id then
      inmath = (n.subtype == 0)
    elseif n.id == glue_id and not inmath then
      local p = n.prev
      if chosen[node.direct.todirect(n)] then
        local pen = node.new(penalty_id); pen.penalty = -10000
        head = node.insert_before(head, n, pen)
      elseif not (p and p.id == penalty_id and p.penalty >= 10000) then
        local pen = node.new(penalty_id); pen.penalty = 10000
        head = node.insert_before(head, n, pen)
      end
    elseif n.id == disc_id then
      if chosen[node.direct.todirect(n)] then
        -- replace disc by its pre-break material followed by a forced break
        local pre = n.pre
        n.pre = nil
        local pen = node.new(penalty_id); pen.penalty = -10000
        if pre then
          head = node.insert_before(head, n, pre)
        end
        head = node.insert_before(head, n, pen)
        -- zero-width glue so the break is legal and is discarded
        local g = node.new(glue_id)
        head = node.insert_before(head, n, g)
        head = node.remove(head, n)
      else
        n.penalty = 10000
      end
    end
    n = nx
  end
  return head
end

-- Word style line boxes: every line gets height >= ascent and depth >= (L - ascent).
-- L (satir yuksekligi) her glife "sauLineAttr" niteligi olarak islenir; boylece paragrafi
-- bitiren \par bir grubun disinda olsa bile dogru satir araligi kullanilir.
local attr = luatexbase.registernumber("sauLineAttr")
local aattr = luatexbase.registernumber("sauAscAttr")
local function line_LA(line)
  for g in node.traverse_id(glyph_id, line.head) do
    local v = node.has_attribute(g, attr)
    if v and v > 0 then
      return v, (node.has_attribute(g, aattr) or tex.dimen["sauAscent"])
    end
  end
  return tex.dimen["sauLineHeight"] or 0, tex.dimen["sauAscent"] or 0
end
local function struts(head)
  if not sau.enabled then return true end
  for n in node.traverse_id(hlist_id, head) do
    if n.subtype == 1 then -- line
      local L, A = line_LA(n)
      if L > 0 then
        local D = L - A
        if n.height < A then n.height = A end
        if n.depth < D then n.depth = D end
      end
    end
  end
  return true
end

luatexbase.add_to_callback("pre_linebreak_filter", greedy, "sau.greedy")
luatexbase.add_to_callback("post_linebreak_filter", struts, "sau.struts")

return sau
