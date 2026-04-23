import pandas as pd
import os

# List of your benchmark file names (without .txt)
benchmarks = ["500", "502", "505", "520", "523", "525", "531", "541", "548", "557"]
# benchmarks = ["503", "507", "508", "511", "519", "521", "526", "527", "538", "544", "549"]

data = {}

for b in benchmarks:
    filename = f"{b}.txt"
    
    if not os.path.exists(filename):
        print(f"Warning: {filename} not found, skipping.")
        continue

    with open(filename, "r") as f:
        lines = [line.strip() for line in f if line.strip() != ""]

    # Convert values (handle %, floats, scientific notation)
    parsed = []
    for val in lines:
        if val.endswith('%'):
            parsed.append(float(val.strip('%')) / 100.0)
        else:
            try:
                parsed.append(float(val))
            except ValueError:
                parsed.append(val)  # fallback (string if needed)

    data[b] = parsed

# Convert to DataFrame (columns = benchmarks)
df = pd.DataFrame(dict([(k, pd.Series(v)) for k, v in data.items()]))

# Save to Excel
output_file = "data.xlsx"
df.to_excel(output_file, index=False)

print(f"Saved to {output_file}")