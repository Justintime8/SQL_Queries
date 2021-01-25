use AP;

Declare @earliestInvoiceDue date, @maxinvoicedue money;
Declare @mininvoicedue money, @latestinvoicedue date;

Select @mininvoicedue = min(invoicetotal - paymenttotal - credittotal),
       @maxinvoicedue = max(invoicetotal - PaymentTotal - credittotal),
	   @earliestInvoiceDue = min(invoiceduedate),
	   @latestinvoicedue = max(invoiceduedate)
from invoices
where invoicetotal - paymenttotal - credittotal > 0;

if @earliestInvoiceDue < getdate()
	begin
		print 'You need to pay this and more!!!';
		print 'Dated ' + convert(varchar, @earliestinvoicedue,1) +
		' through ' + convert(varchar,@latestinvoicedue,1) + '.';
		print 'amounting from $' + convert(varchar,@mininvoicedue,1) +
		' to $' + convert(varchar,@maxinvoicedue,1) + '.';
	end;
else --@earliestinvoicedue >= getdate()
	print 'No overdue invoice.';