select i.vendorid,
       max(invoicedate) latestInvo
from invoices i
join #topvendors t on i.VendorID = t.vendorID
group by i.VendorID

