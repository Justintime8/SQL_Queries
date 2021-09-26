--data for tableau project

use Covid_Project

select sum(new_cases) total_cases,
       sum(cast(new_deaths as int)) total_deaths,
	   round(sum(cast(new_deaths as int))/sum(new_cases),4)*100 death_percent
from Covid_Deaths
where continent is not null
order by 1,2


-- world data of covid

select sum(new_cases) total_cases,
       sum(cast(new_deaths as int)) total_deaths,
	   round(sum(cast(new_deaths as int))/sum(new_cases),4)*100 death_percent
from Covid_Deaths
where location like '%states%'
--where location = 'World'
group by date
order by 1,2


-- Taking out European, World, and International covid data

select location,
       sum(cast(new_deaths as int)) death_total
from Covid_Deaths
where continent is null
and location not in ('World', 'European Union', 'International')
group by location
order by 2 desc

-- Max covid data without date

select location,
       population,
	   max(total_cases) covid_positive_count,
	   round(max(total_cases/population),4)*100 covid_positive_percentage
from Covid_Deaths
group by location, population
order by 4 desc


-- Max covid data with date

select location,
       population,
	   date,
	   max(total_cases) covid_positive_count,
	   round(max((total_cases/population)),4)*100 covid_positive_percentage
from Covid_Deaths
group by location, population,date
order by 5 desc