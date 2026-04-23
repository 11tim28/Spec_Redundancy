import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from scipy.cluster.hierarchy import dendrogram, linkage

# =========================
# 1. Load Excel
# =========================
file_path = r"C:\UTexas\26S\Perf\project\PinTool\17fp\pca.xlsx"

df = pd.read_excel(file_path, header=0)  
# header=0 → first row = column names (401, 403, ...)

print("Raw shape:", df.shape)
print(df.head())

# =========================
# 2. Transpose Data
# =========================
# Now:
# columns = benchmarks
# rows = features

data = df.T   # rows → benchmarks

# Rename index explicitly (optional but clean)
data.index = ["503", "507", "508", "511", "519", "521", "526", "527", "538", "544", "549"]

print("\nTransposed shape:", data.shape)

# =========================
# 3. Clean Data
# =========================
data = data.apply(pd.to_numeric, errors='coerce')
data = data.dropna()

# =========================
# 4. Normalize
# =========================
scaler = StandardScaler()
scaled_data = scaler.fit_transform(data)

# =========================
# 5. PCA (for interpretation)
# =========================
pca = PCA(n_components=2)
pca_result = pca.fit_transform(scaled_data)

print("\nExplained variance:", pca.explained_variance_ratio_)

# =========================
# 6. Hierarchical Clustering
# =========================
Z = linkage(scaled_data, method='ward')

# =========================
# 7. Genealogy Graph (Dendrogram)
# =========================
plt.figure(figsize=(10, 6))

dendrogram(
    Z,
    labels=data.index.tolist(),
    leaf_font_size=12
)

plt.title("SPEC CPU2017 FP Genealogy (Pin)")
plt.xlabel("Benchmarks")
plt.ylabel("Distance")

plt.grid(True)
plt.show()