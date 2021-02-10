use AP;

begin tran
	update vendors
	set vendorid = 123
	where vendorid = 122

	delete vendors
	where vendorid = 122

	update vendors
	set vendorname = 'FedUp'
	where vendorid = 123
commit tran;