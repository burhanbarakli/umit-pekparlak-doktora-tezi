"""12.10.2026 paketinin değiştirilmemiş koşusunu deney hedefleriyle karşılaştırır.

Girdi : runs/<koşu>/results/<model>/display_degerleri_eslesik.csv
        (extract_umit_display_values_20261027.m çıktısı; Display adı -> son değer)
Çıktı : runs/<koşu>/karsilastirma.csv
        (--baseline verilirse ayrıca runs/<koşu>/regresyon_<baz koşu>.csv)
Çağrı : python -I scripts/compare_umit_dort_senaryo_20261027.py   (proje kökünden; ilk koşu)
        python -I scripts/compare_umit_dort_senaryo_20261027.py --run 2026-10-27_s2_kapi_onarimi --baseline 2026-10-27_dort_senaryo_ilk_kosu
Varsayılan koşu klasörü 2026-10-27_dort_senaryo_ilk_kosu'dur (27.10.2026 öncesi davranış).

Senaryo 1+2 modelinde "1" sonekli Display'ler ikinci devreye aittir; hangi
devrenin hangi senaryo olduğu Vdc değerinden doğrulanır (S1 431,5 V, S2 395 V).
Modeldeki THD ve verim kesir olarak verilir; yüzdeye çevrilir.
"""
import argparse
import csv
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
DEFAULT_RUN = "2026-10-27_dort_senaryo_ilk_kosu"
RUN = ROOT / "runs" / DEFAULT_RUN

# İki devreli (S1 + S2) modeller: ham paket modeli ve D-01 onarımlı kopyası
S12_MODELS = ("inverter_scenario1_parametric5_etiquetli", "inverter_s1s2_s2onarim",
              "inverter_s1s2_s2onarim_d08")  # _d08: D-08 diyot eşlemesi düzeltilmiş kopya
S3_MODELS = ("inverter_senaryo3", "inverter_senaryo4", "inverter_senaryo3_d08")

# Deney hedefleri: değerler.xlsx (17.08.2026) = inverter_common_parameters.m (12.10.2026)
TARGETS = {
    "S1": dict(Vdc=431.50, Idc=0.624, P_dc=269.26, Ifaz=2.26, Po=249.60, Qo=0.00, cosfi=1.000, THD=15.0, verim=92.5),
    "S2": dict(Vdc=395.00, Idc=0.684, P_dc=270.18, Ifaz=2.33, Po=253.20, Qo=-25.42, cosfi=-0.995, THD=47.0, verim=94.2),
    "S3": dict(Vdc=427.50, Idc=0.697, P_dc=297.97, Ifaz=2.31, Po=281.20, Qo=-21.83, cosfi=-0.997, THD=14.0, verim=94.5),
}

# metrik -> (Display adı, ölçek)
DISPLAYS = dict(
    Vdc=("Vdc", 1), Idc=("Idc", 1), P_dc=("DC Güç", 1), Ifaz=("AC Akım RMS", 1),
    Po=("AC Aktif Güç", 1), Qo=("AC Reaktif Güç", 1), cosfi=("cosfi", 1),
    THD=("AC Akım THD", 100), verim=("Verim", 100),
)


def load(model, run=None):
    path = (run or RUN) / "results" / model / "display_degerleri_eslesik.csv"
    if not path.exists():
        return None
    with path.open(encoding="utf-8-sig") as f:
        return {row["display"]: float(row["son_deger"]) for row in csv.DictReader(f)}


def circuits(run=None):
    for model in S12_MODELS:
        s12 = load(model, run)
        if not s12:
            continue
        for suffix in ("", "1"):
            vdc = s12.get("Vdc" + suffix)
            scen = "S1" if vdc is not None and abs(vdc - 431.5) < abs(vdc - 395) else "S2"
            yield scen, model, suffix, s12
    for model in S3_MODELS:
        vals = load(model, run)
        if vals:
            yield "S3", model, "", vals


def regression(baseline_name):
    """Aynı senaryo/metrik için bu koşu ile baz koşunun benzetim değerlerini karşılaştırır."""
    base = {}
    for scen, model, suffix, vals in circuits(ROOT / "runs" / baseline_name):
        for metric, (name, scale) in DISPLAYS.items():
            raw = vals.get(name + suffix)
            if raw is not None:
                base.setdefault((scen, metric), (model, raw * scale))
    rows = []
    for scen, model, suffix, vals in circuits():
        for metric, (name, scale) in DISPLAYS.items():
            raw = vals.get(name + suffix)
            if raw is None or (scen, metric) not in base:
                continue
            bmodel, bval = base[(scen, metric)]
            new = raw * scale
            rel = "" if bval == 0 else round(100 * (new - bval) / abs(bval), 4)
            rows.append(dict(senaryo=scen, metrik=metric, baz_kosu=baseline_name, baz_model=bmodel,
                             baz=round(bval, 6), model=model, yeni=round(new, 6),
                             fark=round(new - bval, 6), fark_yuzde=rel))
    out = RUN / f"regresyon_{baseline_name}.csv"
    with out.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    print(f"\nRegresyon (baz: {baseline_name}) -> {out.name}")
    for r in rows:
        print(f"{r['senaryo']} {r['metrik']:6s} baz={r['baz']!s:>12} yeni={r['yeni']!s:>12} "
              f"fark={r['fark']!s:>10} ({r['fark_yuzde']!s} %)")


def main():
    global RUN
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--run", default=DEFAULT_RUN, help="runs/ altındaki koşu klasörü")
    ap.add_argument("--baseline", default=None,
                    help="regresyon için baz koşu klasörü (ör. 2026-10-27_dort_senaryo_ilk_kosu)")
    args = ap.parse_args()
    RUN = ROOT / "runs" / args.run
    rows = []
    for scen, model, suffix, vals in circuits():
        for metric, (name, scale) in DISPLAYS.items():
            raw = vals.get(name + suffix)
            sim = None if raw is None else raw * scale
            tgt = TARGETS[scen][metric]
            diff = None if sim is None else sim - tgt
            rows.append(dict(senaryo=scen, model=model, display_soneki=suffix or "-",
                             metrik=metric, hedef=tgt,
                             simulasyon="" if sim is None else round(sim, 4),
                             fark="" if diff is None else round(diff, 4)))
    out = RUN / "karsilastirma.csv"
    with out.open("w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, fieldnames=list(rows[0]))
        w.writeheader()
        w.writerows(rows)
    for r in rows:
        print(f"{r['senaryo']} {r['model'][:22]:22s} {r['metrik']:6s} "
              f"hedef={r['hedef']!s:>8} sim={r['simulasyon']!s:>10} fark={r['fark']!s:>9}")
    if args.baseline:
        regression(args.baseline)


if __name__ == "__main__":
    main()
