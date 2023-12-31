# Covid-19 SQL Code

Gathering and analyzing data related to COVID-19, focusing on deaths, case counts, and vaccination rates at various granularities, including by country, continent, and globally.

General Queries:
Retrieval of COVID-19 death data, filtering out records with null continents, and ordering by the third and fourth columns.
Retrieval of COVID-19 vaccination data without specific ordering.
Extraction of location, date, total cases, new cases, total deaths, and population from the deaths data, ordered by location and date.

Analysis of Deaths:
Calculation of death percentage based on total cases and total deaths.
Specific death percentage analysis for locations containing the word 'states', indicating the United States.

Analysis of Infection Rates:
Computation of the percentage of the population infected by COVID-19.
Determination of countries with the highest infection rates compared to their population.
Identification of countries with the highest death counts.
Segregation of death count data by continent, distinguishing between countries and continents.

Global Trends:
Aggregation of global daily new cases and new deaths, followed by the calculation of a global death percentage.

Vaccination Analysis:
Comparison of total population versus the number of vaccinations given.
Development of a Common Table Expression (CTE) and a temporary table to calculate the cumulative number of people vaccinated and the percentage of the population that has been vaccinated.
Creation of a SQL view for easy data visualizations related to the percentage of the population vaccinated.

Overall, the SQL scripts provide a comprehensive understanding of the spread and impact of COVID-19, using death counts, infection rates, and vaccination metrics as key indicators. The inclusion of various SQL constructs like views, CTEs, and temp tables enables efficient data manipulation, ultimately aiding in the visualization and interpretation of these critical datasets.
