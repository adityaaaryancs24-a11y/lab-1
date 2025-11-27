create database emp;
use emp;
create table dept (
 deptno decimal(2 , 0 ) primary key,
 dname varchar(14) default null,
 loc varchar(13) default null
);
create table emp (
 empno decimal(4 , 0 ) primary key,
 ename varchar(10) default null,
 mgr_no decimal(4 , 0 ) default null,
 hiredate date default null,
 sal decimal(7 , 2 ) default null,
 deptno decimal(2 , 0 ) references dept (deptno)
 on delete cascade on update cascade
);
create table incentives (
 empno decimal(4 , 0 ) references emp (empno)
 on delete cascade on update cascade,
 incentive_date date,
 incentive_amount decimal(10 , 2 ),
 primary key (empno , incentive_date)
);
create table project(pno int primary key,
pname varchar(30)not null,ploc varchar(30));
create table assigned_to (
 empno decimal(4 , 0 ) references emp (empno)
 on delete cascade on update cascade,
 pno int references project (pno)
 on delete cascade on update cascade,
 job_role varchar(30),
 primary key (empno , pno));
 insert into dept values (10, 'accounting', 'mumbai');
insert into dept values (20, 'research', 'bengaluru');
insert into dept values (30, 'sales', 'delhi');
insert into dept values (40, 'operations', 'chennai');

insert into emp values (7468, 'adsarsh', 7002, '2032-02-17', 70000.00, 10);
insert into emp values (7369, 'adarsh', 7902, '2012-12-17', '80000.00', '20');
insert into emp values (7499, 'shruthi', 7698, '2013-02-20', '16000.00', '30');
insert into emp values (7521, 'anvitha', 7698, '2015-02-22', '12500.00', '30');
insert into emp values (7566, 'tanvir', 7839, '2008-04-02', '29750.00', '20');
insert into emp values (7654, 'ramesh', 7698, '2014-09-28', '12500.00', '30');
insert into emp values (7698, 'kumar', 7839, '2015-05-01', '28500.00', '30');
insert into emp values (7782, 'clark', 7839, '2017-06-09', '24500.00', '10');
insert into emp values (7788, 'scott', 7566, '2010-12-09', '30000.00', '20');
insert into emp values (7839, 'king', null, '2009-11-17', '90000', '10');
insert into emp values (7844, 'turner', 7698, '2010-09-08', '15000.00', '30');
insert into emp values (7876, 'adams', 7788, '2013-01-12', '11000.00', '20');
insert into emp values (7900, 'james', 7698, '2017-12-03', '9500.00', '30');
insert into emp values (7902, 'ford', 7566, '2010-12-03', '30000.00', '20');
insert into incentives values(7499, '2019-02-01', 5000.00);
insert into incentives values(7521, '2019-03-01', 2500.00);
insert into incentives values(7566, '2022-02-01', 5070.00);
insert into incentives values(7654, '2020-02-01', 2000.00);
insert into incentives values(7654, '2022-04-01', 879.00);
insert into incentives values(7521, '2019-02-01', 8000.00);
insert into incentives values(7698, '2019-03-01', 500.00);
insert into incentives values(7698, '2020-03-01', 9000.00);
insert into incentives values(7698, '2022-04-01', 4500.00);
insert into project values(101, 'ai project', 'bengaluru');
insert into project values(102, 'iot', 'hyderabad');
insert into project values(103, 'blockchain', 'bengaluru');
insert into project values(104, 'data science', 'mysuru');
insert into project values(105, 'autonomous systems', 'pune');
insert into assigned_to values(7499, 101, 'software engineer');
insert into assigned_to values(7521, 101, 'software architect');
insert into assigned_to values(7566, 101, 'project manager');
insert into assigned_to values(7654, 102, 'sales');
insert into assigned_to values(7521, 102, 'software engineer');
insert into assigned_to values(7499, 102, 'software engineer');
insert into assigned_to values(7654, 103, 'cyber security');
insert into assigned_to values(7698, 104, 'software engineer');
insert into assigned_to values(7900, 105, 'software engineer');
insert into assigned_to values(7839, 104, 'general manager');
select e.empno from emp e, project p,assigned_to a
where e.empno = a.empno AND a.pno = p.pno
and p.ploc in ('BENGALURU' , 'HYDERABAD', 'MYSURU');
select empno from emp
where empno not in (select empno from incentives);
select e.empno , e.ename,d.dname,d.loc,a.job_role,p.ploc
from emp e,dept d,assigned_to a,project p
where e.deptno=d.deptno and
e.empno=a.empno and
a.pno=p.pno and d.loc=p.ploc;
update emp set sal = 1.05*sal;
select ename from emp
where ename like 'A%';
set sql_safe_updates=0;

 