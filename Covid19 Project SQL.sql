

Select *
From Project_Portfolio..CovidDeaths$
Where continent is not null
order by 3,4

Select *
From Project_Portfolio..CovidVaccinations$
--order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From Project_Portfolio..CovidDeaths$
order by 1,2

-- Looking at Total Cases vs Total Deaths

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From Project_Portfolio..CovidDeaths$
order by 1,2

-- Show Likelyhood Of Dying If You Contract Covid In United States

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage
From Project_Portfolio..CovidDeaths$
Where location like '%states%'
order by 1,2

-- Looking at Total Cases vs Poputlation
-- Shows What Percentage Of Population Contracted Covid

Select location, date, population, total_cases, (total_cases/population)*100 as Percent_Population_Infected
From Project_Portfolio..CovidDeaths$
Where location like '%states%'
order by 1,2

-- Countries With Highest Infection Rate Comparied To Population

Select population, location, MAX(total_cases) as Highest_Infection_Count, Max((total_cases/population))*100 as Percent_Population_Infected
From Project_Portfolio..CovidDeaths$
-- Where location like '%states%'
Group by location, population
Order by Percent_Population_Infected desc


--Countries With Highest Death Count Per Population

Select location, MAX(cast(total_deaths as int)) as Total_Death_Count
From Project_Portfolio..CovidDeaths$
Where continent is not null
Group by location
Order by Total_Death_Count desc

-- Broken Down By Continent

Select location, MAX(cast(total_deaths as int)) as Total_Death_Count
From Project_Portfolio..CovidDeaths$
Where continent is null
Group by location
Order by Total_Death_Count desc

--  Continents With Hightest Death Count Prt Population
-- Enter Into View

Select continent, MAX(cast(total_deaths as int)) as Total_Death_Count
From Project_Portfolio..CovidDeaths$
Where continent is not null
Group by continent
Order by Total_Death_Count desc

-- Global Numbers

Select date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases) *100 as Death_Percentage
From Project_Portfolio..CovidDeaths$
Where continent is not null
Group By date
order by 1,2

Select date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases) *100 as Death_Percentage
From Project_Portfolio..CovidDeaths$
Where continent is not null
Group By date
order by 1,2

-- Looking at Total Population vs Vaccinations

Select dea.continent, dea.location, dea.date, dea.population, vac.New_Vaccinations
, SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location 
ORDER BY dea.location, dea.date) as Rolling_Vaccinations
From Project_Portfolio..CovidDeaths$ dea
Join Project_Portfolio..CovidVaccinations$ vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3

-- Use CTE

With PopVsVac (continent, location, date, population, New_Vaccinations, Rolling_Vaccinations) as
(
    Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
    SUM(CONVERT(int, vac.New_Vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
    dea.date) as Rolling_Vaccinations
    From Project_Portfolio..CovidDeaths$ dea
    Join Project_Portfolio..CovidVaccinations$ vac
        On dea.location = vac.location
        and dea.date = vac.date
    Where dea.continent is not null
)
-- Here, you would write the main query that references the CTE PopVsVac
-- For example:

Select *, (Rolling_Vaccinations/population)*100
From PopVsVac

-- Temp Table

DROP TABLE if exists #Percent_Population_Vaccinated
Create Table #Percent_Population_Vaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
New_Vaccinations numeric,
Rolling_Vaccinations numeric
)

Insert into #Percent_Population_Vaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
    SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
    dea.date) as Rolling_Vaccinations
    From Project_Portfolio..CovidDeaths$ dea
    Join Project_Portfolio..CovidVaccinations$ vac
        On dea.location = vac.location
        and dea.date = vac.date
    Where dea.continent is not null
	
Select *, (Rolling_Vaccinations/population)*100
From #Percent_Population_Vaccinated

-- Creating View For Data Visualizations


CREATE VIEW 
Percent_Population_Vaccinated_View as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
    SUM(CONVERT(int, vac.new_vaccinations)) OVER (Partition by dea.location ORDER BY dea.location, 
    dea.date) as Rolling_Vaccinations
    From Project_Portfolio..CovidDeaths$ dea
    Join Project_Portfolio..CovidVaccinations$ vac
        On dea.location = vac.location
        and dea.date = vac.date
    Where dea.continent is not null
	
