import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.compose import ColumnTransformer, TransformedTargetRegressor
from sklearn.pipeline import Pipeline

from sklearn.preprocessing import (
    StandardScaler,
    MinMaxScaler,
    OneHotEncoder,
    OrdinalEncoder,
    LabelEncoder
)

from sklearn.impute import SimpleImputer

from sklearn.linear_model import LogisticRegression, LinearRegression
from sklearn.metrics import (
    accuracy_score,
    classification_report,
    mean_absolute_error,
    mean_squared_error,
    r2_score
)


# =====================================================
# 1. LOAD DATASET
# =====================================================

df = pd.read_csv("your_dataset.csv")

TARGET_COLUMN = "target"

X = df.drop(columns=[TARGET_COLUMN])
y = df[TARGET_COLUMN]


# =====================================================
# 2. DEFINE INPUT FEATURES
# =====================================================

numerical_features = ["Age", "Salary", "Experience"]

nominal_features = ["Gender", "City"]

ordinal_features = ["Education"]

ordinal_categories = [
    ["School", "Bachelor", "Master", "PhD"]
]


# =====================================================
# 3. TRAIN TEST SPLIT
# =====================================================

X_train, X_test, y_train, y_test = train_test_split(
    X,
    y,
    test_size=0.2,
    random_state=42
)


# =====================================================
# 4. NUMERICAL INPUT PIPELINE
# =====================================================

numerical_pipeline = Pipeline([
    ("imputer", SimpleImputer(strategy="mean")),
    ("scaler", StandardScaler())
])


# =====================================================
# 5. NOMINAL CATEGORICAL INPUT PIPELINE
# =====================================================

nominal_pipeline = Pipeline([
    ("imputer", SimpleImputer(strategy="most_frequent")),
    ("encoder", OneHotEncoder(handle_unknown="ignore"))
])


# =====================================================
# 6. ORDINAL CATEGORICAL INPUT PIPELINE
# =====================================================

ordinal_pipeline = Pipeline([
    ("imputer", SimpleImputer(strategy="most_frequent")),
    ("encoder", OrdinalEncoder(
        categories=ordinal_categories,
        handle_unknown="use_encoded_value",
        unknown_value=-1
    ))
])


# =====================================================
# 7. COMBINE INPUT TRANSFORMATIONS
# =====================================================

preprocessor = ColumnTransformer([
    ("num", numerical_pipeline, numerical_features),
    ("nominal", nominal_pipeline, nominal_features),
    ("ordinal", ordinal_pipeline, ordinal_features)
])


# =====================================================
# 8. CLASSIFICATION (CATEGORICAL OUTPUT)
# =====================================================

# Encode target
label_encoder = LabelEncoder()

y_train_encoded = label_encoder.fit_transform(y_train)
y_test_encoded = label_encoder.transform(y_test)

classification_model = Pipeline([
    ("preprocessor", preprocessor),
    ("classifier", LogisticRegression(max_iter=1000))
])

# Train
classification_model.fit(X_train, y_train_encoded)

# Predict
y_pred = classification_model.predict(X_test)

# Original target labels
y_pred_original = label_encoder.inverse_transform(y_pred)

print("\n========== CLASSIFICATION ==========")
print("Accuracy:", accuracy_score(y_test_encoded, y_pred))
print(classification_report(y_test_encoded, y_pred))


# =====================================================
# 9. REGRESSION (CONTINUOUS OUTPUT)
# =====================================================

regression_pipeline = Pipeline([
    ("preprocessor", preprocessor),
    ("regressor", LinearRegression())
])

regression_model = TransformedTargetRegressor(
    regressor=regression_pipeline,
    transformer=StandardScaler()
)

# Train
regression_model.fit(X_train, y_train)

# Predict (automatically inverse-transformed)
y_pred_regression = regression_model.predict(X_test)

print("\n========== REGRESSION ==========")
print("MAE:", mean_absolute_error(y_test, y_pred_regression))
print("MSE:", mean_squared_error(y_test, y_pred_regression))
print("R2 Score:", r2_score(y_test, y_pred_regression))