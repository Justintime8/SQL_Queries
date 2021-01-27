use AP;

declare @invoiceamount money;
set @invoiceamount = (select sum(invoicetotal - paymenttotal - credittotal)
					  from invoices
					  where invoicetotal - paymenttotal - credittotal > 0);

if @invoiceamount > 10000
select v.vendorname,
	   i.invoicenumber,
	   i.invoiceduedate,
	   i.invoicetotal - i.paymenttotal - i.credittotal balance
from invoices i
join Vendors v on v.VendorID = i.VendorID
where invoicetotal - paymenttotal - credittotal > 0
order by 3 asc;
else --@invoiceamount < 10000
	print 'all paid up';


