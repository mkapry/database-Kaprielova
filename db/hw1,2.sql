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


select * from users left join payments on (users.user_id=payments.user_id) ;

select login, sum(payment_sum) as sum
from(select login, payment_sum from  users left join payments on (users.user_id=payments.user_id)) as table2
group by login
order by sum desc
limit 3 ;

select * from users left join sessions on (users.user_id = sessions.user_id);

select users.user_id, if(sessions.user_id is null,0, count(*)) as sessions_c from users left join sessions on (users.user_id = sessions.user_id);
 
select avg(sessions_c) as avg_sessions
from (select users.user_id, if(sessions.user_id is null,0, count(*)) as sessions_c from users left join sessions on (users.user_id = sessions.user_id)
group by users.user_id) as table1;



