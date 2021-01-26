use master;
if DB_ID('testdb') is not null
	drop database testdb;

create database testdb;

if OBJECT_ID('invoicecopy') is not null
	drop table invoicecopy;

if exists (select *
           from sys.tables
		   where name = 'invoicecopy')

	drop table invoicecopy;

if OBJECT_ID('tempdb..#allusertables') is not null
	drop table #allusertables;