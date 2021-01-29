create function fnbalancedue()
	returns money
begin
	return (select sum(invoicetotal - paymenttotal - credittotal)
	        from invoices
			where invoicetotal - paymenttotal - credittotal > 0);
end;

go

print 'Balance Due: $' + convert(varchar, dbo.fnbalancedue(),1);