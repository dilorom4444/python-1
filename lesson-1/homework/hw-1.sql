select * from emails

truncate table emails

bulk insert  emails
from 

drop table if exists newtable
CREATE TABLE newtable (
    ID INT identity (1,1), PRIMARY KEY,
    Name VARCHAR(100),
    Surname VARCHAR(100),
    PhoneNumber VARCHAR(20)
);
 select * from newtable

 insert into newtable values(2,'alex','puri','654321',23000)
 insert into  newtable values (3,'lucy','ann', '561230',30000)
 alter table newtable
 add salary int default 3000

 update newtable
 set PhoneNumber = '998912345'
 where id =2
