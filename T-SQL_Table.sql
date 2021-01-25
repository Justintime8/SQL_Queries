use AP;

declare @hugevendors table (vendorID int, vendorName varchar(50));

insert @hugevendors
select vendorID,
	   vendorName
from Vendors
where vendorID in (select VendorID
                   from invoices
				   where InvoiceTotal > 5000);

select *
from @hugevendors;