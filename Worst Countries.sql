-- For this Query, we're narrowing down to find the countries to best avoid due to their scores and 
-- find the country or countries that shows up the most and do further investigation on why that is the reason 

WITH MostAppearedCountry AS (
	SELECT Country, COUNT(Country) as CountryCount
    FROM `World Happiness`.`wh_sql`
    WHERE Year BETWEEN 2015 and 2019
    GROUP BY Country 
    ORDER BY CountryCount DESC
)

SELECT wh.*
FROM `World Happiness`.`wh_sql` wh
INNER JOIN MostAppearedCountry mac on wh.Country = mac.Country
WHERE HappinessScore < (SELECT avg(HappinessScore) FROM `World Happiness`.`wh_sql`)
    AND Economy < (SELECT avg(Economy) FROM `World Happiness`.`wh_sql`)
    AND GovernmentCorruption < (SELECT avg(GovernmentCorruption) FROM `World Happiness`.`wh_sql`)
    AND Freedom < (SELECT avg(Freedom) FROM `World Happiness`.`wh_sql`);