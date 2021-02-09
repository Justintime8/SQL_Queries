begin tran;
print 'first tran @@trancount: ' + convert(varchar,@@trancount);
delete invoices;
	begin tran;
		print 'second tran @@trancount: ' + convert(varchar, @@trancount);
		delete vendors;
	commit tran;				--this commit decrements @@trancount.
								--doesn't commit 'delete vendors';
	print 'commmit       @@trancount: ' + convert(varchar, @@trancount);
rollback
print 'rollback			 @@trancount: ' + convert(varchar, @@trancount);

print ' ';
declare @vendorscount int, @invoicecount int;
select @vendorscount = count(*) from vendors;
select @invoicecount = count(*) from invoices;
print 'vendors count: ' + convert(varchar , @vendorscount);
print 'invoice count: ' + convert(varchar, @invoicecount);
