create function fnvendorid
	(@vendorname varchar(50))
	returns int
begin
	return (Select vendorid
			from vendors
			where vendorname = @vendorname);
end;

go

select invoicedate,
	   invoicetotal
from invoices
where vendorid = dbo.fnvendorid('IBM');

go

select *
from dbo.fntopvendorsdue(5000);