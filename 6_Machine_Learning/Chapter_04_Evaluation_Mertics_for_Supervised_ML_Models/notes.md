# Train - Test Split Theory

---

#### Sampling Techiniques

1. **Biased Sampling**
    - this is nothing but it will take first n number of data for trainning and remaining for testing
    - **Problem**: maybe starting all the data have the same ouput, for example in the insurance claimant what if first 70% or 80% of data says the claimant brings the autoney, then the model will learn only the the data wehre the claimant bring the autoney, it don't know the
2. #### **Unbiased Sampling or stratified Sampling**

**Interview Question**

1. Why are you doil% Train test split?
1. Without this step, what issue might arise?

Client will alwyas chec the data by pasing unseen data to this model, so we have to make sure how well my model will behave for the new data when it is supplied, due to that particuar reason we are spliting the data into 7:3 or 8:2 ratio of training and testing data to make sure recheck the train and test accuracy to see if there is any trade off or bias bettween them

---

## Train-Test Split, Sampling — Notes

#### 1. Train-Test Split

**Definition:**
Train-test split is the process of dividing a dataset into **training data** and **testing data** to train and evaluate a machine learning model.

###### Purpose

- **Training set:** Used by the model to learn patterns.
- **Test set:** Used to check how well the model performs on **unseen data**.

###### Example

Suppose we have **1,000 records**:

```text
1000 records
     │
     ├── 80% → Training Set → 800 records
     │
     └── 20% → Test Set     → 200 records
```

The model learns from the **800 training records** and is evaluated using the **200 test records**.

###### Important

The test data should **not be used for training**, otherwise the evaluation may become unreliable.

---

## 2. Sampling

**Definition:**
Sampling is the process of **selecting a subset of data from a larger population/dataset**.

In train-test splitting, sampling determines **which records go into the training and test sets**.

There are two important cases:

- **Biased sampling**
- **Unbiased/representative sampling**

---

## 3. Biased Sampling

**Definition:**
Biased sampling occurs when the selected sample **does not properly represent the original population**, usually because some groups are over-represented or under-represented.

###### Example

Original dataset:

```text
1000 students

Male   → 600 (60%)
Female → 400 (40%)
```

Suppose the training set contains:

```text
800 students

Male   → 720 (90%)
Female → 80  (10%)
```

The original population is **60% Male / 40% Female**, but the training data is **90% Male / 10% Female**.

Therefore, the training sample is **biased**.

###### Why is it a problem?

The model may learn patterns mainly from the over-represented group and may perform poorly on other groups.

```text
Original Population
60% Male + 40% Female

        ↓ Biased sampling

Training Data
90% Male + 10% Female

        ↓

Model may not generalize well
```

###### Key point

> **Biased sampling → Sample does not properly represent the original population.**

---

## 4. Unbiased Sampling

**Definition:**
Unbiased sampling means selecting data in a way that **fairly represents the original population**, without systematically favoring or excluding a particular group.

###### Example

Original dataset:

```text
1000 students

Male   → 60%
Female → 40%
```

Training data:

```text
800 students

Male   → ~60%
Female → ~40%
```

The training data has approximately the same distribution as the original data.

Therefore, it is **representative/unbiased**.

###### Key point

> **Unbiased sampling → Sample reasonably represents the original population.**

---

## 5. Stratified Sampling

**Definition:**
Stratified sampling is a sampling technique where the data is first divided into **groups (strata)** and samples are then taken from each group while maintaining their desired proportions.

###### Example

Original dataset:

```text
1000 students

Male   → 600 (60%)
Female → 400 (40%)
```

We want 800 training records.

With stratified sampling:

```text
Male:    600 × 80% = 480
Female:  400 × 80% = 320

Training = 800
```

So:

```text
Training:
480 Male   → 60%
320 Female → 40%
```

The original proportion is preserved.

###### Why use stratified sampling?

It is especially useful when:

- Classes are **imbalanced**
- Some groups are small
- We want each important class/group represented in train and test data

###### Machine Learning Example

Suppose a disease dataset contains:

```text
90% → No Disease
10% → Disease
```

Without careful sampling, the train/test sets may have different proportions.

With stratified sampling:

```text
Original: 90% No Disease + 10% Disease

Training: 90% No Disease + 10% Disease
Test:     90% No Disease + 10% Disease
```

This keeps the class distribution approximately the same.

---

## 6. Unbiased vs Stratified Sampling

This is the **most important distinction**:

> **Unbiased sampling is a goal/property. Stratified sampling is a method.**

###### Unbiased Sampling

**Question it answers:**

> "Does my sample fairly represent the population?"

###### Stratified Sampling

**Question it answers:**

> "How can I deliberately preserve the proportions of important groups?"

So:

```text
                 Sampling
                    │
          ┌─────────┴─────────┐
          ↓                   ↓
     Biased Sampling    Representative /
                         Unbiased Sampling
                                ↑
                                │
                       Stratified Sampling
                         can help achieve
                         this representation
```

---

## 7. Random vs Stratified Sampling

This distinction is also important.

###### Random Sampling

Records are selected randomly.

```python
train_test_split(X, y, test_size=0.2)
```

Every record has a chance of being selected.

However, with small or imbalanced datasets, the class proportions may not be perfectly preserved.

###### Stratified Sampling

Records are selected randomly **while preserving the proportions of important classes**.

```python
train_test_split(
    X, y,
    test_size=0.2,
    stratify=y
)
```

For classification, `stratify=y` is commonly used to maintain the class distribution.

---

## 8. Complete Concept

```text
                 ORIGINAL DATA
                      │
                      ↓
               Train-Test Split
                      │
             ┌────────┴────────┐
             ↓                 ↓
          TRAIN              TEST
           80%                20%
             │
             │
       How is data sampled?
             │
       ┌─────┴─────┐
       ↓           ↓
     Biased     Representative
   Sampling      Sampling
                     │
                     ↓
             Stratified Sampling
              (one useful method)
```

#### Quick Revision

| Concept                 | Simple Meaning                                      |
| ----------------------- | --------------------------------------------------- |
| **Train-Test Split**    | Divide data into training and testing sets          |
| **Sampling**            | Selecting a subset of data                          |
| **Biased Sampling**     | Sample does not properly represent the population   |
| **Unbiased Sampling**   | Sample reasonably represents the population         |
| **Stratified Sampling** | Sample from each group while preserving proportions |
| **Random Sampling**     | Select records randomly                             |
| **`stratify=y`**        | Preserve class proportions during train-test split  |

###### ⭐ Remember these 3 lines

**Train-test split:** _Where the data is divided._

**Biased/Unbiased sampling:** _Whether the selected data represents the population properly._

**Stratified sampling:** _A technique used to preserve the proportions of important groups/classes._
