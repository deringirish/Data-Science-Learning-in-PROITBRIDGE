# Curse of Dimensionality

Machine Learning suffers from the **Curse of Dimensionality** problem.

### 1. Why Dimensionality Reduction?

Dimensionality reduction is used for two main purposes:

1. **Visualization in Low Dimension:** To represent high-dimensional data in a lower-dimensional space.
2. **Better Interpretability:** To make data easier to understand and interpret.

### 2. Real-Time Applications

1. **VR / AR:** 3D model optimization.
2. **Computer Vision:** Image compression and feature maps.
3. **NLP:** Word embeddings and attention mechanisms.
4. **AI Models:** Used in AI model optimization.

---

# Principal Component Analysis (PCA) Calculation

### Step 1: Dataset Information

| X | Y |
|---|---|
| 4 | 11 |
| 8 | 4 |
| 13 | 5 |
| 7 | 14 |

- Number of features = 2
- Number of observations = 4

### Step 2: Computation of Mean

$$
\bar{x}=\frac{4+8+13+7}{4}=8
$$

$$
\bar{y}=\frac{11+4+5+14}{4}=8.5
$$

### Step 3: Computation of Covariance Matrix

**1. Ordered pairs:**

$$
(X,X), (X,Y), (Y,X), (Y,Y)
$$

**2. Covariance formula:**

$$
Cov(x_i,x_j)=\frac{1}{N-1}\sum_{k=1}^{N}(x_{ik}-\bar{x_i})(x_{jk}-\bar{x_j})
$$

**3. Covariance calculations:**

$$
Cov(X,X)=14
$$

$$
Cov(X,Y)=-11
$$

$$
Cov(Y,X)=-11
$$

$$
Cov(Y,Y)=23
$$

**4. Covariance Matrix:**

$$
S=
\begin{bmatrix}
14 & -11\\
-11 & 23
\end{bmatrix}
$$

### Step 4: Eigenvalues, Eigenvectors and Normalized Eigenvectors

**1. Eigenvalues**

Formula:

$$
\det(S-\lambda I)=0
$$

Since S is a 2 × 2 matrix:

$$
I=
\begin{bmatrix}
1&0\\
0&1
\end{bmatrix}
$$

$$
\lambda I=
\begin{bmatrix}
\lambda&0\\
0&\lambda
\end{bmatrix}
$$

Therefore,

$$
\begin{vmatrix}
14-\lambda&-11\\
-11&23-\lambda
\end{vmatrix}=0
$$

Using cross multiplication:

$$
(14-\lambda)(23-\lambda)-(-11\times-11)=0
$$

$$
\lambda^2-37\lambda+201=0
$$

Quadratic formula:

$$
\lambda=\frac{-b\pm\sqrt{b^2-4ac}}{2a}
$$

Here, $a=1,\ b=-37,\ c=201$.

Final eigenvalues:

$$
\lambda_1=30.3849
$$

$$
\lambda_2=6.6151
$$

Arrange eigenvalues in descending order:

$$
\lambda_1>\lambda_2
$$

- $\lambda_1=30.3849$ → PC1
- $\lambda_2=6.6151$

Choose the highest eigenvalue and proceed further.

**2. Eigenvector of $\lambda_1$**

Formula:

$$
(S-\lambda_1 I)U_1=0
$$

$$
\begin{bmatrix}
14-\lambda_1&-11\\
-11&23-\lambda_1
\end{bmatrix}
\begin{bmatrix}
u_1\\
u_2
\end{bmatrix}=0
$$

Two linear equations:

$$
(14-\lambda_1)u_1-11u_2=0
$$

$$
-11u_1+(23-\lambda_1)u_2=0
$$

From the first equation:

$$
(14-\lambda_1)u_1=11u_2
$$

Eigenvector:

$$
U_1=
\begin{bmatrix}
11\\
14-\lambda_1
\end{bmatrix}
$$

$$
U_1=
\begin{bmatrix}
11\\
-16.3849
\end{bmatrix}
$$

**3. Normalize the Eigenvector**

To normalize an eigenvector, divide the vector by its length.

$$
e_1=
\begin{bmatrix}
\frac{11}{\sqrt{11^2+(-16.3849)^2}}\\
\frac{-16.3849}{\sqrt{11^2+(-16.3849)^2}}
\end{bmatrix}
$$

Normalized eigenvector:

$$
e_1=
\begin{bmatrix}
0.5574\\
-0.8303
\end{bmatrix}
$$

For the second eigenvalue:

$$
e_2=
\begin{bmatrix}
0.8303\\
0.5574
\end{bmatrix}
$$

### Step 5: Derive New Dataset

Formula:

$$
P_{ij}=e_1^T
\begin{bmatrix}
x_{ij}-\bar{x}\\
y_{ij}-\bar{y}
\end{bmatrix}
$$

**Projection calculations:**

For the first observation (4, 11):

$$
P_{11}=
[0.5574\quad -0.8303]
\begin{bmatrix}
4-8\\
11-8.5
\end{bmatrix}
$$

$$
P_{11}=-4.3052
$$

For the second observation (8, 4):

$$
P_{12}=
[0.5574\quad -0.8303]
\begin{bmatrix}
8-8\\
4-8.5
\end{bmatrix}
$$

$$
P_{12}=3.7361
$$

In the same way:

$$
P_{13}=5.6928
$$

$$
P_{14}=-5.1238
$$

**Final 1D Dataset:**

| PC1 |
|---|
| -4.3052 |
| 3.7361 |
| 5.6928 |
| -5.1238 |

So, we get a **1D dataset from 2D data**.

### Step 6: Coordinate System for Principal Components

1. Take the mean point as the base and reconstruct the graph.
2. Draw $e_1$ and $e_2$, i.e., eigenvectors.
3. Connect the mean point and eigenvectors.
4. Plot the original data points.
5. Project the data points onto PC1.

### PCA: 2D to 1D Projection

[Google Colab Image Reference](https://images.openai.com/static-rsc-4/bjPyOUDZem2auArRe6jY3hrrh18im4TqJ4N1yGK40X39mapGaKMGCQy4nzq82INPE3M_sKrYofSsc5q0eM_Q0TS1AjMXJ2G-dO-nsCjLPaAS6-D0EALR-EjFjPIiT5hkDlh5ZFqxCaY0o2AymPXJKmcPCwsmT0GHEEGyy49tMPQ?purpose=inline)

[Google Colab Notebook](https://colab.research.google.com/github/KrishnaswamyLab/SingleCellWorkshop/blob/master/exercises/Dimensionality_Reduction/01_Principal_components_analysis.ipynb?utm_source=chatgpt.com)

- Original data: 2D data points.
- PC1: Direction of the highest eigenvalue.
- Projected data: Data points converted into 1D.

**Final result:** PCA reduces the original 2D dataset into a 1D dataset using the first principal component (PC1).