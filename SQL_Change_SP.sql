create proc spvendorstate
	@state varchar(20)
as
select vendorname
from vendors
where VendorState = @state;

go

alter proc spvendorstate
	@state varchar(20) = null
as
if @state is null
   select vendorname
   from vendors
else
   select vendorname
   from vendors
   where vendorstate = @state;

go

drop proc spvendorstate