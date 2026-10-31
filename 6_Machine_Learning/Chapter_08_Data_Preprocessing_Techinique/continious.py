import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline

from sklearn.preprocessing import (
    StandardScaler,
    OneHotEncoder,
    OrdinalEncoder
)

from sklearn.impute import SimpleImputer
from sklearn.linear_model import LinearRegression
from sklearn.metrics import (
    mean_absolute_error,
    mean_squared_error,
    r2_score
)


# ==========================================
# 1. LOAD DATA
# ==========================================

df = pd.read_csv("dataset.csv")

X = df.drop(columns=["target"])
y = df["target"]


# ==========================================
# 2. DEFINE INPUT FEATURES
# ==========================================

numerical_features = ["Age", "Salary", "Experience"]

nominal_features = ["Gender", "City"]

ordinal_features = ["Education"]

ordinal_categories = [
    ["School", "Bachelor", "Master", "PhD"]
]


# ==========================================
# 3. TRAIN TEST SPLIT
# ==========================================

X_train, X_test, y_train, y_test = train_test_split(
    X, y,
    test_size=0.2,
    random_state=42
)


# ==========================================
# 4. NUMERICAL PIPELINE
# ==========================================

numerical_pipeline = Pipeline([
    ("imputer", SimpleImputer(strategy="median")),
    ("scaler", StandardScaler())
])


# ==========================================
# 5. NOMINAL CATEGORICAL PIPELINE
# ==========================================

nominal_pipeline = Pipeline([
    ("imputer", SimpleImputer(strategy="most_frequent")),
    ("encoder", OneHotEncoder(handle_unknown="ignore"))
])


# ==========================================
# 6. ORDINAL CATEGORICAL PIPELINE
# ==========================================

ordinal_pipeline = Pipeline([
    ("imputer", SimpleImputer(strategy="most_frequent")),
    ("encoder", OrdinalEncoder(
        categories=ordinal_categories,
        handle_unknown="use_encoded_value",
        unknown_value=-1
    ))
])


# ==========================================
# 7. COMBINE INPUT TRANSFORMATIONS
# ==========================================

preprocessor = ColumnTransformer([
    ("num", numerical_pipeline, numerical_features),
    ("nominal", nominal_pipeline, nominal_features),
    ("ordinal", ordinal_pipeline, ordinal_features)
])


# ==========================================
# 8. MODEL PIPELINE
# ==========================================

model = Pipeline([
    ("preprocessor", preprocessor),
    ("regressor", LinearRegression())
])


# ==========================================
# 9. TRAIN AND PREDICT
# ==========================================

model.fit(X_train, y_train)

y_pred = model.predict(X_test)


# ==========================================
# 10. EVALUATION
# ==========================================

print("MAE:", mean_absolute_error(y_test, y_pred))

print("MSE:", mean_squared_error(y_test, y_pred))

print("RMSE:", mean_squared_error(y_test, y_pred) ** 0.5)

print("R2 Score:", r2_score(y_test, y_pred))