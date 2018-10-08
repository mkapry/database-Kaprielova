CREATE TABLE users (
user_id INT not null auto_increment ,
login VARCHAR (45),
reg_dttm TIMESTAMP,
primary key (user_id)
) engine=InnoDB default charset=utf8;

create table payments(
payment_id int,
user_id int,
foreign key (user_id) references users (user_id),
payment_sum double,
payment_dttm timestamp
 ) engine=InnoDB default charset=utf8;
 
 create table sessions(
session_id int,
user_id int,
foreign key (user_id) references users (user_id),
begin_dttm timestamp,
end_dttm timestamp default current_timestamp
 ) engine=InnoDB default charset=utf8;

select user_id, sum(payment_sum) as sum
from track18spring.payments
group by user_id
order by sum desc
limit 3;

select sql_calc_found_rows * from track18spring.sessions
