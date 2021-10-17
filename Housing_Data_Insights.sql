-- looking at Housing Data
use Housing_Project

Go

Select *
from Nashville_housing_info
where Bedrooms > 3 and
      FullBath >=2 and
	  SoldAsVAcant = 'Yes'


-- complex query of Housing data

Select *
from(
	Select *
	from Nashville_housing_info
	where Bedrooms > 3 and
		  FullBath >=2 and
		  SoldAsVAcant = 'Yes') house
where Bedrooms > 5



select count(Bedrooms) 
       FullBath
from (
	Select *
	from Nashville_housing_info
	where Bedrooms >= 1 and
		  FullBath >=2 and
		  SoldAsVAcant = 'Yes') house
where Bedrooms = 6

select *,
      case 
		   when Bedrooms > 5 then 'Extra Large House'
	       when Bedrooms > 4 then 'Large House'
		   when Bedrooms >= 3 then 'Medium House'
		   else 'Small House'
		   end House_Size
from (Select *
	  from Nashville_housing_info
	  where Bedrooms >= 1 and
		    FullBath >=2 and
		    SoldAsVAcant = 'Yes') house
order by Bedrooms desc


select Distinct(Bedrooms),
       count(bedrooms)
from Nashville_housing_info
where Bedrooms is not null
group by Bedrooms
order by 1 desc

-- Looking at Bedrooms that are zero

Select *
from Nashville_housing_info
where Bedrooms = 0


-- Counting how many sales each owner had

select distinct OwnerName,
       count(OwnerName) num_of_sales
from Nashville_housing_info
group by OwnerName
order by 2 desc


Select *
from Nashville_housing_info
where OwnerName like '%JRG PROPERTIES, LLC%'
order by SalesDateConverted desc


select *,
       (SalePrice - TotalValue ) Sale_Difference,
	   (TotalValue/SalePrice)*100 Sale_Percent_Difference
from Nashville_housing_info

-- Insights on price changes and percent difference from Total Value and Sale Price

select *
from (select *,
			 (SalePrice - TotalValue ) Sale_Difference,
			 (TotalValue/SalePrice)*100 Sale_Percent_Difference
	  from Nashville_housing_info) sales_info
where Sale_Percent_Difference > 100
order by Sale_Percent_Difference desc


-- How many sales in each city

select distinct NewCity,
       count(NewCity) sales_count_by_city,
	   sum(SalePrice) total_sales_by_city
from Nashville_housing_info
group by NewCity
Order by 2 desc

-- Information on Unknown city with sale

select *
from Nashville_housing_info
where SalePrice = 298000 and
      LegalReference = '20160404-0031713'


-- Total Sales per Acreage 

select Acreage,
       count(Acreage) acreage_sold,
	   Sum(LandValue) total_sales_of_acreage
from Nashville_housing_info
group by Acreage
order by 3 desc

select *
from Nashville_housing_info
where Acreage = 0.03


-- Sales by year

select SalesDateConverted
from Nashville_housing_info
order by 1 desc

select YEAR(SalesDateConverted) Year_of_Sales,
       count(SalesDateConverted) count_of_Sales_per_year
from Nashville_housing_info
group by SalesDateConverted
Order by 2 desc

select YEAR(SalesDateConverted) Year_of_Sales,
       count(SalesDateConverted) count_of_Sales_per_year,
	   sum(SalePrice) Total_Sales_Per_Year
from Nashville_housing_info
group by Year(SalesDateConverted)
Order by 2 desc

select YEAR(SalesDateConverted) Year_of_Sales,
       count(SalesDateConverted) count_of_Sales_per_year,
	   Min(SalePrice) Min_Sales_Per_Year
from Nashville_housing_info
group by Year(SalesDateConverted)
Order by 2 desc

Select year(SalesDateConverted) year_of_sale,
       min(SalePrice) min_sale
from Nashville_housing_info
group by SalesDateConverted
order by 2 asc


-- Min and Max Sales insights

select min(SalePrice) min_sale
from Nashville_housing_info


Select *
from Nashville_housing_info
where SalePrice = (select min(SalePrice) min_sale
				   from Nashville_housing_info)

Select *
from Nashville_housing_info
where SalePrice = (Select max(SalePrice) max_sale
				   from Nashville_housing_info)


 Select distinct (Select max(SalePrice) 
		          from Nashville_housing_info) max_sale,
		         (Select min(SalePrice)
		          from Nashville_housing_info) min_sale
from Nashville_housing_info


Select *
from Nashville_housing_info
where SalePrice = (Select max(SalePrice) max_sale
				   from Nashville_housing_info)




-- Insights on Sale Price of Property less than Total Value

Select *
from Nashville_housing_info
where SalePrice < TotalValue
order by SalePrice asc

select OwnerName,
       count(OwnerName) count_of_land_use,
	   sum(TotalValue) sum_of_sales
from Nashville_housing_info
where SalePrice < TotalValue
group by OwnerName
order by 2 desc


select LandUse,
       count(LandUse) count_of_land_use,
	   sum(TotalValue) sum_of_sales
from Nashville_housing_info
where SalePrice < TotalValue
group by LandUse
order by 2 desc

-- Insights on Vacant Res Land sold

select OwnerName,
       count(OwnerName) count_of_land_use,
	   sum(TotalValue) sum_of_sales
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'VACANT RES LAND'
group by OwnerName
order by 2 desc

select OwnerName,
       count(LandUSE) count_of_land_use,
	   year(SalesDateConverted) year_of_sale,
	   sum(TotalValue) sum_of_sales
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'VACANT RES LAND'
group by OwnerName, year(SalesDateConverted)
order by 2 desc


