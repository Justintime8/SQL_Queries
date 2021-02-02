create function fnUnpaidInvoiceID()
	returns int
begin
	return (select invoiceid
			from invoices
			where invoicetotal - credittotal - paymenttotal > 0 and
				 invoicedate = (select min(invoicedate)
			                    from invoices
								where invoicetotal - credittotal - paymenttotal > 0 ));
end;

go

select vendorname,
       invoicetotal,
	   invoicedate,
	   invoicetotal - credittotal - paymenttotal balance
from invoices
join vendors on vendors.vendorid = invoices.vendorid
where invoiceid = dbo.fnUnpaidInvoiceID();