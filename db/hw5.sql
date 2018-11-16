use automobile;
create table users (
user_id INT not null,
license_id int,
age int,
exp int,
rating int,
primary key(user_id)
) engine=InnoDB default charset=utf8;

create table enshurance (
ensh_id INT not null,
price int,
company varchar(45),
ensh_t varchar(45),
start_dttm TIMESTAMP default current_timestamp,
end_dttm TIMESTAMP default current_timestamp,
primary key(ensh_id)
) engine=InnoDB default charset=utf8;

create table cars (
car_id INT not null,
rating int,
primary key(car_id)
) engine=InnoDB default charset=utf8;

create table property (
prop_id INT not null auto_increment,
ensh_id INT not null,
car_id INT not null,
user_id INT not null,
primary key(prop_id)
) engine=InnoDB default charset=utf8;


ALTER TABLE property ADD 
foreign key (ensh_id) references enshurance (ensh_id)
ON UPDATE CASCADE;

ALTER TABLE property ADD 
foreign key (car_id) references cars (car_id)
ON UPDATE CASCADE;

ALTER TABLE property ADD 
foreign key (user_id) references users (user_id)
ON UPDATE CASCADE;