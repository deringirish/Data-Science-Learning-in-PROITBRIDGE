# How to Choose Between Label Encoding, One-Hot Encoding, and Ordinal Encoding

## 1. What Is Encoding?

Machine learning models generally work with numerical values. However, real-world datasets often contain categorical values such as:

- `Weather`: Sunny, Rainy, Cloudy
- `Color`: Red, Green, Blue
- `City`: Chennai, Bengaluru, Mumbai
- `Size`: Small, Medium, Large

**Encoding** is the process of converting categorical values into a numerical representation that a machine learning model can use.

There is no single encoding method that is best for every situation. The right choice depends on:

1. Whether the categories have a meaningful order.
2. Whether the column is an input feature (`X`) or the target/output (`y`).
3. How the chosen machine learning algorithm handles categorical features.

---

## 2. The Three Main Encoding Methods

### 2.1 Label Encoding

Label encoding assigns an integer to each category.

Example:

| Color | Encoded value |
|---|---:|
| Red | 0 |
| Green | 1 |
| Blue | 2 |

The encoder creates a mapping from categories to integers. The numbers are identifiers; they do not automatically represent meaningful quantities.

#### Potential issue

For a feature such as `Color`, the categories have no natural order. However, some algorithms may interpret the values as if `Blue > Green > Red`.

This can create an **artificial order** that was not present in the original data.

#### When is it useful?

- Commonly used to encode classification target labels (`y`) when numerical labels are needed.
- May be suitable for some categorical input features with certain tree-based algorithms, depending on the implementation.
- May be suitable when integer values genuinely represent ordered or meaningful quantities, although ordinal encoding is usually clearer for ordered categories.

**Important:** In scikit-learn, `LabelEncoder` is designed primarily for target labels (`y`), not general input columns (`X`). For ordered input categories, consider `OrdinalEncoder`. For nominal input categories, consider `OneHotEncoder`.

Example in scikit-learn:

```python
from sklearn.preprocessing import LabelEncoder

label_encoder = LabelEncoder()

y_encoded = label_encoder.fit_transform(y)
```

To see the mapping:

```python
dict(zip(
    label_encoder.classes_,
    label_encoder.transform(label_encoder.classes_)
))
```

The exact mapping depends on the classes learned by the encoder.

---

### 2.2 One-Hot Encoding (OHE)

One-Hot Encoding creates a separate binary column for each category. A value of `1` indicates the category is present; `0` indicates it is not.

Example: `Color` contains Red, Green, and Blue.

Original data:

| Color |
|---|
| Red |
| Green |
| Blue |
| Red |

After One-Hot Encoding:

| Color_Red | Color_Green | Color_Blue |
|---:|---:|---:|
| 1 | 0 | 0 |
| 0 | 1 | 0 |
| 0 | 0 | 1 |
| 1 | 0 | 0 |

#### Why is it useful?

- It avoids assigning an artificial ranking to nominal categories.
- It works well as a general default for nominal categorical input features.
- It is commonly used with linear models, logistic regression, SVMs, and many other algorithms.

#### Possible disadvantages

- It increases the number of features. A column with 20 categories may create 20 new columns.
- High-cardinality features (for example, thousands of unique customer IDs) can create a very wide dataset.
- For distance-based algorithms such as KNN, one-hot features affect distance calculations, so scaling and feature representation should be considered carefully.

Example:

```python
from sklearn.preprocessing import OneHotEncoder

encoder = OneHotEncoder(handle_unknown="ignore")

X_encoded = encoder.fit_transform(X)
```

By default, scikit-learn's `OneHotEncoder` returns a sparse matrix. That is often memory-efficient. Use `sparse_output=False` if you specifically need a dense array (scikit-learn 1.2+).

---

### 2.3 Ordinal Encoding

Ordinal encoding assigns numerical values to categories that have a meaningful order.

Example: `Size`

| Size | Encoded value |
|---|---:|
| Small | 0 |
| Medium | 1 |
| Large | 2 |

The numbers reflect the order of the categories.

Other examples:

- Low < Medium < High
- Beginner < Intermediate < Advanced
- Poor < Fair < Good < Excellent

#### Important consideration

