begin try
	insert invoices
	values(799, 'zxk-799', '2020-03-07', 299.95, 0, 0, 1, '2020-04-06', null);
	print 'success: record was inserted.';
end try
begin catch
	print 'failure: record was not inserted.';
	print 'error ' + convert(varchar, error_number(), 1) + ': ' + error_message();
end catch;