declare @invoiceid int;
	begin try
		begin tran;
		insert invoices
			values(34, 'zxa-080', '2020-03-01', 14092.59, 0, 0, 2, '2020-03-31', null);
		set @invoiceid = @@IDENTITY;
		insert InvoiceLineItems values (@invoiceid, 1, 160, 4447.23, 'HW Grade');
		insert InvoiceLineItems values (@invoiceid, 2, 167, 9645.36, 'OS Grade');
		commit tran;
	end try
	begin catch
		rollback tran;
	end catch;