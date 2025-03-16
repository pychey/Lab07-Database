-- Q1: Write SQL statement to insert a new record int JOBS table with the following information:
insert into 
jobs(job_id,job_title,min_salary,max_salary)
values("C_ENG","Computer Engineer",2000,5000);

-- Q2: Retrieve all employees who aren’t working in any department.
select * from employees e
where  e.department_id is null;

-- Q3: Write SQL statement to retrieve the last name and salary for all employees whose salary is not in the range 5000 through 12000.
select last_name,salary from employees e
where not e.salary between 5000 and 12000;

-- Q4: Write SQL statement to retrieve the last names of all employees who have both an “a” and an “e” in their last name.
select last_name from employees e
where e.last_name like "%a%" and e.last_name like "%e%";

-- Q5: Write SQL statement to retrieve the last name, salary, and commission for all employees who earn commissions. Sort data in descending order of salary and commissions.
select last_name,salary,commission_pct from employees e
where e.commission_pct is not null
order by salary desc,commission_pct desc;

-- Q6: Write SQL statement to retrieve all employee last names in which the third letter of the name is “a”.
select last_name from employees e
where e.last_name like "__a%";

-- Q7: Write a query to retrieve employees whose job has minimum salary 4200 and maximum salary 9000.
select * from employees e 
join jobs j on e.job_id = j.job_id
where j.min_salary = 4200 and j.max_salary = 9000;

-- Q8: Write a query to retrieve departments’ names and cities for all departments that has more than 5 employees.
