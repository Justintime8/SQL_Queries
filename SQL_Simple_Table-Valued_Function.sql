create function fntopvendorsdue
	(@cutoff money = 0)
	returns table
return
	(select vendorname,
	        sum(invoicetotal) totaldue
	 from vendors
	 join invoices on invoices.VendorID = vendors.VendorID
	 where invoicetotal - CreditTotal - PaymentTotal > 0
	 group by vendorname
	 having sum(invoicetotal) >= @cutoff);

go

select *
from dbo.fntopvendorsdue(5000);

go

select vendors.vendorname,
       vendors.vendorcity,
	   totaldue
from vendors
join dbo.fntopvendorsdue(default) topvendors on
vendors.vendorname = topvendors.vendorname;