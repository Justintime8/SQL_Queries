use AP;

go 

create table shippinglables
(vendorname varchar(50),
 vendoraddress1 varchar(50),
 vendoraddress2 varchar(50),
 vendorcity varchar(50),
 vendorstate varchar(2),
 vendorzipcode varchar(20));

 go

create trigger update_shippinglabel
	on invoices
	after insert, update
as
	insert shippinglables
	select vendorname, vendoraddress1, vendoraddress2,
		   vendorcity, vendorstate, vendorzipcode
	from vendors
	join inserted i on vendors.VendorID = (select vendorid
									     from inserted)
	where i.InvoiceTotal - i.CreditTotal - i.PaymentTotal = 0;
	
go

update invoices
set PaymentTotal = 67.92,
    PaymentDate = '2020-02-23'
where invoiceid = 100;