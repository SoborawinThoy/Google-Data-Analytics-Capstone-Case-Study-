# Google-Data-Analytics-Capstone-Case-Study-

**Act:**

For my capstone project as part of the Google Data Analytics Certificate, I will analyze the World Happiness Report dataset, sourced from Kaggle (available at https://www.kaggle.com/datasets/unsdsn/world-happiness). This dataset not only provides happiness scores for various countries but also includes their GDP, Freedom, and Corruption scores. My aim is to identify the happiest country and assess its suitability for business operations.

I will utilize a combination of tools, including Microsoft Excel, SQL, and Microsoft PowerPoint, throughout this project. The project's stakeholders will encompass government organizations and family members. The intended audience for my findings comprises citizens and prospective global business ventures looking to expand their operations.


**Prepare:**

As mentioned previously, the dataset is sourced from Kaggle, which is generally considered a credible platform for data sets. However, it's important to acknowledge potential bias within the dataset due to its origin from the Gallup World Poll. To verify the dataset's integrity and assess the author's credibility, it's essential to delve deeper into the context provided on the Kaggle page and explore any information about the data source and collection methodology.

The dataset is valuable for addressing the question of "what country is best to do business with?" because it contains several key indicators. I believe that high happiness scores in a country are often associated with a robust economy and effective governance. Therefore, these indicators can be indicative of the potential for business opportunities in those countries.

When a country boasts a strong economy and a well-regulated government, it suggests a thriving environment for businesses to flourish. By examining this data, we can potentially uncover business opportunities that might not be immediately apparent or well-explored. In essence, this dataset can shed light on countries that are not only happy but also economically and politically stable, making them attractive prospects for business ventures.


**Process:**

*Excel*

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

   5. Working Set 2017 - 2019 doesn’t have a “Region” column so we use the IF function nested with a VLOOKUP function to get the datasets from the 2015 and 2016       datasets. The IF function is added because 2015 and 2016 don’t have the same countries and if we only use a VLOOKUP function then in some of the columns, it       will return “#N/A”

         =IFERROR(VLOOKUP(B2,'Working set 2015 '!$B$2:$C$159,2,FALSE),IFERROR(VLOOKUP(B2,'Working set 2016'!$B$2:$C$158,2,FALSE), "Not Found"))
   
   - The “Not Found” data is corrected and/or fixed to provide a “Region” 

   7. Next, we format all of the number columns from “General” to “Numbers” with a decimal of 3
   8. Added a column in the beginning (“Year”)
   9. To combine the data:
      -  Data > Get Data (Power Query) > Launch Power Query Editor 
      -  Get data > Select all of the years > Combine > Append queries 
      -  Close & Load
   10. Create a Filter throughout the columns then filter the countries by Overall Ranks, analyze the data and capture any trends or relationship
   11. Create two seperate Pivot tables to get the "Top 10 Happiest countries" and "Top 10 Unhappiest Countries", each tables includes Average of Happiness Score,    Average of Economy (GDP per Capita), Average of Government Corruption and Average of Freedom
   12. Using both Pivot tables, a Dashboard is created in a new tab linked with slicers for "Year", "Overall Rank" and "Country
   13. To narrow down the list and to find the Best countries and Worst countries, the dataset is then taken into SQL

*SQL*

I imported the cleaned World Happiness dataset into SQL to create a dashboard focusing on the happiest and least happy countries in the world for the years 2015 to 2019. Initially, my goal was to filter the data to identify countries that met specific criteria, such as high scores in Happiness, Economy, Government Corruption, and Freedom compared to the global averages. To further narrow down the list, I aimed to find countries that consistently met these conditions throughout the entire 2015-2019 period.

To achieve this, I employed a common table expression (CTE) and joined it with my original query. The resulting table was then exported to Excel for more in-depth analysis. This analysis served as the basis for identifying countries favorable for initiating business ventures.
Subsequently, I reversed the conditions to pinpoint countries that consistently scored below average in these criteria. This was instrumental in identifying regions where business opportunities might not be as promising.

The data from these two analyses was exported to Excel, allowing for detailed examination and further research into why some countries consistently scored high, while others consistently scored below average. This holistic approach enables data-driven decision-making for business opportunities and risk assessment.

   -- For this Query, we're narrowing down to find a country that best fits the query and to see which country shows up the most and 
   
   -- we will pick that country from there and investigate more on

      WITH CountryCounts AS (
          SELECT Country, COUNT(DISTINCT Year) AS YearCount
          FROM `World Happiness`.`wh_sql`
          WHERE Year BETWEEN 2015 and 2019
          GROUP BY Country
      )

      SELECT wh.*
      FROM `World Happiness`.`wh_sql` wh
      INNER JOIN CountryCounts cc ON wh.Country = cc.Country
      WHERE HappinessScore > (SELECT avg(HappinessScore) FROM `World Happiness`.`wh_sql`)
          AND Economy > (SELECT avg(Economy) FROM `World Happiness`.`wh_sql`)
          AND GovernmentCorruption < (SELECT avg(GovernmentCorruption) FROM `World Happiness`.`wh_sql`)
          AND Freedom > (SELECT avg(Freedom) FROM `World Happiness`.`wh_sql`)
          AND cc.YearCount = 5;  
          
   -- For this Query, we're narrowing down to find the countries to best avoid due to their scores 
   
   -- Find the country or countries that show up the most and do further investigation on why that is the reason 

      WITH CountryCounts AS (
          SELECT Country, COUNT(DISTINCT Year) AS YearCount
          FROM `World Happiness`.`wh_sql`
          WHERE Year BETWEEN 2015 and 2019
          GROUP BY Country
      )

      SELECT wh.*
      FROM `World Happiness`.`wh_sql` wh
      INNER JOIN CountryCounts cc ON wh.Country = cc.Country
      WHERE HappinessScore < (SELECT avg(HappinessScore) FROM `World Happiness`.`wh_sql`)
          AND Economy < (SELECT avg(Economy) FROM `World Happiness`.`wh_sql`)
          AND GovernmentCorruption > (SELECT avg(GovernmentCorruption) FROM `World Happiness`.`wh_sql`)
          AND Freedom < (SELECT avg(Freedom) FROM `World Happiness`.`wh_sql`)
          AND cc.YearCount = 5;  

<a href="Best countries.csv">Click here to View the best query table</a>

<a href="Worst countries.csv">Click here to View the worst query table</a>


**Share:** 



