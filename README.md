# Google-Data-Analytics-Capstone-Case-Study-

**Act:**
For my capstone project as part of the Google Data Analytics Certificate, I will analyze the World Happiness Report dataset, sourced from Kaggle (available at https://www.kaggle.com/datasets/unsdsn/world-happiness). This dataset not only provides happiness scores for various countries but also includes their GDP, Freedom, and Corruption scores. My aim is to identify the happiest country and assess its suitability for business operations.

I will utilize a combination of tools, including Microsoft Excel, SQL, and Microsoft PowerPoint, throughout this project. The project's stakeholders will encompass government organizations and family members. The intended audience for my findings comprises citizens and prospective global business ventures looking to expand their operations.


**Prepare:**
As mentioned previously, the dataset is sourced from Kaggle, which is generally considered a credible platform for data sets. However, it's important to acknowledge potential bias within the dataset due to its origin from the Gallup World Poll. To verify the dataset's integrity and assess the author's credibility, it's essential to delve deeper into the context provided on the Kaggle page and explore any information about the data source and collection methodology.

The dataset is valuable for addressing the question of "what country is best to do business with?" because it contains several key indicators. I believe that high happiness scores in a country are often associated with a robust economy and effective governance. Therefore, these indicators can be indicative of the potential for business opportunities in those countries.

When a country boasts a strong economy and a well-regulated government, it suggests a thriving environment for businesses to flourish. By examining this data, we can potentially uncover business opportunities that might not be immediately apparent or well-explored. In essence, this dataset can shed light on countries that are not only happy but also economically and politically stable, making them attractive prospects for business ventures.


**Process:**
To start, I imported the dataset into Microsoft Excel and begnin with the cleaning process. Here are the steps into cleaning the dataset:
1. Make a copy of the data onto another sheet
2. Check for duplicates within the data 
3. Spelling check
4. Format the different year data in the same format:
    - a. Overall Rank
    - b. Country
    - c. Region
    - d. Happiness score
    - e. Economy (GDP per capita)
    - f. Family 
    - g. Health (Life Expectancy)
    - h. Freedom
    - i. Government Corruption
    - j. Generosity

5. Working Set 2017 - 2019 doesn’t have a “Region” column so we use the IF function nested with a VLOOKUP function to get the datasets from the 2015 and 2016 datasets. The IF function is added because 2015 and 2016 don’t have the same countries and if we only use a VLOOKUP function then in some of the columns, it will return “#N/A”

    -a. =IFERROR(VLOOKUP(B2,'Working set 2015 '!$B$2:$C$159,2,FALSE),IFERROR(VLOOKUP(B2,'Working set 2016'!$B$2:$C$158,2,FALSE), "Not Found"))
    -b. The “Not Found” data is corrected and/or fixed to provide a “Region” 

6. Next, we format all of the number columns from “General” to “Numbers” with a decimal of 3
Added a column in the beginning (“Year”)
To combine the data:
. Data > Get Data (Power Query) > Launch Power Query Editor 
2. Get data > Select all of the years > Combine > Append queries 
3. Close & Load 