Select LandUse,
       year(SalesDateConverted) year_of_sale,
	   count(LandUse) count_of_Vacant_Land,
	   avg(TotalValue) avg_value
from Nashville_housing_info
where LandUse = 'VACANT RES LAND'
group by LandUse, year(SalesDateConverted)


--insights on Single Family Homes sold under Total Value

Select *
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'SINGLE FAMILY'
order by SalePrice asc



Select LandUse,
       year(SalesDateConverted) year_of_sale,
       AVG(SalePrice) avg_sale_price,
	   avg(TotalValue) avg_total_value,
	   (avg(Saleprice) - avg(TotalValue)) diff_in_price
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'SINGLE FAMILY' and
	  SoldAsVacant = 'YES'
group by LandUse, year(SalesDateConverted)




create view agregate_data as
Select LandUse,
       year(SalesDateConverted) year_of_sale,
       AVG(SalePrice) avg_sale_price,
	   avg(TotalValue) avg_total_value,
	   (avg(Saleprice) - avg(TotalValue)) diff_in_price
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'SINGLE FAMILY' and
	  SoldAsVacant = 'YES'
group by LandUse, year(SalesDateConverted)

select *,
      round((diff_in_price/avg_sale_price),4)*100 percent_difference
from agregate_data
order by 2 desc



-- How many single family homes were not vaccant when sold

Select *
from Nashville_housing_info
where LandUse = 'SINGLE FAMILY' and
      SoldAsVacant = 'No'

select LandUse,
       count(LandUse) Count_of_Land
from Nashville_housing_info
where LandUse = 'SINGLE FAMILY' and
      SoldAsVacant = 'No'
group by LandUse


Select *
from Nashville_housing_info
where LandUse = 'SINGLE FAMILY' and
      SoldAsVacant = 'No' and
	  SalePrice < TotalValue
order by SalePrice asc


create view agregate_data__no_vacant as
Select LandUse,
       year(SalesDateConverted) year_of_sale,
       AVG(SalePrice) avg_sale_price,
	   avg(TotalValue) avg_total_value,
	   (avg(TotalValue)- avg(Saleprice)) diff_in_price
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'SINGLE FAMILY' and
	  SoldAsVacant = 'No'
group by LandUse, year(SalesDateConverted)

select *,
      round((diff_in_price/avg_sale_price),4)*100 percent_difference
from agregate_data__no_vacant
order by 2 desc


-- no vacanct sales by month

select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months
from Nashville_housing_info
where SoldAsVacant = 'No'
group by month(SalesDateConverted)
order by 1 asc


select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where SoldAsVacant = 'No'
group by month(SalesDateConverted)
order by 1 asc



select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2013
      and SoldAsVacant = 'No'
group by month(SalesDateConverted)
order by 1 asc

-- data for 2013
create view data_2013 as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2013
      and SoldAsVacant = 'No'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2013
order by month_date asc

-- data for 2014

create view data_2014 as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2014
      and SoldAsVacant = 'No'
group by month(SalesDateConverted)




select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2014
order by month_date asc


-- 2015 data

create view data_2015 as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2015
	  and SoldAsVacant = 'No'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2015
order by month_date asc


-- 2016 data

create view data_2016 as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2016
	  and SoldAsVacant = 'No'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2016
order by month_date asc

-- data summary for Sold as Vacant is Yes

select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months
from Nashville_housing_info
where SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


Select *
from Nashville_housing_info
where LandUse = 'SINGLE FAMILY' and
      SoldAsVacant = 'No' and
	  SalePrice < TotalValue
order by SalePrice asc


create view agregate_data__yes_vacant as
Select LandUse,
       year(SalesDateConverted) year_of_sale,
       AVG(SalePrice) avg_sale_price,
	   avg(TotalValue) avg_total_value,
	   (avg(TotalValue)- avg(Saleprice)) diff_in_price
from Nashville_housing_info
where SalePrice < TotalValue and
      LandUse = 'SINGLE FAMILY' and
	  SoldAsVacant = 'Yes'
group by LandUse, year(SalesDateConverted)

select *,
      round((diff_in_price/avg_sale_price),4)*100 percent_difference
from agregate_data__no_vacant
order by 2 desc

-- data insights with yes vacant in months


select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months
from Nashville_housing_info
where SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


-- data insights for yes vacant 2013

select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2013
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


create view data_2013_yes_vacant as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2013
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2013_yes_vacant
order by month_date asc


-- data insights for 2014 yes vacant 

select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2014
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


create view data_2014_yes_vacant as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2014
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2014_yes_vacant
order by month_date asc


-- data insights for 2015 yes vacant 

select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2015
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


create view data_2015_yes_vacant as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2015
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2015_yes_vacant
order by month_date asc

-- data insights for 2016 yes vacant 

select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2016
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)
order by 1 asc


create view data_2016_yes_vacant as
select month(SalesDateConverted) month_date,
       count(month(SalesDateConverted)) count_of_months,
	   avg(TotalValue) avg_total,
	   avg(SalePrice) avg_sale_price
from Nashville_housing_info
where year(SalesDateConverted) = 2016
      and SoldAsVacant = 'Yes'
group by month(SalesDateConverted)



select case 
		  when month_date = 1 then 'January'
		  when month_date = 2 then 'February'
		  when month_date = 3 then 'March'
		  when month_date = 4 then 'April'
		  when month_date = 5 then 'May'
		  when month_date = 6 then 'June'
		  when month_date = 7 then 'July'
		  when month_date = 8 then 'August'
		  when month_date = 9 then 'September'
		  when month_date = 10 then 'October'
		  when month_date = 11 then 'November'
		  when month_date = 12 then 'December'
		  else 'none'
		  end month,
		  *
from data_2016_yes_vacant
order by month_date asc


