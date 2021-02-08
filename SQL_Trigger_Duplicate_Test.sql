use AP;

go

create table testuniquenulls
(rowid	int	identity	not null,
 nodupname	varchar(20)	null);

go

use AP;

go

create trigger dup_test
	on testuniquenulls
	after insert, update
as

begin
	if
		(select count(*)
		 from testuniquenulls
		 join inserted on inserted.nodupname = testuniquenulls.nodupname) > 1
	begin
		rollback tran;
		throw 50001, 'duplicate found', 1;
	end;
end;
		
go

USE AP;

INSERT into testuniquenulls 
VALUES (NULL);

INSERT into testuniquenulls 
VALUES (NULL);

INSERT into testuniquenulls 
VALUES ('Sherry Yu');

INSERT into testuniquenulls 
VALUES ('Sherry Yu'); 

