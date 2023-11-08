-- For this Query, we're narrowing down to find a country that has best fit the query and to see which country shows up the most and 
-- we will pick that country from there and investigate more on

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
WHERE HappinessScore > (SELECT avg(HappinessScore) FROM `World Happiness`.`wh_sql`)
    AND Economy > (SELECT avg(Economy) FROM `World Happiness`.`wh_sql`)
    AND GovernmentCorruption < (SELECT avg(GovernmentCorruption) FROM `World Happiness`.`wh_sql`)
    AND Freedom > (SELECT avg(Freedom) FROM `World Happiness`.`wh_sql`);