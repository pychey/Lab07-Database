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
select d.department_name, l.city, count(e.employee_id) as NumberOfEmployee
from departments d join locations l on d.location_id = l.location_id 
				   join employees e on e.department_id = d.department_id
group by d.department_name, l.city
having  NumberOfEmployee > 5;

-- Q9: Write a query to get any employee who has salary greater than or equal to 10000.
select * from employees
where salary >= 10000;

-- Q10: Retrieve employees with a salary between 5,000 and 10,000.
select * from employees
where salary between 5000 and 10000;

-- Q12: Fetch any employee who belongs to the 'Executive' department.
select e.* from employees e
join departments d on e.department_id = d.department_id
where d.department_name = "Executive";

-- Q13: Get all employees working in departments 50, 70, or 90.
select * from employees
where department_id in (50,70,90);

-- Q14: Find employees whose first name starts with 'O'.
select * from employees
where first_name like "O%";

-- Q15: Search for employees whose name contains the pattern 'la'.
select * from employees 
where first_name like "%la" or last_name like "%la%";

-- Q16: Retrieve employees whose last name starts with 'K', ends with 'O', and has any characters in between (e.g., Kano, Kenjiro, Kentaro).
select * from employees e
where e.last_name like "K%O";

-- Q17: Display 3 employees starting from the 8th record.
select * from employees
limit 3 offset 7;

-- Q18: Get the addresses (location ID, street address, city, state province, country name) of all departments.
select d.department_name, l.location_id, l.street_address, l.city, l.state_province, c.country_name
from departments d join locations l on d.location_id = l.location_id
				   join countries c on l.country_id = c.country_id;

-- Q19: Retrieve the name (first name, last name), department ID, and department name of all employees.
select e.first_name, e.last_name, d.department_id, d.department_name
from employees e join departments d on d.department_id = e.department_id;

-- Q20: Find employees (first name, last name, job, department ID, department name) who work in London.
select e.first_name, e.last_name, j.job_title, d.department_id, d.department_name, l.city
from employees e join departments d on e.department_id = d.department_id
				 join jobs j on e.job_id = j.job_id
				 join locations l on d.location_id = l.location_id
where l.city = "London";

-- Q21: Retrieve the employee ID, last name, manager ID, and manager's last name.
select e.employee_id, e.last_name, e.manager_id, m.last_name
from employees e join employees m on e.manager_id = m.employee_id;

-- Q22: Fetch the names (first name, last name) and hire date of employees hired after 'Jones'.
select e.first_name, e.last_name, e.hire_date from employees e
where e.hire_date > (
	select jones.hire_date from employees jones
	where jones.first_name = "Jones"
);

-- Q23: Get the department name and count of employees in each department.
select d.department_name, count(e.employee_id) as NumberOfEmployee
from employees e join departments d on e.department_id = d.department_id
group by d.department_name;

-- Q24: Retrieve the employee ID, job title, and the number of days between the ending date and starting date for all jobs in department 90.
select e.employee_id, j.job_title, to_days(jh.end_date) - to_days(jh.start_date) as NumberOfDay
from employees e join jobs j on e.job_id = j.job_id
				 join job_history jh on j.job_id = jh.job_id
where jh.department_id = 90;

-- Q25: Display the department ID, department name, and the first name of the manager.
select d.department_id, d.department_name, m.first_name
from departments d join employees m on d.manager_id = m.employee_id;

-- Q26: Fetch the department name, manager's name, and the city.
select d.department_name, concat(m.first_name,' ',m.last_name) as managerName, l.city
from departments d join employees m on d.manager_id = m.employee_id
				   join locations l on d.location_id = l.location_id;

-- Q27: Retrieve the job title and the average salary of employees.
select j.job_title, avg(e.salary) as avg_salary
from employees e join jobs j on e.job_id = j.job_id
group by j.job_title;

-- Q28: Display the job title, employee name, and the difference between the employee's salary and the minimum salary for the job.
select j.job_title, concat(e.first_name,' ',e.last_name) as name, (e.salary - j.min_salary) as aboveMinimumSalary
from employees e join jobs j on e.job_id = j.job_id;

-- Q29: Get the job history of employees who are currently earning more than 10,000.
select jh.* 
from job_history jh join employees e on jh.employee_id = e.employee_id
where e.salary > 10000;

-- Q30: Retrieve department name, manager’s name (first name, last name), hire date, and salary for managers with more than 15 years of experience.
select d.department_name, concat(m.first_name,' ',m.last_name) as managerName, m.hire_date, m.salary
from employees m join departments d on d.manager_id = m.employee_id
where timestampdiff(year, m.hire_date, curdate()) > 15;

-- Q31: Count the number of distinct jobs available in the employees table.
select count(distinct job_id) as numberOfdistinctJob from employees;

-- Q32: Calculate the total salaries payable to all employees.
select sum(salary + ifnull(employees.commission_pct,0)) as total_salaries from employees;

-- Q33: Retrieve the minimum salary from the employees table.
select min(salary) as min_salary from employees;

-- Q34: Find the maximum salary of an employee working as a Programmer.
select max(e.salary) as maxSalary
from employees e join jobs j on e.job_id = j.job_id
where j.job_title = "Programmer";

-- Q35: Get the average salary and number of employees in department 90.
select avg(salary) as avg_salary, count(employee_id) as NumberOfEmployees
from employees where department_id = 90;

-- Q36: Retrieve the highest, lowest, sum, and average salary of all employees.
select max(salary) as highest_salary, 
       min(salary) as lowest_salary, 
       sum(salary) as total_salary, 
       avg(salary) as avg_salary
from employees;

-- Q37: Count the number of employees with the same job title.
select job_id, count(employee_id) as employeeNumber from employees
group by job_id;

-- Q38: Compute the difference between the highest and lowest salaries.
select (max(salary) - min(salary)) as salaryDiff from employees;

-- Q39: Find the manager ID and the salary of the lowest-paid employee under that manager.
select e.manager_id, min(e.salary) as lowestSalary
from employees e where e.manager_id is not null
group by e.manager_id;

-- Q40: Retrieve the department ID and the total salary payable in each department.
select department_id, sum(salary + ifnull(employees.commission_pct,0)) as total_salary
from employees group by department_id;

-- Q41: Get the average salary for each job ID, excluding Programmers.
select j.job_id, j.job_title, avg(e.salary) as avg_salary
from employees e join jobs j on e.job_id = j.job_id
where j.job_title != "Programmer"
group by j.job_id, j.job_title;

-- Q42: Retrieve the total, maximum, minimum, and average salary of employees (grouped by job ID) for department 90.
select job_id, sum(salary) as totalSal, max(salary) as maxSal, min(salary) as minSal, avg(salary) as avgSal
from employees where department_id = 90
group by job_id;

-- Q43: Find the job ID and maximum salary where the maximum salary is at least $4000.
select job_id, max_salary
from jobs where max_salary >= 4000;

-- Q44: Calculate the average salary for all departments that have more than 10 employees.
select d.department_id, d.department_name, avg(e.salary) as avgSalary
from employees e join departments d on e.department_id = d.department_id
group by d.department_id, d.department_name
having count(e.employee_id) > 10;