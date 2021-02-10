begin tran;
declare @invoicetotal money, @paymenttotal money, @credittotal money;
select @invoicetotal = invoicetotal, @credittotal = credittotal,
       @paymenttotal = paymenttotal from invoices where invoiceid = 112;
update invoices
	set invoicetotal = @invoicetotal, CreditTotal = @credittotal + 317.40,
		paymenttotal = @paymenttotal where invoiceid = 112;
commit tran;

go

begin tran;
declare @invoicetotal money, @paymenttotal money, @credittotal money;
select @invoicetotal = invoicetotal, @credittotal = credittotal,
       @paymenttotal = paymenttotal from invoices where invoiceid = 112,
update invoices	
	set invoicetotal = @invoicetotal, credittotal = @credittotal,
	    PaymentTotal = @invoicetotal - @credittotal
		paymentdate = getdate() where invoiceid = 112;
commit tran;