create table users (
user_id int not null auto_increment,
license_id int,
age int,
exp int,
rating int,
primary key(user_id)
) engine=InnoDB default charset=utf8;

create table enshurance (
ensh_id int not null auto_increment,
price int,
company varchar(45),
ensh_t varchar(45),
start_dttm TIMESTAMP default current_timestamp,
end_dttm TIMESTAMP default current_timestamp,
primary key(ensh_id)
) engine=InnoDB default charset=utf8;

create table cars (
car_id int not null auto_increment,
rating int,
primary key(car_id)
) engine=InnoDB default charset=utf8;

create table property (
prop_id int not null auto_increment,
foreign key (ensh_id) references enshurance (ensh_id),
foreign key (user_id) references users (user_id),
foreign key (car_id) references cars (car_id),
primary key(prop_id)
) engine=InnoDB default charset=utf8;