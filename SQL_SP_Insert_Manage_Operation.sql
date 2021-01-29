use AP;
go
if OBJECT_ID('spinsertinvoice') is not null
	drop proc spinsertinvoice;
go

create proc spinsertinvoice
	@vendorid			int = null,
	@invoicenumber		varchar(50) = null,
	@invoicedate		date = null,
	@invoicetotal		money = null,
	@paymenttotal		money = null,
	@credittotal		money = null,
	@termsid			int = null,
	@invoiceduedate		date = null,
	@paymentdate		date = null

as

if not exists (select *
			   from vendors
			   where vendorid = @vendorid)
	throw 50001, 'invalid vendorid.',1;
if @invoicenumber is null
	throw 50001, 'invalid invoicenumber.',1;
if @invoicedate is null or @invoicedate > getdate()
		or datediff(dd, @invoicedate, getdate()) > 30
	throw 50001, 'invalid invoicedate', 1;
if @invoicetotal is null or @invoicetotal <= 0
	throw 50001, 'invalid invoicetotal',1;
if @paymenttotal is null
	set @paymenttotal = 0;
if @credittotal is null
	set @credittotal = 0;
if @credittotal > @invoicetotal
	throw 50001, 'invalid credittotal',1;
if @paymenttotal > @invoicetotal - @credittotal
	throw 50001, 'invalid paymenttotal',1;
if not exists (select *
			   from terms
			   where TermsID = @termsid)
	if @termsid is null
		select @termsid = defaulttermsid
		from vendors 
		where vendorid = @vendorid;
	else -- @termsid is not null
		throw 50001, 'invalid termsid.',1;
if @invoiceduedate is null
	begin
		declare @termsduedays int;
		select @termsduedays = termsduedays
		from terms
		where termsid = @termsid;
		set @invoiceduedate = dateadd(day, @termsduedays, @invoiceduedate);
	end
else -- @invoiceduedate is not null
	if @invoiceduedate < @invoicedate or
			datediff(dd, @invoiceduedate, @invoiceduedate) > 180
		throw 50001, 'invalid invoiceduedate.',1;
if @paymentdate < @invoicedate or
		datediff(dd,@paymentdate, getdate()) > 14
	throw 50001, 'invalid paymentdate.',1;

insert invoices
values (@vendorid,			
		@invoicenumber,		
		@invoicedate,		
		@invoicetotal,		
		@paymenttotal,		
		@credittotal,		
		@termsid,			
		@invoiceduedate,		
		@paymentdate);
return @@identity;

begin try
	declare @invoiceid int;
	exec @invoiceid = spinsertinvoice
		 @vendorid = 799,
		 @invoicenumber = 'rz99381',
		 @invoicedate = '2020-02-12',
		 @invoicetotal = 1292.45;
	print 'row was inserted.';
	print 'New invoiceid: ' + convert(varchar, @invoiceid);
end try

begin catch
	print 'an error occurred. row was not inserted.';
	print 'error number: ' + convert(varchar, error_number());
	print 'error message: ' + convert(varchar, error_message());
end catch;