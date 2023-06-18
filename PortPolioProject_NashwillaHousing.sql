
select *
from NewProject.dbo.NashwillaHousing


--Standardize Date format

select saleDateConverted, CONVERT(date,SaleDate) 
from NewProject.dbo.NashwillaHousing

update NewProject.dbo.NashwillaHousing
set saleDateConverted = CONVERT(date,SaleDate)

update NewProject.dbo.NashwillaHousing
set SaleDate = CONVERT(date,SaleDate) 

alter table NashwillaHousing
add saleDateConverted date;

--Populate Property Address
select	*
from NewProject.dbo.NashwillaHousing


select	a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
from NewProject.dbo.NashwillaHousing a
join NewProject.dbo.NashwillaHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null 


update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from NewProject.dbo.NashwillaHousing a
join NewProject.dbo.NashwillaHousing b
on a.ParcelID = b.ParcelID
and a.[UniqueID ]<> b.[UniqueID ]
where a.PropertyAddress is null 

select*
from NewProject.dbo.NashwillaHousing
--Breaking out Address into individual colums 

select	PropertyAddress
from NewProject.dbo.NashwillaHousing

select
SUBSTRING(PropertyAddress,1 ,CHARINDEX(',',PropertyAddress) -1) as Address
,SUBSTRING(PropertyAddress ,CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress)) as City
from NewProject.dbo.NashwillaHousing

alter table NashwillaHousing
add PropertSplitAddress nvarchar(255);

Update NewProject.dbo.NashwillaHousing
set PropertSplitAddress = SUBSTRING(PropertyAddress,1 ,CHARINDEX(',',PropertyAddress) -1)

alter table NashwillaHousing
add PropertSplitCity nvarchar(255);

Update NewProject.dbo.NashwillaHousing
set PropertSplitCity = SUBSTRING(PropertyAddress ,CHARINDEX(',',PropertyAddress)+1 , LEN(PropertyAddress))

--Breaking owner Address into the colums

select OwnerAddress
from NewProject.dbo.NashwillaHousing

select 
PARSENAME(REPLACE(OwnerAddress,',','.'), 3)
,PARSENAME(REPLACE(OwnerAddress,',','.'), 2)
,PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
from NewProject.dbo.NashwillaHousing

alter table NewProject.dbo.NashwillaHousing
add OwnerSplitAddress nvarchar(255);

Update NewProject.dbo.NashwillaHousing
set OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

alter table NewProject.dbo.NashwillaHousing
add OwnerSplitCity nvarchar(255);

Update NewProject.dbo.NashwillaHousing
set OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

alter table NewProject.dbo.NashwillaHousing
add OwnerSplitState nvarchar(255);

Update NewProject.dbo.NashwillaHousing
set OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

select *
from NewProject.dbo.NashwillaHousing

--Change Y and S to Yes and No in "Sold as vacant" field

select Distinct(SoldAsVacant), COUNT(SoldAsVacant)
from NewProject.dbo.NashwillaHousing
group by SoldAsVacant
order by 2



select SoldAsVacant
,case when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'No'
	 else SoldAsVacant
	 end
from NewProject.dbo.NashwillaHousing

update NewProject.dbo.NashwillaHousing
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
     when SoldAsVacant = 'N' then 'No'
	 else SoldAsVacant
	 end



	 --Delete unwanted Columns

	 select *
	 from NewProject.dbo.NashwillaHousing
	 order by [UniqueID ]

	 alter table NewProject.dbo.NashwillaHousing
	 drop column saledate,PropertyAddress,ownerAddress


	 select *
	 from NewProject.dbo.NashwillaHousing
	 order by [UniqueID ]