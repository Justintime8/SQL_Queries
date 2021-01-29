create trigger invoices_delete
	on invoices
	after delete
as
	insert into InvoiceArchive
		(invoiceid, VendorID, invoicenumber, invoicedate, invoicetotal,
			paymenttotal, CreditTotal, termsid, invoiceduedate, paymentdate)
		select invoiceid, VendorID, invoicenumber, invoicedate, invoicetotal,
			paymenttotal, CreditTotal, termsid, invoiceduedate, paymentdate
		from deleted

delete invoices
where VendorID = 37

select *
from InvoiceArchive