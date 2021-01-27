use AP;
if OBJECT_ID ('firstinvoice') is not null
	drop view firstinvoice;
go

create view firstinvoice as

	SELECT VendorID, 
	MIN(InvoiceDate) AS FirstInvoiceDate
	FROM Invoices
	GROUP BY VendorID;


SELECT VendorName, FirstInvoiceDate, InvoiceTotal
FROM Invoices JOIN firstinvoice
  ON (Invoices.VendorID = firstinvoice.VendorID AND
      Invoices.InvoiceDate = firstinvoice.FirstInvoiceDate)
JOIN Vendors
  ON Invoices.VendorID = Vendors.VendorID
ORDER BY VendorName, FirstInvoiceDate;