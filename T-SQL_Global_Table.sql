create table ##randomSSNSs
(ssn_id int    identity,
 ssn    char(9) Default
		left(cast(cast(ceiling(rand()*10000000000) as bigint) as varchar), 9));

insert ##randomSSNSs values (default);
insert ##randomSSNSs values (default);
insert ##randomSSNSs values (default);
insert ##randomSSNSs values (default);
insert ##randomSSNSs values (default);
insert ##randomSSNSs values (default);
select *
from ##randomSSNSs;