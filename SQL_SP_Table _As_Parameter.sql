create type lineitems as
table
(invoiceid	int	not null,
 invoicesequence smallint not null,
 accountno int not null,
 itemamount money not null,
 itemdescription varchar(100) not null,
 primary key (invoiceid, invoicesequence));

go

create proc spinsertlineitems
	@lineitems lineitems readonly
as
	insert into invoicelineitems
	select *
	from @lineitems;

go

declare @lineitems lineitems;

insert into @lineitems values (114, 8, 553, 127.75, 'Freight');
insert into @lineitems values (114, 2, 553, 29.25, 'Freight');
insert into @lineitems values (114, 3, 553, 48.50, 'Freight');

exec spinsertlineitems @lineitems;