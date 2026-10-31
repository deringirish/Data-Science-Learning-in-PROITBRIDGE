# Light Gradient Boosting Machine (LightGBM)

(Lighter version of Gradient Boosting Decision Trees)

Developed by: Microsoft\
Released: April 2017

### Main Idea

"To make Gradient Boosting on Decision Trees faster and more efficient."

### Points to Remember

1. Faster and More Efficient
   - LightGBM is designed to make Gradient Boosting faster.
   - It uses less memory and can provide better accuracy in some cases.
2. Leaf-wise Splitting
   - LightGBM splits the Decision Tree using a Leaf-wise approach.
   - Unlike traditional Level-wise tree growth, it selects the leaf that provides the maximum loss reduction.
   - Note: It uses loss reduction, not Gini Index, for standard boosting trees.
3. Faster than XGBoost
   - LightGBM can be significantly faster than XGBoost.
   - It is useful when dealing with large datasets and limited training time.
   - It can be up to 7 times faster in certain situations, but this is not guaranteed.
4. Overfitting
   - Since LightGBM grows trees leaf-wise, it can sometimes lead to overfitting.
   - This can be controlled by defining the maximum tree depth (`max_depth`) and number of leaves (`num_leaves`).
5. Hyperparameter Optimization
   - LightGBM has many hyperparameters that need to be optimized for better performance.
6. Scikit-learn Installation
   - LightGBM is not included in Scikit-learn by default.
   - It needs to be installed separately.
   ```
   pip install lightgbm
   ```
7. GOSS (Gradient-based One-Side Sampling)
   - LightGBM uses GOSS to reduce the number of training instances.
   - It keeps instances with large gradients and randomly samples instances with small gradients.
8. Handling Sparse Datasets
   - LightGBM has built-in support for handling sparse datasets efficiently.
9. EFB (Exclusive Feature Bundling)
   - LightGBM uses Feature Bundling to combine mutually exclusive sparse features.
   - This reduces the effective number of features and improves computational efficiency.