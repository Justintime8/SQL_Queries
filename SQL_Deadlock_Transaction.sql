set transaction isolation level
	repeatable read;

declare @invoicestotal money;

begin tran;
	select @invoicestotal = 
		sum(invoicelineitemamount)
	from InvoiceLineItems
	where invoiceid = 101;

waitfor delay '00:00:10'

	update invoices
	set invoicetotal = @invoicestotal
	where invoiceid = 101;
commit tran;

go

set transaction isolation level
	repeatable read;

declare @invoicetotal money;

begin tran
	select @invoicetotal = 
		invoicetotal
	from Invoices
	where invoiceid = 101;

	update InvoiceLineItems
	set InvoiceLineItemAmount = @invoicetotal
	where invoiceid = 101 and
		  InvoiceSequence = 1;
commit tran;