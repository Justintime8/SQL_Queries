use Covid_Project

go

select top 10 *
from Covid_Deaths


select location,
	   total_cases
from Covid_Deaths
where location = 'North America'


-- total cases by month in China


select case
		when month(date) = 1 then 'January'
		  when month(date) = 2 then 'February'
		  when month(date) = 3 then 'March'
		  when month(date) = 4 then 'April'
		  when month(date) = 5 then 'May'
		  when month(date) = 6 then 'June'
		  when month(date) = 7 then 'July'
		  when month(date) = 8 then 'August'
		  when month(date) = 9 then 'September'
		  when month(date) = 10 then 'October'
		  when month(date) = 11 then 'November'
		  when month(date) = 12 then 'December'
		  else 'none'
		  end month,
		  round(avg(total_cases),2) avg_cases,
		  location,
		  year(date) _year_
from Covid_Deaths
where year(date) = 2020 and
      location = 'China'
group by month(date), location, year(date)
order by avg_cases desc




-- location data

select location,
	   max(total_cases) max_cases,
	   year(date) year
from Covid_Deaths
where location <> 'World' and
      year(date) = 2021
group by location, year(date)
order by max_cases desc

select location,
	   max(total_cases) max_cases,
	   year(date) year,
	   case
		when max(total_cases) > 10000000 then 'Severe Death Count'
		when max(total_cases) > 1000000 then 'High Death Count'
		when max(total_cases) > 100000 then 'Mid Death Count'
		when max(total_cases) > 10000 then 'Moderate Death Count'
		when Max(total_cases) > 1000 then 'Low Death Count'
		else 'Minimum Death Count'
		end death_count
from Covid_Deaths
where location <> 'World' and
      year(date) = 2021
group by location, year(date)
order by max_cases desc