create trigger invoices_update
	on invoices
	after update
as
if exists				--test whether paymenttotal was changed
	(select *
	 from deleted 
	 join invoices on deleted.InvoiceID = invoices.InvoiceID
	 where deleted.PaymentTotal <> invoices.PaymentTotal)
	 begin
		if exists		--test whether line items total and invoicetotal match
			(select *
			 from invoices
			 join (select invoiceid,
					      sum(InvoiceLineItemamount) sumofinvoices
				   from InvoiceLineItems
				   group by InvoiceID) lineitems
			 on invoices.InvoiceID = lineitems.InvoiceID
			 where (invoices.invoicetotal <> lineitems.sumofinvoices) and
			       (lineitems.InvoiceID in (select invoiceid
											from deleted)))
			 begin
				;
				throw 50113, 'correct line items amounts before psoting payment.',1;
				rollback tran;
			 end;
	end;

update invoices
set PaymentTotal = 662, PaymentDate = '2020-03-09'
where invoiceid = 98

select *
from invoices
where invoiceid = 98