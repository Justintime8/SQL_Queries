use AP;

go

create proc spBalanceRange
	@vendorvar varchar(50) = '%',
	@balancemax money = 0,
	@balancemin money = 0

as

if @balancemax = 0
	begin
		select VendorName,
			   invoicenumber,
			   invoicetotal - credittotal - paymenttotal balance
		from invoices
		join vendors on vendors.vendorid = invoices.VendorID
		where (invoicetotal - CreditTotal - paymenttotal) > 0 and
		      (invoicetotal - credittotal - paymenttotal) >= @balancemin and
			  vendorname like @vendorvar
		order by 3 desc;
	end;
else
	begin
		select vendorname,
			   invoicenumber,
			   invoicetotal - credittotal - paymenttotal balance
		from invoices
		join vendors on vendors.vendorid = invoices.VendorID
		where (invoicetotal - credittotal - paymenttotal) > 0 and
			  (invoicetotal - credittotal - paymenttotal)
			  between @balancemin and @balancemax
		order by 3 desc;
	end;

exec spBalanceRange;