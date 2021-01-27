use AP;

if OBJECT_ID('tempdb..#tablesummary') is not null
	drop table #tablesummary;

select sys.tables.name tablename,
	   sys.columns.name columnname,
	   sys.types.name type
into #tablesummary
from sys.tables
join sys.columns on sys.tables.object_id = sys.columns.object_id
join sys.types on sys.columns.system_type_id = sys.types.system_type_id
where sys.tables.name in (select name
						  from sys.tables
						  where name not in ('dtproperties', 'tablesummary', 'allusertables'));

if OBJECT_ID('tempdb..#allusertables') is not null
	drop table #allusertables;

create table #allusertables
(tableid int identity,
 tablename varchar(128));
go

insert #allusertables (tablename)
select name
from sys.tables
where name not in ('dtproperties', 'tablesummary', 'allusertables');


declare @loopmax int, @loopvar int;
declare @tablenamevar varchar(128), @excecvar varchar(1000);

select @loopmax = max(tableid)
from #allusertables

set @loopvar = 1;

while @loopvar <= @loopmax
	begin 
		select @tablenamevar = tablename
			from #allusertables
			where tableid = @loopvar;
		set @excecvar = 'declare @countvar int; ';
		set @excecvar = @excecvar + 'select @countvar = count(*) ';
		set @excecvar = @excecvar + 'From ' + @tablenamevar + '; ';
		set @excecvar = @excecvar + 'insert #tablesummary ';
		set @excecvar = @excecvar + 'values (''' + @tablenamevar + ''',';
		set @excecvar = @excecvar + '''*row count*'',';
		set @excecvar = @excecvar + ' @countvar);';
		exec (@excecvar);
		set @loopvar = @loopvar + 1;
	end;
select *
from #tablesummary
order by tablename, columnname;