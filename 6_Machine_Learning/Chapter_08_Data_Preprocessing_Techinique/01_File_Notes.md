# DATA PREPROCESSING/DATA PREPARATION

1. Data Cleaning - drop, fillna with mean, median, mode Imputation, changing dtype
2. Data Transformation

- If data is CONTINUOUS = Standard Scaler, MinMaxScaIer, Robust Scaler
- If data is DISCRETE = Label Encoder, One hot Encoder

### 1. Import Necssay Libraries

### 2. Import Dataset

### 3. Data Understanding


#### 3.1 Peform Initial Analysis on the data


### 4. Data Preparation


#### 4.1 - Stage 1 - Data Clearning - drop, fillna with mean, median, mode Imputaion, changing dtypes

#### Note:
1. Drop the NaN if required (with respect to row or column)
2. Do mean, median and mode Inputatino if possible or require
3. Repeate the the step 1 an 2 to remoe all teh null values 
4. Last Step only need to change the Data Type

##### Below text is with respect to the dataset used
```
 4P 1. Droping the "**Ozone**" Column, as 25% of the data is **NaN**

> As you working in the company
> - If you working under a Team Leader- Inform you Team Leader that the Ozon Featues have 25% of the data is NaN, Shall i drop the Feature or not (decide according to this decion)
> - If you're a Team Leader - Ask to the client or higher authority about this 

- If possible - try to get the data without any of the null data

```

```
- Here what i am planning is here actually i have only three class in output feature (Weather)
    - One option is with respect to the output class calcuate the average Solar.R value and fill with that
        - S (sunny) - calcuate the average of the all teh Solar.R whose ouput Weathere is S (sunny) and same do for C (cloudy) and PS (Partially Sunny)
```

```

weather_data.groupby("Weather")["Solar.R"].transform(lambda x : x.fillna(x.mean().round()))



To reinforce your trace, here is a quick summary confirming your points:
1. Group by Weather: It segments the dataset into unique classes (S, C, PS).
2. Calculate & Round Mean: For each individual class, it calculates the average of the valid Solar.R values and rounds it.
3. Row-by-Row Fill: It checks the rows, finds the NaN values, looks at which weather class that row belongs to, and fills it with that specific group's rounded mean.
You have completely mastered how .groupby().transform() operates under the hood!
```
#### 4.2 - Stage 2 - Data Transformation

- If data is CONTINUOUS = Standard Scaler, MinMaxScaIer, Robust Scaler
- If data is DISCRETE = Label Encoder, One hot Encoder
---

#### 4.2.1 Label Encoder
#### 4.2.2 One Hot Encoder


This can be achieved by using any of the following 2 libraries:

1. Pandas - pd.get_dummies()
2. sklearn - OneHotEncoder()


#### How to choose between Label Encoder and One Hot Encoder

1. **For Input feature:**
    - Based on whether it is Parametric or a Non Parametric Model, we will choosing between LE or OHE.
        1. For Parametric Models - better to go with OHE.
        2. For Non-Parametric Models - always go with Label Encoding.
2. **For Output feature:**
    - Always the output feature, it must be Label Encoder.