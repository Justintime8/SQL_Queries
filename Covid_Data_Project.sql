-- covid death data used for project
use Covid_Project

select location,
	   date,
	   total_cases,
	   new_cases,
	   total_deaths,
	   population
from Covid_Deaths
where continent is null
order by 1,2

-- Total Cases vs Total Deaths
-- Percentage of dying if catching Covid
select location,
	   getdate() date,
	   total_cases,
	   total_deaths,
	   round((total_deaths/total_cases),3)*100 death_percentage
from Covid_Deaths
where location = 'United States' and
      continent is null
order by 1,2

-- Total Cases vs Population
-- Percent of covid positive cases
select location,
	   date,
	   total_cases,
	   population,
	   round((total_cases/population),3)*100 as covid_positive
from Covid_Deaths 
where location = 'United States' and
      continent is null
order by 1,2


-- Countries with highest infection rate vs population

select location,
       population,
	   max(total_cases) highest_infection_count,
	   Max(round((total_cases/population),3))*100 as percent_pop_infect
from Covid_Deaths 
where continent is null
group by location, population
order by 4 desc

-- Countries with highest death count per population

select location,
	   max(cast(total_deaths as int)) highest_death_count
from Covid_Deaths 
where continent is null
group by location
order by 2 desc


-- showing continents with highest death count per population

select location,
	   max(cast(total_deaths as int)) highest_death_count
from Covid_Deaths 
where continent is null
group by location
order by 2 desc


-- World data

select date,
	   sum(new_cases) total_cases,
	   sum(cast(new_deaths as int)) total_deaths,
	   round(sum(cast(new_deaths as int))/sum(new_cases),3)*100 death_percentage
from Covid_Deaths
where continent is not null
group by date
order by 1,2


--  covid vaccine data

select top 15 *
from Covid_Vaccine
order by location

-- joining vaccine and death data for total population vs vaccination

select cd.continent,
       cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   sum(convert(int,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) rolling_total_vaccinated
from Covid_Deaths cd
join Covid_Vaccine cv on cv.location = cd.location  
and cv.date = cd.date 
where cd.continent is not null
order by 2,3

-- use cte

with popvsvac (continent, location, date, population, new_vaccinations, rolling_total_vaccinated)
as 
(select cd.continent,
       cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   sum(convert(int,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) rolling_total_vaccinated
from Covid_Deaths cd
join Covid_Vaccine cv on cv.location = cd.location  
and cv.date = cd.date 
where cd.continent is not null
)

select *,
       round((rolling_total_vaccinated/population),2)*100 percent_vaccinated
from popvsvac
where location = 'United States'


--Temp table version

drop table if exists vaccine_percent_population 
create table vaccine_percent_population
(continent nvarchar(255),
 location nvarchar(255),
 date datetime,
 population numeric,
 new_vaccinations numeric,
 rolling_total_vaccinated numeric
 )

insert into vaccine_percent_population
select cd.continent,
       cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   sum(convert(int,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) rolling_total_vaccinated
from Covid_Deaths cd
join Covid_Vaccine cv on cv.location = cd.location  
and cv.date = cd.date 
where cd.continent is not null


select *,
       round((rolling_total_vaccinated/population),3)*100 percent_vaccinated
from vaccine_percent_population
where location = 'United States'



-- creating view of covid data

create view vaccine_population_percentage as
select cd.continent,
       cd.location,
	   cd.date,
	   cd.population,
	   cv.new_vaccinations,
	   sum(convert(int,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) rolling_total_vaccinated
from Covid_Deaths cd
join Covid_Vaccine cv on cv.location = cd.location  
and cv.date = cd.date 
where cd.continent is not null

select *,
       round((rolling_total_vaccinated/population),4)*100 percent_vaccinated
from vaccine_population_percentage
where location = 'China'


