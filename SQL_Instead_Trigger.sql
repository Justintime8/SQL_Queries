create trigger IBM_invoices_insert
	on IBM_invoices
	instead of insert
as
declare @invoicedate date, @invoicenumber varchar(50),
        @invoicetotal money, @vendorid int,
		@invoiceduedate date, @termsid int,
		@defaultterms smallint, @testrowcount int;
select @testrowcount = count(*)
from inserted;
if @testrowcount = 1
	begin
		select @invoicenumber = invoicenumber,
		       @invoicedate = invoicedate,
			   @invoicetotal = invoicetotal
		from inserted;
		if (@invoicedate is not null AND @invoicenumber is not null and
		    @invoicetotal is not null)
			begin
				select @vendorid = vendorid,
					   @termsid = defaulttermsid
				from vendors
				where vendorname = 'IBM';

				select @defaultterms = termsduedays
				from terms
				where termsid = @termsid;

				set @invoiceduedate = 
					dateadd(day, @defaultterms, @invoicedate);

				insert invoices
					(vendorid, invoicenumber, invoicedate, invoicetotal,
					 termsid, invoiceduedate, paymentdate)
				values (@vendorid, @invoicenumber, @invoicedate, @invoicetotal,
					 @termsid, @invoiceduedate, null);
			end;
	end;
else
	throw 50027, 'limit insert to a single row.', 1;


insert IBM_invoices
values ('RA23988', '2020-03-09', 417.34);