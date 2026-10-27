"""12.10.2026 paketinin değiştirilmemiş koşusunu deney hedefleriyle karşılaştırır.

Girdi : runs/2026-10-27_dort_senaryo_ilk_kosu/results/<model>/display_degerleri_eslesik.csv
        (extract_umit_display_values_20261027.m çıktısı; Display adı -> son değer)
Çıktı : runs/2026-10-27_dort_senaryo_ilk_kosu/karsilastirma.csv
Çağrı : python -I scripts/compare_umit_dort_senaryo_20261027.py   (proje kökünden)

Senaryo 1+2 modelinde "1" sonekli Display'ler ikinci devreye aittir; hangi
devrenin hangi senaryo olduğu Vdc değerinden doğrulanır (S1 431,5 V, S2 395 V).
Modeldeki THD ve verim kesir olarak verilir; yüzdeye çevrilir.
"""
import csv
import pathlib

ROOT = pathlib.Path(__file__).resolve().parents[1]
RUN = ROOT / "runs" / "2026-10-27_dort_senaryo_ilk_kosu"

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


def load(model):
    path = RUN / "results" / model / "display_degerleri_eslesik.csv"
    if not path.exists():
        return None
    with path.open(encoding="utf-8-sig") as f:
        return {row["display"]: float(row["son_deger"]) for row in csv.DictReader(f)}


def circuits():
    s12 = load("inverter_scenario1_parametric5_etiquetli")
    if s12:
        for suffix in ("", "1"):
            vdc = s12.get("Vdc" + suffix)
            scen = "S1" if vdc is not None and abs(vdc - 431.5) < abs(vdc - 395) else "S2"
            yield scen, "inverter_scenario1_parametric5_etiquetli", suffix, s12
    for model in ("inverter_senaryo3", "inverter_senaryo4"):
        vals = load(model)
        if vals:
            yield "S3", model, "", vals


def main():
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


if __name__ == "__main__":
    main()
