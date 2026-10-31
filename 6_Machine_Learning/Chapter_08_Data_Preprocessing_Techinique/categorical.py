import pandas as pd

from sklearn.model_selection import train_test_split
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline

from sklearn.preprocessing import (
    StandardScaler,
    OneHotEncoder,
    OrdinalEncoder,
    LabelEncoder
)

from sklearn.impute import SimpleImputer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report


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
    random_state=42,
    stratify=y
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
# 8. ENCODE OUTPUT TARGET
# ==========================================

label_encoder = LabelEncoder()

y_train = label_encoder.fit_transform(y_train)
y_test = label_encoder.transform(y_test)


# ==========================================
# 9. MODEL PIPELINE
# ==========================================

model = Pipeline([
    ("preprocessor", preprocessor),
    ("classifier", LogisticRegression(max_iter=1000))
])


# ==========================================
# 10. TRAIN AND PREDICT
# ==========================================

model.fit(X_train, y_train)

y_pred = model.predict(X_test)


# ==========================================
# 11. EVALUATION
# ==========================================

print("Accuracy:", accuracy_score(y_test, y_pred))

print(classification_report(y_test, y_pred))

# Convert predictions back to original labels
y_pred_original = label_encoder.inverse_transform(y_pred)

print("Original Predictions:")
print(y_pred_original)