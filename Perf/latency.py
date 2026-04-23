import os
import re
import pandas as pd

# ===== CONFIG =====
folders = ["vm-small", "dev", "spr", "skx-dev"]

# benchmarks = ["401", "403", "429", "445", "456", "458", "464", "471", "473"]
# benchmarks = ["410","434","435","436","444","453","454","459","465","470","481","482"]
# benchmarks = ["500", "502", "505", "520", "523", "525", "531", "541", "548", "557"]
benchmarks = ["503", "507", "508", "511", "519", "521", "526", "527", "538", "544", "549"]

# Regex to extract time
time_pattern = re.compile(r"([\d\.]+)\s+seconds time elapsed")

# ===== STORAGE =====
results = {}

# ===== MAIN LOOP =====
for bench in benchmarks:
    results[bench] = {}

    for folder in folders:
        file_path = os.path.join(folder, f"{bench}.txt")

        if not os.path.exists(file_path):
            print(f"Warning: {file_path} not found")
            results[bench][folder] = None
            continue

        with open(file_path, "r") as f:
            content = f.read()

        match = time_pattern.search(content)

        if match:
            time_val = float(match.group(1))
            results[bench][folder] = time_val
        else:
            print(f"Warning: time not found in {file_path}")
            results[bench][folder] = None

# ===== CREATE DATAFRAME =====
df = pd.DataFrame.from_dict(results, orient="index")

# Sort rows (benchmarks numerically)
df.index = df.index.astype(int)
df = df.sort_index()
df.index = df.index.astype(str)

# Ensure column order
df = df[folders]

# ===== SAVE TO EXCEL =====
output_file = "17fp_time.xlsx"
df.to_excel(output_file)

print(f"✅ Saved to {output_file}")