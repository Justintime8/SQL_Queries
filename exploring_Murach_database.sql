use ap

go

-- looking at balances that are due with dates
select InvoiceNumber,
       (InvoiceTotal - PaymentTotal - CreditTotal) balance_due,
	   InvoiceDueDate
from Invoices
where (InvoiceTotal - PaymentTotal - CreditTotal) > 0


-- looking at count of item descriptions with cost
select * 
from InvoiceLineItems

select invoicelineitemdescription,
       count(invoicelineitemdescription) num_of_items,
	   sum(invoicelineitemamount) total_cost,
	   case 
	       when sum(invoicelineitemamount) > 25000 then ' xlarge buy'
		   when sum(invoicelineitemamount) > 15000 then ' large buy'
		   when sum(invoicelineitemamount) > 10000 then ' medium buy'
		   when sum(invoicelineitemamount) > 5000 then 'small buy'
		   when sum(InvoiceLineItemAmount) > 2500 then 'tiny buy'
		   else 'buy'
		   end buy_size
from InvoiceLineItems
group by InvoiceLineItemDescription
order by 1 desc

select *
from InvoiceLineItems
where InvoiceLineItemDescription = 'Freight'

select invoicelineitemdescription,
       count(invoicelineitemdescription) num_of_items,
	   sum(invoicelineitemamount) total_cost,
	   case 
	       when sum(invoicelineitemamount) > 25000 then 'large buy'
		   when sum(invoicelineitemamount) > 15000 then 'medium buy'
		   when sum(invoicelineitemamount) > 10000 then 'small buy'
		   else 'tiny buy'
		   end buy_size
from InvoiceLineItems
group by InvoiceLineItemDescription
order by 1 desc

create view buy_type as
select invoicelineitemdescription,
       count(invoicelineitemdescription) num_of_items,
	   sum(invoicelineitemamount) total_cost,
	   case 
	       when sum(invoicelineitemamount) > 25000 then ' xlarge buy'
		   when sum(invoicelineitemamount) > 15000 then ' large buy'
		   when sum(invoicelineitemamount) > 10000 then ' medium buy'
		   when sum(invoicelineitemamount) > 5000 then 'small buy'
		   when sum(InvoiceLineItemAmount) > 2500 then 'tiny buy'
		   else 'buy'
		   end buy_size
from InvoiceLineItems
group by InvoiceLineItemDescription;

select *
from buy_type
where buy_size = 'large buy'
order by 3 desc

select *
from buy_type
where buy_size = 'medium buy'
order by 3 desc

select *
from buy_type
where buy_size = 'small buy'

select *
from buy_type
where buy_size = 'tiny buy'

select *
from buy_type
where buy_size = 'buy'
order by 3 desc

select *
from buy_type
where buy_size = 'buy' and
      total_cost > 900
order by 3 desc


-- exploring Example database with invoices
use Examples

go

 select VendorID,
        (InvoiceTotal - PaymentTotal - CreditTotal) balance_due,
		InvoiceDueDate
 from PaidInvoices
 order by 1 asc


-- invoices that paid late, early, and on time
 select *
 from PaidInvoices
 where InvoiceDueDate < PaymentDate

 select *
 from PaidInvoices
 where InvoiceDueDate > PaymentDate
 order by PaymentDate desc

 select *
 from PaidInvoices
 where InvoiceDueDate = PaymentDate

 select sum(invoicetotal) total_of_late_payments
 from PaidInvoices
 where InvoiceDueDate < PaymentDate

 select sum(invoicetotal) total_of_early_payments
 from PaidInvoices
 where InvoiceDueDate > PaymentDate

 select sum(invoicetotal) total_of_payment
 from PaidInvoices
 where InvoiceDueDate = PaymentDate

 
 select  (select sum(invoicetotal) total_of_late_payments
         from PaidInvoices
         where InvoiceDueDate < PaymentDate) -
		 (select sum(invoicetotal) total_of_payment
		  from PaidInvoices
          where InvoiceDueDate = PaymentDate) dif_payments
from PaidInvoices


select *
from PaidInvoices
having  (select sum(invoicetotal) total_of_late_payments
         from PaidInvoices
         where InvoiceDueDate < PaymentDate) -
		 (select sum(invoicetotal) total_of_payment
		  from PaidInvoices
          where InvoiceDueDate = PaymentDate)


create view late_payment as
select sum(invoicetotal) total_of_late_payments
         from PaidInvoices
         where InvoiceDueDate < PaymentDate;

create view payment as
select sum(invoicetotal) total_of_payment
		  from PaidInvoices
          where InvoiceDueDate = PaymentDate;

drop view late_payment, payment

create 