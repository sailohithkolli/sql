set serveroutput on;

--Write a cursor to retrieve the first name, last name, and email of all employees and display them using DBMS_OUTPUT.

declare
	cursor c1 is select * from Employees;
    r employees%rowtype;
begin
    open c1;
        loop
            fetch c1 into r;
            exit when c1%notfound;
            dbms_output.put_line(r.first_name||' '||r.last_name ||' '||r.email);
        end loop;
    close c1;
end;
/

--Create a cursor to retrieve employees whose salary is greater than $10,000. Display their employee ID, first name, and salary.
--doubt: How to handle the respective fields only in the select statement instead of everything.


declare 
    cursor c2 is select * from employees where salary > 10000;
    r employees%rowtype;
begin
    open c2;
    loop
    fetch c2 into r;
     exit when c2%notfound;
    dbms_output.put_line(r.employee_id||' '||r.first_name||' '||r.last_name);
    end loop;
    close c2;
    end;
    /

--Write a parameterized cursor to fetch the details of employees in a specific department. The department ID should be passed as a parameter to the cursor.

declare 
cursor c3 (dept_id int) is select * from employees where department_id =dept_id ;
r employees%rowtype;
begin
open c3(30);
loop
fetch c3 into r;
exit when c3%notfound;
dbms_output.put_line(r.employee_id||' '||r.first_name||' '||r.last_name);
end loop;
close c3;
end;
/

--Create a cursor that retrieves employees with a salary below $6,500. Update their salary by adding a 10% increase using the cursor.

declare
cursor c4 is select * from employees where salary < 8500;
r employees%rowtype;
begin
open c4;
dbms_output.put_line('Before updating salary:');
loop
fetch c4 into r;
exit when c4%notfound;
dbms_output.put_line(r.employee_id||' '||r.first_name||' '||r.last_name||' '||r.salary);
end loop;
close c4;
dbms_output.put_line('updating salary by 10% for above!');
update employees
set salary = salary + salary * 0.10
where salary < 8500;
commit;
dbms_output.put_line('After updating salary:');
open c4;
loop
fetch c4 into r;
exit when c4%notfound;
dbms_output.put_line(r.employee_id||' '||r.first_name||' '||r.last_name||' '||r.salary);
end loop;
close c4;
end;
/

--Write a cursor to calculate and display the total salary paid to employees in each department. Use the departments table to fetch department IDs.
declare 
cursor c5 is
select 
d.department_name,coalesce(sum(e.salary),0) as total_salary 
from 
departments d 
left join 
employees e 
on 
d.department_id = e.department_id
group by 
d.department_name;
typr employee_record is record (
    department_name varchar2(30),
    total_salary number
);

e employee_record;
begin
open c5;
loop
fetch c5 into e;
exit when c5%notfound;
dbms_output.put_line(e.department_name||'  '||e.total_salary);
end loop;
close c5;
end;
/

--Create a cursor using the FOR loop to retrieve the job title and employee count for each job title from the jobs table.

declare 
cursor c6 is select j.job_title,sum(e.salary) as total_salary from jobs j
left join
employees e
on j.job_id = e.job_id
group by j.job_title;
type job_record is record
(
job_title   varchar2(100),
total_salary NUMBER
);
rec job_record;
begin 
open c6;
loop
fetch c6 into rec;
exit when c6%notfound;
dbms_output.put_line(rec.job_title||' '||rec.total_salary);
end loop;
close c6;
end;
/