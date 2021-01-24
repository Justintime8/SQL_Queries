use AP;

declare @totalDue money;
set @totalDue = (select sum(invoicetotal - paymenttotal - credittotal)
				 from invoices);
if @totalDue > 0
	print 'Total invoices due = $' + convert(varchar,@totalDue,1);
else
	print 'all paid up, my friend';