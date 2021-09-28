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


select *
from (select *,
			 (SalePrice - TotalValue ) Sale_Difference,
			 (TotalValue/SalePrice)*100 Sale_Percent_Difference
	  from Nashville_housing_info) sales_info
where Sale_Percent_Difference > 100
order by Sale_Percent_Difference desc