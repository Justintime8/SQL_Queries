-- House cleaning project

use Housing_Project

go

-- fixing the date


alter table Nashville_housing_info
add SalesDateConverted date;

update Nashville_housing_info
set SalesDateConverted = convert(date, SaleDate);

select top 5 *
from Nashville_housing_info;

-- Filling in Null for Address

Select a.ParcelID,
       a.PropertyAddress,
	   b.ParcelID,
	   b.PropertyAddress,
	   isnull(a.PropertyAddress, b.PropertyAddress)
from Nashville_housing_info a
join Nashville_housing_info b
on a.ParcelID = b.ParcelID
and a.[uniqueID] <> b.[UniqueID]
where a.PropertyAddress is null

update a
set PropertyAddress = isnull(a.PropertyAddress,b.PropertyAddress)
from Nashville_housing_info a
join Nashville_housing_info b
on a.ParcelID = b.ParcelID
and a.[uniqueID] <> b.[UniqueID]
where a.PropertyAddress is null

select top 5 *
from Nashville_housing_info

-- Property Address cleaning

Select PropertyAddress
from Nashville_housing_info
where PropertyAddress is null
order by ParcelID;

select SUBSTRING(PropertyAddress, 1, charindex(',', PropertyAddress) -1) Address,
	   SUBSTRING(PropertyAddress, charindex(',', PropertyAddress) + 1, len(PropertyAddress)) Address
from Nashville_housing_info;

alter table Nashville_housing_info
add NewAddress nvarchar(255);

update Nashville_housing_info
set NewAddress = substring(PropertyAddress, 1, Charindex(',', PropertyAddress) -1)


alter table Nashville_housing_info
add NewCity nvarchar(255);

update Nashville_housing_info
set NewCity = substring(PropertyAddress, charindex(',', PropertyAddress) + 1, len(PropertyAddress))

select top 5 *
from Nashville_housing_info


Alter table Nashville_housing_info
add NOwnerAddress nvarchar(255);

update Nashville_housing_info
set NOwnerAddress = Parsename(replace(OwnerAddress, ',', '.'), 3)

Alter table Nashville_housing_info
add NOwnerCity nvarchar(255)

update Nashville_housing_info
set NownerCity = parsename(replace(OwnerAddress, ',', '.'), 2)

Alter table Nashville_housing_info
add NOwnerState nvarchar(255);

update Nashville_housing_info
set NOwnerState = parsename(replace(OwnerAddress, ',', '.'), 1)

select top 5 *
from Nashville_housing_info


-- Using full words in "Sold as Vacant" field

update Nashville_housing_info
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
		  when SoldAsVacant = 'N' then 'No'
		  else SoldAsVacant
		  end

select top 50 *
from Nashville_housing_info

-- No room for duplicates

with RoNumCTW as (
select *,
	   ROW_NUMBER() over(
	   Partition by ParcelID,
						 PropertyAddress,
						 SalePrice,
						 SaleDate,
						 LegalReference
						 order by 
								UniqueID
								)row_num
from Nashville_housing_info
)

select *
from RoNumCTW
where row_num > 1
order by PropertyAddress

select top 5 *
from Nashville_housing_info


--No use for these fields

alter table Nashville_housing_info
drop column OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

Select *
from Nashville_housing_info
						 
