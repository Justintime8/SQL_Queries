use AP;
if OBJECT_ID ('#firstinvoicedate') is not null
	drop table #firstinvoicedate;

select vendorid,
	   min(invoicedate) firstinvoicedate
into #firstinvoice
from invoices
group by vendorid

select vendorname,
	   firstinvoicedate,
	   invoicetotal
from invoices 
join #firstinvoice on (invoices.vendorid = #firstinvoice.vendorid and
					   invoices.invoicedate = #firstinvoice.firstinvoicedate)
join vendors on invoices.vendorid = vendors.vendorid
order by 1,2;
