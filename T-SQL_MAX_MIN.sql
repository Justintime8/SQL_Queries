use AP;

Declare @maxinvoice money, @mininvoice money;
Declare @percentDifference decimal(8,2);
Declare @invoiceCount int, @vendorIDVar int;

set @vendorIDVar = 95;
set @maxinvoice = (select max(invoicetotal)
                   from invoices
				   where VendorID = @vendorIDVar);
select @mininvoice = min(invoicetotal), @invoiceCount = count(*)
from invoices
where VendorID = @vendorIDVar;

set @percentDifference = (@maxinvoice - @mininvoice) / @mininvoice * 100;

print 'maximum invoice is $' + convert(varchar,@maxinvoice,1) + '.';
print 'minimum invoice is $' + convert(varchar,@mininvoice,1) + '.';
print 'maximum is ' + convert(varchar,@percentDifference,1) + 
	'% more than minimum';
print 'Number of invoices: ' + convert(varchar, @invoiceCount) + '.';