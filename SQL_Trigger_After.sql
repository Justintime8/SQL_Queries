create trigger vendors_insert_update
	on vendors
	after insert, update
as
	update vendors
	set vendorstate = upper(vendorstate)
	where vendorid in (select VendorID
					   from inserted);

go

insert vendors
values('perrless uniforms, inc', '785 s pixley rd', null,
	   'piqua', 'oh', '45356', '(937) 555-8845', null, null, 4, 550);

go 

select * 
from Vendors
where VendorID = 125;