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

select