Ordinal encoding preserves order, but it also represents categories using numbers. Some models may treat the numerical gaps as meaningful—for example, the difference between 0 and 1 as equal to the difference between 1 and 2. That assumption may or may not suit the problem.

For scikit-learn input features, use `OrdinalEncoder` and specify the intended category order when necessary:

```python
from sklearn.preprocessing import OrdinalEncoder

encoder = OrdinalEncoder(
    categories=[["Small", "Medium", "Large"]]
)

X_size_encoded = encoder.fit_transform(X[["Size"]])
```

---

## 3. How to Choose an Encoding Method for Input Features (`X`)

Input features are the columns the model uses to make predictions.

### 3.1 Nominal categories: usually use One-Hot Encoding

**Nominal data has no natural order.**

Examples:

- Color: Red, Green, Blue
- City: Chennai, Bengaluru, Mumbai
- Weather: Sunny, Rainy, Cloudy
- Payment method: Cash, Card, UPI

For these features, One-Hot Encoding is a sensible general-purpose choice because it does not create a numerical ranking between categories.

### 3.2 Ordered categories: consider Ordinal Encoding

**Ordinal data has a meaningful order.**

Examples:

- Size: Small, Medium, Large
- Satisfaction: Low, Medium, High
- Education level: categories with a defined order

Use `OrdinalEncoder` with an explicitly defined order when that order matters.

### 3.3 Do not choose based only on parametric versus non-parametric models

A rule such as “parametric models always use One-Hot Encoding and non-parametric models always use Label Encoding” is **not correct**.

The category type and the algorithm's handling of numeric inputs are more useful guides.

| Algorithm | Common starting point for nominal categorical features | Notes |
|---|---|---|
| Linear Regression / Logistic Regression | One-Hot Encoding | Integer codes may incorrectly imply a linear ordering. |
| Support Vector Machine (SVM) | One-Hot Encoding | Numeric category codes may imply an artificial order or distance. |
| K-Nearest Neighbors (KNN) | Often One-Hot Encoding | Encoding changes distances; feature scaling and distance behavior matter. |
| Decision Tree | One-Hot Encoding is a safe general option | Integer codes may create arbitrary threshold splits. |
| Random Forest | One-Hot Encoding is a safe general option | Native categorical support depends on the specific implementation. |
| Gradient-boosted trees | Depends on the library and configuration | Some libraries support categorical features directly. |

These are starting points, not absolute rules. Model implementation, number of categories, dataset size, and validation performance can affect the final choice.

---

## 4. How to Encode the Output / Target (`y`)

The target is what the model is trying to predict. The appropriate treatment depends on the type of prediction task.

### 4.1 Classification target

Classification predicts a class or category.

Examples:

- Spam / Not Spam
- Pass / Fail
- Cat / Dog
- Weather type

Many scikit-learn classifiers can accept string class labels directly. Therefore, encoding `y` is not always required.

If numeric labels are needed, `LabelEncoder` can be used:

```python
from sklearn.preprocessing import LabelEncoder

label_encoder = LabelEncoder()

y_train_encoded = label_encoder.fit_transform(y_train)
```

If you encode the target, keep the fitted encoder so predictions can be converted back to their original labels:

```python
y_pred_encoded = model.predict(X_test)
y_pred_labels = label_encoder.inverse_transform(y_pred_encoded)
```

This inverse transformation is appropriate when the model was trained on the encoded target. Do not apply it if the model was trained directly on the original string labels.

**Do not use One-Hot Encoding for the target by default.** Many scikit-learn classifiers expect a one-dimensional target array. One-hot targets are needed only for specific workflows or models that explicitly require them.

### 4.2 Regression target

Regression predicts a numerical quantity.

Examples:

- House price
- Temperature
- Salary
- Sales revenue

Keep a continuous numerical target numeric. Do **not** use `LabelEncoder` to convert different prices into category IDs, because the model needs to predict the actual numerical value.

Example:

| House | Price (`y`) |
|---|---:|
| A | 2,000,000 |
| B | 3,500,000 |
| C | 5,000,000 |

These are numerical values, not class labels.

### 4.3 Ordinal target

Sometimes the target consists of ordered classes, such as Low, Medium, and High. These can be represented in an ordered way if the chosen modelling approach supports that interpretation. However, ordinary classification models may treat classes as separate labels rather than learning the order automatically.

