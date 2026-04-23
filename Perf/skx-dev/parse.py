import os
import re
import pandas as pd

# -----------------------------
# Benchmark classification
# -----------------------------
spec2006_int = {401, 403, 429, 445, 456, 458, 464, 471, 473}
spec2006_fp  = {410, 434, 435, 436, 444, 453, 454, 459, 465, 470, 482}

spec2017_int = {500, 502, 505, 520, 523, 525, 531, 541, 548, 557}
spec2017_fp  = {503, 507, 508, 511, 519, 521, 526, 527, 538, 544, 549, 554}

# -----------------------------
# Target metrics
# -----------------------------
INT_METRICS = [
    "instructions",
    "L1-icache-load-misses",
    "branches",
    "branch-misses",
    "l2_rqsts.demand_data_rd_miss",
    "iTLB-load-misses"
]

FP_METRICS = [
    "instructions",
    "mem_inst_retired.all_loads",
    "l2_rqsts.demand_data_rd_miss",
    "l2_rqsts.all_demand_data_rd",
    "dTLB-load-misses",
    "L1-dcache-load-misses"
]

# Normalize names (handle '-' vs '_')
def normalize(name):
    return name.replace("-", "_")

# -----------------------------
# Regex
# -----------------------------
metric_pattern = re.compile(r"\s*([\d,]+)\s+([a-zA-Z0-9_\-\.]+)")

def parse_section(text):
    raw_data = {}

    for line in text.splitlines():
        # print(line)
        match = metric_pattern.match(line)
        if match:
            value = int(match.group(1).replace(",", ""))
            key = normalize(match.group(2))
            # if(match.group(3)):
            #     print(match.group(2), match.group(3))
            raw_data[key] = value

    return raw_data

def extract_sections(content):
    int_section = ""
    fp_section = ""

    int_match = re.search(r"integer benchmark:(.*?)(floating-point benchmark:)", content, re.S)
    fp_match = re.search(r"floating-point benchmark:(.*)", content, re.S)

    if int_match:
        int_section = int_match.group(1)
    if fp_match:
        fp_section = fp_match.group(1)

    return int_section, fp_section

# -----------------------------
# Extract only required metrics
# -----------------------------
def filter_metrics(raw_data, metric_list):
    result = {}
    for m in metric_list:
        key = normalize(m)
        result[m] = raw_data.get(key, 0)
    return result

# -----------------------------
# Storage
# -----------------------------
data_2006_int = []
data_2006_fp = []
data_2017_int = []
data_2017_fp = []

# -----------------------------
# Main loop
# -----------------------------
for file in os.listdir("."):
    # print(file)
    if not file.endswith(".txt"):
        continue

    match = re.match(r"(\d+)\.txt$", file)
    if not match:
        continue  # skip files like build_run.txt

    bench_id = int(match.group(1))

    with open(file, "r") as f:
        content = f.read()

    raw_data = parse_section(content)

    int_data = filter_metrics(raw_data, INT_METRICS)
    fp_data = filter_metrics(raw_data, FP_METRICS)

    int_data["benchmark"] = bench_id
    fp_data["benchmark"] = bench_id
    # print(bench_id)

    # Classification
    if bench_id in spec2006_int:
        data_2006_int.append(int_data)
    elif bench_id in spec2006_fp:
        data_2006_fp.append(fp_data)
    elif bench_id in spec2017_int:
        data_2017_int.append(int_data)
    elif bench_id in spec2017_fp:
        data_2017_fp.append(fp_data)

print("2006 INT:", len(data_2006_int))
print("2006 FP :", len(data_2006_fp))
print("2017 INT:", len(data_2017_int))
print("2017 FP :", len(data_2017_fp))

# -----------------------------
# Convert to DataFrames
# -----------------------------
def make_df(data, metrics):
    if len(data) == 0:
        return pd.DataFrame()

    df = pd.DataFrame(data)

    # Ensure all expected columns exist
    for m in metrics:
        if m not in df.columns:
            df[m] = 0

    # Set benchmark as index
    df = df.set_index("benchmark")

    # Keep only metric columns (in order)
    df = df[metrics]

    # Transpose: rows ↔ columns
    df = df.T

    # Sort columns (benchmarks)
    df = df.sort_index(axis=1)

    return df

df_2006_int = make_df(data_2006_int, INT_METRICS)
df_2006_fp  = make_df(data_2006_fp, FP_METRICS)
df_2017_int = make_df(data_2017_int, INT_METRICS)
df_2017_fp  = make_df(data_2017_fp, FP_METRICS)

# -----------------------------
# Save Excel
# -----------------------------
with pd.ExcelWriter("spec2006.xlsx") as writer:
    df_2006_int.to_excel(writer, sheet_name="INT")
    df_2006_fp.to_excel(writer, sheet_name="FP")

with pd.ExcelWriter("spec2017.xlsx") as writer:
    df_2017_int.to_excel(writer, sheet_name="INT")
    df_2017_fp.to_excel(writer, sheet_name="FP")

print("✅ Done! Generated spec2006.xlsx and spec2017.xlsx")





