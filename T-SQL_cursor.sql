use AP;

declare @invoiceidvar int,
        @invoicetotalvar money,
		@updatecount int;
set @updatecount = 0;

declare invoices_cursor cursor
for
	select invoiceid,
		   invoicetotal
	from invoices
	where invoicetotal - paymenttotal - credittotal > 0;

open invoices_cursor;

fetch next from invoices_cursor 
into @invoiceidvar, @invoicetotalvar;
while @@FETCH_STATUS <> -1
	begin
		if @invoicetotalvar > 1000
		begin
			update invoices
			set credittotal = credittotal + (invoicetotal * .1)
			where invoiceid = @invoiceidvar;

			set @updatecount = @updatecount + 1;
		end;
		fetch next from invoices_cursor into @invoiceidvar, @invoicetotalvar;
	end;

close invoices_cursor;
deallocate invoices_cursor;

print ' ';
print convert(varchar, @updatecount) + ' row(s) updated.';