# Google-Data-Analytics-Capstone-Case-Study-

## Act:

For my capstone project as part of the Google Data Analytics Certificate, I will analyze the World Happiness Report dataset, sourced from Kaggle (available at https://www.kaggle.com/datasets/unsdsn/world-happiness). This dataset not only provides happiness scores for various countries but also includes their GDP, Freedom, and Corruption scores. My aim is to identify the happiest country and assess its suitability for business operations.

I will utilize a combination of tools, including Microsoft Excel, SQL, and Microsoft PowerPoint, throughout this project. The project's stakeholders will encompass government organizations and family members. The intended audience for my findings comprises citizens and prospective global business ventures looking to expand their operations.


## Prepare:

As mentioned previously, the dataset is sourced from Kaggle, which is generally considered a credible platform for data sets. However, it's important to acknowledge potential bias within the dataset due to its origin from the Gallup World Poll. To verify the dataset's integrity and assess the author's credibility, it's essential to delve deeper into the context provided on the Kaggle page and explore any information about the data source and collection methodology.

The dataset is valuable for addressing the question of "what country is best to do business with?" because it contains several key indicators. I believe that high happiness scores in a country are often associated with a robust economy and effective governance. Therefore, these indicators can be indicative of the potential for business opportunities in those countries.

When a country boasts a strong economy and a well-regulated government, it suggests a thriving environment for businesses to flourish. By examining this data, we can potentially uncover business opportunities that might not be immediately apparent or well-explored. In essence, this dataset can shed light on countries that are not only happy but also economically and politically stable, making them attractive prospects for business ventures.


## PROCESS:

#### Excel

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

   6. Next, we format all of the number columns from “General” to “Numbers” with a decimal of 3
   7. Added a column in the beginning (“Year”)
   8. To combine the data:
      -  Data > Get Data (Power Query) > Launch Power Query Editor 
      -  Get data > Select all of the years > Combine > Append queries 
      -  Close & Load
   9. Create a Filter throughout the columns then filter the countries by Overall Ranks, analyze the data and capture any trends or relationship:
       - Key trends:
          - Many of the countries that were ranked the lowest have a low Economy (GDP per Capita) score but their happiness score isn’t too low either
          - When it comes to family support, it seems like that plays a big factor in the happiness score as many of the top countries contain a high family support score
          - When it comes to Health (life expectancy) many of the lower countries have a low health score and these countries are within Sub-Saharan Africa, which makes a lot of sense knowing what the limited resources that the country has for basic nutrition and medicines
          - For the freedom score, Greece from 2017 -2019 has been in the bottom 10
               - Iran scored a 0.00 score in 2015 because the prior year, [“Repressive elements within the security and intelligence forces and the judiciary retained wide powers and continued to be the main perpetrators of rights abuses.”](https://www.hrw.org/world-report/2015/country-chapters/iran) but the year after that, Iran ranking jumped, and was no longer in the bottom 10.
               - Sudan in 2016, scored a 0.00, due to violence outbreaks
               - Angola fell to the bottom in 2018 because [a new president was elected](https://www.hrw.org/world-report/2018/country-chapters/angola) limiting their freedom
         - When it comes to Government corruption, the trend to be seen is that many of the bottom 10 countries are located in Central and Eastern Europe region
         - When it comes to the Generosity score, there isn’t a trend or a correlation seen within the data, this would require a deeper look into the country itself


   10. Create two seperate Pivot tables to get the "Top 10 Happiest countries" and "Top 10 Unhappiest Countries", each tables includes Average of Happiness Score, Average of Economy (GDP per Capita), Average of Government Corruption and Average of Freedom
   11. Using both Pivot tables, a Dashboard is created in a new tab linked with slicers for "Year", "Overall Rank" and "Country Corruption"

       <a href="Capstone Project Dashboard.xlsx">Click here to View the Excel Dashboard</a>   

   12. To narrow down the list and to find the Best countries and Worst countries, the dataset is then taken into SQL

  #### SQL

   I imported the cleaned World Happiness dataset into SQL to create a dashboard focusing on the happiest and least happy countries in the world for the years 2015 to 2019. Initially, my goal was to 
   filter the data to identify countries that met specific criteria, such as high scores in Happiness, Economy, Government Corruption, and Freedom compared to the global averages. To further narrow 
   down the list, I aimed to find countries that consistently met these conditions throughout the entire 2015-2019 period.

   To achieve this, I employed a common table expression (CTE) and joined it with my original query. The resulting table was then exported to Excel for more in-depth analysis. This analysis served as 
   the basis for identifying countries favorable for initiating business ventures.
   Subsequently, I reversed the conditions to pinpoint countries that consistently scored below average in these criteria. This was instrumental in identifying regions where business opportunities 
   might not be as promising.

   The data from these two analyses was exported to Excel, allowing for detailed examination and further research into why some countries consistently scored high, while others consistently scored 
   below average. This holistic approach enables data-driven decision-making for business opportunities and risk assessment.

   -- For this Query, we're narrowing down to find a country that best fits the query and to see which country shows up the most 
   
   -- we will pick that country from there and investigate more on

   <a href="Best countries.csv">Click here to View the query table</a> 

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

   <a href="Worst countries.csv">Click here to View the query table</a>

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

## SHARE: 

**1. Were you able to answer the business question?**

   I successfully addressed a substantial portion of my inquiry. By conducting insightful data analysis and harnessing the robust capabilities of tools such as Excel and SQL, I not only approached the 
   complexities of the business question but also made considerable strides in unraveling its intricacies. This strategic application of analytical methods not only deepened my understanding but also 
   brought me significantly closer to a comprehensive solution.

**2. Here is what I found out through the query table that was created;**

   The countries that best fit to do business with were:
   
    - Panama
    - Poland
    - Solvenia
    - Thailand
    - Trinidad and Tobago
  
   The countries that least best to do business with were:
   
    - Georgia
    - Syria
  
**3. With my findings, I took a deeper dive into researching about the countries and finding reasons to what causes these these finding and the results is contained inside the powerpoint:**

   > DISCLAIMER: The presentation provides a concise overview of various countries, offering a snapshot of key information without 
   delving into extensive research details. While the focus was on conducting quick research for each country, the intention was to 
   provide a valuable resource for those interested in exploring business opportunities. By presenting easily accessible 
   information, the goal is to enable individuals to initiate their preliminary research on Google, empowering them to gather 
   essential insights before making informed decisions about potential business ventures.
  
   <a href="Conclusion.pptx">Click here to View the PowerPoint</a>

## ACT:

### **1. What is your conclusion based on your analysis?**

Based on my analysis and research, Thailand stands out as the best country for business expansion. Why might you ask? Thailand is an appealing destination for business for several reasons. As the second-largest economy in ASEAN, it offers a stable and dynamic economic environment. With a gross domestic product (GDP) of $529 billion and consistent annual growth, Thailand provides a robust market for business ventures. The country's strategic location and infrastructure development initiatives, such as the Eastern Economic Corridor (EEC) Act, further enhance its attractiveness. Thailand's focus on diverse industries, including next-generation cars, smart electronics, and digital technologies, demonstrates a commitment to innovation. Additionally, its thriving export-dependent economy, with key markets like the United States and China, presents ample opportunities for global trade. The tourism sector, contributing around 12% of GDP in 2018, adds another dimension to Thailand's economic strength. With a favorable business climate, diverse export portfolio, and strategic initiatives for growth, Thailand stands out as a promising and vibrant destination for business expansion.

### **2. How could your team and business apply your insights?**

The insights into Thailand's economic landscape position it as an attractive destination for potential business expansion or collaboration. As the second-largest economy in ASEAN, Thailand provides a stable and dynamic economic environment, supported by a substantial gross domestic product (GDP) of $529 billion and consistent annual growth. The country's strategic location and ongoing infrastructure development, notably through initiatives like the Eastern Economic Corridor (EEC) Act, enhance its overall appeal. Thailand's commitment to innovation is evident in its focus on diverse industries such as next-generation cars, smart electronics, and digital technologies. For businesses exploring global trade opportunities, Thailand's thriving export-dependent economy, with key markets like the United States and China, offers a promising avenue. The tourism sector, contributing around 12% of GDP in 2018, adds an additional dimension to Thailand's economic strength. With a favorable business climate, a diverse export portfolio, and strategic growth initiatives, Thailand emerges as a vibrant and promising destination for potential business expansion or collaboration.

### **3. What next steps would you or your stakeholders take based on your findings?**

In response to the enlightening findings, stakeholders are poised to undertake a strategic and meticulous approach to enter or expand their operations in the Thai market. This comprehensive plan involves thorough market research, aiming to understand the nuances of industry dynamics, consumer behavior, and regulatory intricacies specific to Thailand. The strategy also encompasses the exploration of strategic partnerships with local entities, fostering collaborations to establish a robust presence and capitalize on existing networks. Legal compliance, supply chain optimization, and the integration of innovation align with the country's strategic focus. Further, tailored global trade strategies, targeted engagement with Thailand's significant tourism sector, and proactive involvement with government bodies and industry associations are integral components. Adapting to the favorable business climate and formulating long-term growth strategies that echo Thailand's overarching initiatives complete this strategic roadmap. By meticulously implementing these steps, stakeholders position themselves to navigate and seize opportunities within Thailand's vibrant economic landscape, ensuring a successful and sustainable market entry or expansion.

### **4. Is there additional data you could use to expand on your findings?***

In shaping the trajectory of my project and harnessing the data, it appears that the existing dataset adequately aligns with the project's goals. My primary objective was to leverage the simplicity of happiness report data, utilizing happiness ratings as a metric to discern the most favorable countries for business endeavors based on their happiness levels. While contemplating potential supplementary data, considerations leaned toward factors such as crime rates and unemployment rates, which inherently fall within the economic realm. However, these facets are comprehensively covered under the broader economic section, providing a holistic overview. The meticulous curation of happiness data, coupled with the prospect of incorporating economic indicators, ensures a robust foundation for the project's analytical depth and strategic insights.








