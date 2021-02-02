use AP;

go

create proc spDateRange
	@datemin varchar(50) = null,
	@datemax varchar(50) = null

as

if @datemin is null or @datemax is null
	throw 50001, 'Not correct date configuration.', 1;
if not (isdate(@datemin) = 1 and isdate(@datemax) = 1)
	throw 50001, 'Not valid format for date', 1;
if cast(@datemin as date) > cast(@datemax as date)
	throw 50001, 'datemin parameter must be earlier than datemax',1;

select invoicenumber,
	   invoicedate,
	   invoicetotal,
	   invoicetotal - credittotal - paymenttotal balance
from invoices
where invoicedate between @datemin and @datemax
order by 2;

Begin try
	exec spDateRange @datemin = '2019-10-10', @datemax = '2019-10-20';
end try
begin catch
	print 'error message' + convert(varchar(100), error_message());
	print 'error number' + convert(varchar(100), error_number());
end catch;