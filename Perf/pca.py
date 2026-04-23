import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA
from scipy.cluster.hierarchy import dendrogram, linkage

# =========================
# 1. Load Excel
# =========================
file_path = r"C:\UTexas\26S\Perf\project\Perf\06fp.xlsx"

df = pd.read_excel(file_path, header=0)

print("Raw shape:", df.shape)
print(df.head())

# =========================
# 2. Transpose Data
# =========================
data = df.T

# data.index = ["401", "403", "429", "445", "456", "458", "464", "471", "473"]
data.index = ["410","434","435","436","444","453","454","459","465","470","481","482"]
# data.index = ["500", "502", "505", "520", "523", "525", "531", "541", "548", "557"]
# data.index = ["503", "507", "508", "511", "519", "521", "526", "527", "538", "544", "549"]

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
# 5. PCA
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

plt.title("SPEC CPU2006 FP Genealogy (Perf)")
plt.xlabel("Benchmarks")
plt.ylabel("Distance")

plt.grid(True)
plt.show()

# =========================
# 8. PCA Scatter Plot (Dotted)
# =========================
plt.figure(figsize=(8, 6))

# scatter plot (no color specified per instruction)
plt.scatter(pca_result[:, 0], pca_result[:, 1])

# annotate each point
for i, label in enumerate(data.index):
    plt.text(pca_result[i, 0], pca_result[i, 1], label)

plt.title("SPEC CPU2006 FP PCA Scatter Plot (Perf)")
plt.xlabel(f"PC1 ({pca.explained_variance_ratio_[0]*100:.2f}%)")
plt.ylabel(f"PC2 ({pca.explained_variance_ratio_[1]*100:.2f}%)")

plt.grid(True)
plt.show()