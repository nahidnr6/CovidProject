-- Shows likelihood of dying if you contract covid in your country


SELECT location , date, total_cases , total_deaths , (total_deaths*1.0/total_cases)*100 as DeathPercentage
FROM CovidDeaths cd 
WHERE location like '%states%'
WHERE continent is not null 
order by 1,2

-- Looking at the Total cases vs Population
-- Shows what percentage of population got Covid

SELECT location , population  , MAX(total_cases) as HighestInfectionCount,  (total_cases*1.0/population)*100 as PercentagePopulationInfected
FROM CovidDeaths cd 
GROUP BY population, location 
WHERE continent is not null 
order by PercentagePopulationInfected DESC

-- Showing countries with Highest Death Count per population 


SELECT location , MAX(cast(total_deaths as int)) as TotalDeathCount
FROM CovidDeaths cd 
WHERE continent is not null 
GROUP BY location  
order by TotalDeathCount desc



SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage  
FROM CovidDeaths cd 
WHERE continent is not null 
GROUP BY date  
order by 1,2


-- Looking at Total population vs Vaccinations 

--Looking at new vaccinations

Select dea.continent , dea.location , dea.date, dea.population , vac.new_vaccinations 
FROM CovidDeaths dea
JOIN CovidVaccinations_csv vac
	ON dea.location = vac.location 
	AND dea.date = vac.date
	

-- Creating view to store data for later visualizations 
	
CREATE View NewVaccinations as 
Select dea.continent , dea.location , dea.date, dea.population , vac.new_vaccinations 
FROM CovidDeaths dea
JOIN CovidVaccinations_csv vac
	ON dea.location = vac.location 
	AND dea.date = vac.date




