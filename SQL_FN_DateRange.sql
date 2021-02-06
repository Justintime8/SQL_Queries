use AP;

go

create function fndaterange
	(@datemin date, @datemax date)
	 returns table
return
	(select invoicenumber,
			invoicedate,
			invoicetotal,
			invoicetotal - credittotal - paymenttotal balance
	 from invoices
	 where invoicedate between @datemin and @datemax);

go

select *
from dbo.fndaterange('2019-10-10','2019-10-20');


select vendors.vendorname,
	   dbo.fndaterange.*
from vendors
join invoices on invoices.vendorid = vendors.vendorid
join dbo.fndaterange('2019-10-10', '2019-10-20') on dbo.fndaterange.invoicenumber = invoices.invoicenumber;

