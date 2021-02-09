if OBJECT_ID('tempdb..#vendorcopy') is not null
	drop table tempdb.. #vendorcopy;
select vendorid, vendorname
into #vendorcopy
from vendors
where vendorid < 5;
begin tran;
	delete #vendorcopy where VendorID = 1;
	save tran vendor1;
		delete #vendorcopy where vendorid = 2;
		save tran vendor2;
			delete #vendorcopy where vendorid = 3;
			select * from #vendorcopy;
		rollback tran vendor2;
		select * from #vendorcopy;
	rollback tran vendor1;
	select * from #vendorcopy;
commit tran;
select * from #vendorcopy;