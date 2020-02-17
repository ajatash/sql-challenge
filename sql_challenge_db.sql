

create table Employees (
	emp_no INT NOT NULL PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);

copy Employees from '/Users/employees.csv'
with (format CSV, HEADER);



create table Departments (
	dept_no VARCHAR NOT NULL PRIMARY KEY,
	dept_name VARCHAR
);

copy Departments from '/Users/departments.csv'
with (format CSV, HEADER);




create table Managers (
	dept_no VARCHAR,
	emp_no INT,
	from_date DATE,
	to_date DATE,
	Primary Key (emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);

copy Managers from '/Users/dept_manager.csv'
with (format CSV, HEADER);

select * from Managers;


create table Salaries(
	emp_no INT NOT NULL PRIMARY KEY,
	salary INT,
	from_date DATE,
	to_date DATE
);

copy Salaries from '/Users/salaries.csv'
with (format CSV, HEADER);

select * from Salaries;

create table Titles(
	emp_no INT,
	title VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no)
);


copy Titles from '/Users/titles.csv'
with (format CSV, HEADER);

create table Employee_Departments (
	emp_no INT,
	dept_no VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no)
);


copy Employee_Departments from '/Users/dept_emp.csv'
with (format CSV, HEADER);



select a.emp_no,
a.first_name,
a.last_name,
a.gender,
b.salary
from Employees a
join Salaries b
	on a.emp_no = b.emp_no;
	
select emp_no,
first_name,
last_name,
hire_date
from Employees
where hire_date >= '1/1/1986' and hire_date <= '12/31/1986'
order by hire_date ASC;

select a.dept_no,
b.dept_name,
a.emp_no,
c.last_name,
c.first_name,
a.from_date,
a.to_date
from Managers a
join Departments b
	on a.dept_no = b.dept_no
join Employees c
	on a.emp_no = c.emp_no;

select a.emp_no,
a.last_name,
a.first_name,
c.dept_name
from Employees a
join Employee_Departments b
	on a.emp_no = b.emp_no
join Departments c
	on b.dept_no = c.dept_no
order by dept_name;

select emp_no,
first_name,
last_name
From Employees
where first_name = 'Hercules'
	and last_name like 'B%'
order by last_name;


select a.emp_no,
a.last_name,
a.first_name,
c.dept_name
from Employees a
join Employee_Departments b
	on a.emp_no = b.emp_no
join Departments c
	on b.dept_no = c.dept_no
where c.dept_name = 'Sales'
order by last_name;

select a.emp_no,
a.last_name,
a.first_name,
c.dept_name
from Employees a
join Employee_Departments b
	on a.emp_no = b.emp_no
join Departments c
	on b.dept_no = c.dept_no
where c.dept_name = 'Sales'
	or c.dept_name = 'Development'
order by dept_name, last_name;

SELECT last_name, COUNT(*) 
FROM Employees
GROUP BY last_name;