create function fncreditadj
	(@howmuch money)
	returns @outtable table
		(invoiceid int, vendorid int, invoicenumber varchar(50),
		 invoicedate date, invoicetotal money,
		 paymenttotal money, credittotal money)

begin
	insert @outtable
		select invoiceid, vendorid, invoicenumber, invoicedate,
			   invoicetotal, paymenttotal, credittotal
		from invoices
		where invoicetotal - credittotal - paymenttotal > 0;
	while (select sum(invoicetotal - credittotal - paymenttotal)
	       from @outtable) >= @howmuch
		   update @outtable
		   set credittotal = credittotal + .01
		   where invoicetotal - credittotal - paymenttotal > 0;
	return;
end;

go

select vendorname,
       sum(credittotal) creditrequest
from vendors
join dbo.fncreditadj(25000) credittable
on vendors.vendorid = credittable.vendorid
group by vendorname;