---

## 5. Quick Decision Table

| Data situation | Common choice | Reason |
|---|---|---|
| Nominal input feature with a few categories | One-Hot Encoding | Avoids artificial ranking |
| Ordered input feature | Ordinal Encoding | Preserves the meaningful order |
| Classification target that needs numeric labels | Label Encoding | Maps classes to integer IDs |
| Classification target accepted as strings by the model | Keep original labels if convenient | Encoding may be unnecessary |
| Continuous regression target | Keep numeric | The model predicts a quantity |
| Input feature with many unique categories | Consider alternatives carefully | One-hot encoding can create many columns |
| Tree-based model with categorical support | Native support or encoding recommended by that library | Behavior varies by implementation |

---

## 6. Practical scikit-learn Workflow with `ColumnTransformer` and `Pipeline`

For input features, it is usually best to place preprocessing inside a scikit-learn pipeline. The pipeline fits preprocessing on the training data, transforms the features, and passes them to the model. During prediction, it applies the same fitted preprocessing automatically.

```python
from sklearn.compose import ColumnTransformer
from sklearn.preprocessing import OneHotEncoder
from sklearn.pipeline import make_pipeline
from sklearn.tree import DecisionTreeClassifier

categorical_cols = X_train.select_dtypes(
    include=["object", "category", "str"]
).columns.tolist()

numerical_cols = X_train.select_dtypes(
    include=["number"]
).columns.tolist()

preprocessor = ColumnTransformer(
    transformers=[
        ("num", "passthrough", numerical_cols),
        ("cat", OneHotEncoder(handle_unknown="ignore"), categorical_cols)
    ]
)

model = make_pipeline(
    preprocessor,
    DecisionTreeClassifier(random_state=42)
)

model.fit(X_train, y_train)

y_pred = model.predict(X_test)
```

### What happens here?

1. `categorical_cols` identifies categorical input columns.
2. `numerical_cols` identifies numerical input columns.
3. `ColumnTransformer` passes numerical columns through and one-hot encodes categorical columns.
4. `make_pipeline` connects the preprocessing stage to the classifier.
5. `model.fit()` fits the encoder and trains the classifier.
6. `model.predict()` applies the same fitted preprocessing to new input data before making predictions.

You do not need to manually replace the original DataFrame with the transformed data. The transformation happens internally in the pipeline.

**Important:** This example assumes missing values have already been handled. If numerical or categorical inputs contain missing values, add an appropriate imputation step to the pipeline. Fit all preprocessing using training data only to avoid data leakage.

---

## 7. Common Mistakes to Avoid

1. **Using `LabelEncoder` on nominal input features without considering the consequences.** Integer codes can create an artificial order.
2. **Assuming every non-parametric model should use label encoding.** This is not a reliable rule.
3. **Encoding a continuous regression target as class IDs.** This destroys the meaning of the numeric target.
4. **Assuming the target always needs encoding.** Many classifiers accept string class labels directly.
5. **Fitting a new encoder on test or prediction data.** Fit preprocessing on training data and reuse the fitted transformer.
6. **Ignoring unseen categories.** `OneHotEncoder(handle_unknown="ignore")` prevents an error when a new category appears at prediction time. The unseen category is represented with zeros across the encoder's known category columns.
7. **Forgetting the increase in feature count.** One-hot encoding replaces a categorical column with multiple binary columns.
8. **Preprocessing the entire dataset before splitting into train and test sets.** Split first, then fit preprocessing within a pipeline on training data to reduce leakage risk.

---

## 8. Final Rules to Remember

- **No natural order?** Usually use One-Hot Encoding for nominal input features.
- **Meaningful order?** Consider Ordinal Encoding.
- **Classification target?** Label encoding is optional when the classifier accepts string labels; use it when numeric labels are needed.
- **Regression target?** Keep a continuous target numeric.
- **Using scikit-learn?** Put preprocessing inside a `Pipeline` or use a `ColumnTransformer` within the pipeline.
- **Unsure which method performs best?** Compare reasonable approaches using cross-validation and an appropriate evaluation metric.

The best encoding method is the one that represents the data appropriately and works well for your modelling task—not one chosen solely by whether the algorithm is parametric or non-parametric.


