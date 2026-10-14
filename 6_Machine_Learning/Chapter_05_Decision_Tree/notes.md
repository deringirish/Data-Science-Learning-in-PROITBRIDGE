# Overfitting, Underfitting, and Generalization in Classification and Regression

### Bias and Variance — Basic Understanding

| Terminology | Association                                                 |
| ----------- | ----------------------------------------------------------- |
| Bias        | Always associated with Training Data (not strictly correct) |
| Variance    | Always associated with Test Data (not strictly correct)     |

Important correction: Bias and variance are not exclusively associated with training or test data. They describe different aspects of a model's learning behaviour. Training and test performance help us identify possible underfitting and overfitting.

### 1. Classification Problems

| Train Data Accuracy | Test Data Accuracy | Terminology Used  | Bias–Variance Trade-off           | Explanation                                                                                          |
| ------------------- | ------------------ | ----------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------- |
| High Accuracy       | Low Accuracy       | Overfitting       | Low Bias, High Variance           | The model learns the training data very well but performs poorly on unseen test data.                |
| Low Accuracy        | Low Accuracy       | Underfitting      | High Bias, Low Variance (usually) | The model fails to learn the underlying patterns and performs poorly on both training and test data. |
| High Accuracy       | High Accuracy      | Generalized Model | Balanced Bias and Variance        | The model learns useful patterns and performs well on both training and unseen test data.            |

### 2. Regression Problems

| Train Data Error | Test Data Error | Terminology Used  | Bias–Variance Trade-off           | Explanation                                                                                         |
| ---------------- | --------------- | ----------------- | --------------------------------- | --------------------------------------------------------------------------------------------------- |
| Low Error        | High Error      | Overfitting       | Low Bias, High Variance           | The model fits the training data very well but produces large errors on unseen test data.           |
| High Error       | High Error      | Underfitting      | High Bias, Low Variance (usually) | The model fails to learn the underlying patterns, resulting in large errors on both datasets.       |
| Low Error        | Low Error       | Generalized Model | Balanced Bias and Variance        | The model captures useful patterns and produces small errors on both training and unseen test data. |

Quick revision:

- High Bias → Underfitting
- High Variance → Overfitting
- Good balance → Good Generalization

Note: These are typical patterns, not absolute rules. In particular, a generalized model does not need perfectly equal bias and variance; it needs an appropriate balance that supports good performance on unseen data.








# Hyperparameter Tuning and GridSearchCV

## 1. Hyperparameter Tuning

**Definition:** Hyperparameter tuning is the process of finding the best combination of settings (hyperparameters) to improve a machine learning model's performance on unseen data.

Hyperparameters are settings chosen before training or controlled by the training procedure. Unlike model parameters, they are not learned directly from the training data.

### Examples

| Algorithm | Hyperparameter | Purpose |
|---|---|---|
| Decision Tree | `max_depth` | Controls the maximum depth of the tree |
| K-Nearest Neighbors (KNN) | `n_neighbors` | Specifies the number of neighbours considered |
| Random Forest | `n_estimators` | Specifies the number of trees |
| Logistic Regression | `C` | Controls regularization strength inversely |

## 2. GridSearchCV

**Definition:** `GridSearchCV` is a Scikit-learn tool for hyperparameter tuning. It tests every specified combination of hyperparameter values using cross-validation and selects the best-performing combination according to a chosen scoring metric.

### Example: Decision Tree Classification

```python
from sklearn.model_selection import GridSearchCV
from sklearn.tree import DecisionTreeClassifier

# Create the model
model = DecisionTreeClassifier(random_state=42)

# Define hyperparameters to test
param_grid = {
    "max_depth": [2, 5, 10],
    "min_samples_split": [2, 5]
}

# Apply GridSearchCV
grid_search = GridSearchCV(
    estimator=model,
    param_grid=param_grid,
    cv=5,
    scoring="accuracy"
)

# Tune using training data
grid_search.fit(X_train, y_train)

# Get the best model and parameters
best_model = grid_search.best_estimator_

print("Best parameters:", grid_search.best_params_)
print("Best CV score:", grid_search.best_score_)
```

**How many fits?**

- `max_depth` has 3 values.
- `min_samples_split` has 2 values.
- Total combinations = 3 × 2 = 6.
- With `cv=5`, total model fits = 6 × 5 = **30 fits**.

## 3. Where GridSearchCV Fits in the ML Workflow

1. Load and prepare the dataset.
2. Separate features (`X`) and target (`y`).
3. Split the data using `train_test_split()`.
4. Define the model and hyperparameter grid.
5. Run `GridSearchCV` using only `X_train` and `y_train`.
6. Retrieve the best model using `best_estimator_`.
7. Evaluate the final model on the untouched test set (`X_test`, `y_test`).

### Example: Train-Test Split

```python
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X, y,
    test_size=0.2,
    random_state=42,
    stratify=y
)
```

**Note:** `stratify=y` is useful for classification when you want to preserve class proportions in both sets. For regression, it is generally omitted unless a suitable stratification strategy is deliberately used.

## 4. Important GridSearchCV Terms

| Term | Meaning |
|---|---|
| `param_grid` | Hyperparameter values and combinations to test |
| `cv=5` | Uses five-fold cross-validation on the training data |
| `scoring` | Metric used to compare configurations, such as `accuracy` |
| `best_params_` | The best hyperparameter combination found |
| `best_score_` | Mean cross-validation score for the best combination |
| `best_estimator_` | Best model, refitted on the full training data |

## 5. Evaluate the Best Model

```python
from sklearn.metrics import accuracy_score

# Predict on unseen test data
y_pred = best_model.predict(X_test)

# Evaluate the model
print("Test accuracy:", accuracy_score(y_test, y_pred))
```

For regression problems, use suitable metrics such as MAE, RMSE, or R² instead of classification accuracy.

## Key Takeaways

- **Hyperparameter tuning** is the overall process of selecting suitable model settings.
- **GridSearchCV** is one method for performing hyperparameter tuning.
- Apply it after splitting the data, using training data only.
- Keep the test set untouched until final evaluation.
- When preprocessing is needed, use a Scikit-learn `Pipeline` with `GridSearchCV` to help prevent data leakage during cross-validation.