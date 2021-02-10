use AP;

begin tran
	insert InvoiceArchive
	select invoices.*
	from Invoices
	left join InvoiceArchive on invoices.InvoiceID = InvoiceArchive.InvoiceID
	where invoices.invoicetotal - invoices.CreditTotal - invoices.paymenttotal = 0 and
		  invoices.InvoiceID = null;

	delete invoices
	where invoiceid in (select invoiceid
						from InvoiceArchive);
commit tran;