---

## 9. Understanding the Three Encoders with Simple Examples

This section explains **Label Encoding, One-Hot Encoding, and Ordinal Encoding** in simple terms. It is added as an extra reference section; the notes above remain unchanged.

### 9.1 Label Encoding

**Label Encoding assigns an integer to each category.**

Example: a `Weather` column.

| Weather | Encoded value |
|---|---:|
| Cloudy | 0 |
| Rainy | 1 |
| Sunny | 2 |

These numbers are category labels. They do **not** mean that Sunny is greater than Rainy or that Rainy is greater than Cloudy.

**When is it commonly used?**

- For classification target labels (`y`), when numerical class labels are needed.
- In some other situations where integer category codes are suitable for the chosen algorithm.

**Remember:** In scikit-learn, `LabelEncoder` is intended mainly for target labels (`y`). For categorical input columns (`X`), consider `OneHotEncoder` or `OrdinalEncoder`, depending on whether the categories have a meaningful order.

Example:

```python
from sklearn.preprocessing import LabelEncoder

encoder = LabelEncoder()

y_encoded = encoder.fit_transform(y)
```

### 9.2 One-Hot Encoding

**One-Hot Encoding creates a separate binary column for each category.**

Example: a `Color` column containing Red, Green, and Blue.

Before encoding:

| Color |
|---|
| Red |
| Green |
| Blue |

After encoding:

| Color_Red | Color_Green | Color_Blue |
|---:|---:|---:|
| 1 | 0 | 0 |
| 0 | 1 | 0 |
| 0 | 0 | 1 |

A `1` marks the category that applies, while the other columns contain `0`.

**When is it commonly used?**

- For nominal input features that have no natural order.
- Examples include city, color, weather type, and payment method.

**Remember:** One categorical column may become multiple columns. A fitted preprocessing pipeline can handle this transformation automatically during training and prediction.

Example:

```python
from sklearn.preprocessing import OneHotEncoder

encoder = OneHotEncoder(handle_unknown="ignore")

X_encoded = encoder.fit_transform(X)
```

### 9.3 Ordinal Encoding

**Ordinal Encoding converts categories into numbers while preserving a meaningful order.**

Example: a `Satisfaction` column.

| Satisfaction | Encoded value |
|---|---:|
| Low | 0 |
| Medium | 1 |
| High | 2 |
| Very High | 3 |

The order matters:

**Low < Medium < High < Very High**

Unlike colors or cities, these categories have a meaningful ranking.

**When is it commonly used?**

- For ordered categories such as Small / Medium / Large.
- For levels such as Low / Medium / High.
- For ratings such as Poor / Fair / Good / Excellent.

Example:

```python
from sklearn.preprocessing import OrdinalEncoder

encoder = OrdinalEncoder(
    categories=[["Low", "Medium", "High", "Very High"]]
)

X_encoded = encoder.fit_transform(X[["Satisfaction"]])
```

Specifying `categories` explicitly makes the intended order clear.

**Remember:** Ordinal Encoding represents the order, but some models may also treat the numerical gaps as meaningful. Use it when that representation makes sense for your problem.

---

### 9.4 Compare the Three Encoders

| Method | Example | Main idea | Common use |
|---|---|---|---|
| Label Encoding | Spam → 1, Not Spam → 0 | Assign an integer label to each class | Classification target (`y`), when needed |
| One-Hot Encoding | City → separate binary columns | Create one column per category | Nominal input features with no natural order |
| Ordinal Encoding | Low → 0, Medium → 1, High → 2 | Preserve meaningful category order | Ordered input features |

### 9.5 A Quick Way to Decide

1. **Does the category have no natural order?** One-Hot Encoding is usually a good starting point for an input feature.
2. **Does the category have a meaningful order?** Consider Ordinal Encoding and specify the order.
3. **Is it a classification target?** Label Encoding can be used if numeric labels are needed; many classifiers can also work directly with string labels.
4. **Is it a continuous regression target, such as price or temperature?** Keep it numeric. Do not turn each numerical value into a class label.

**Final reminder:** Do not choose an encoder only based on whether an algorithm is parametric or non-parametric. Consider the meaning of the categories, the model's behavior, and validation results.
