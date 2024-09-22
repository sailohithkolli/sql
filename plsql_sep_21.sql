select * from employees where employee_id = 200;


set SERVEROUTPUT on;

declare
    cursor c1 is select first_name,last_name from employees;
    empfname employees.first_name%type;
    emplname employees.last_name%type;
begin
    open c1;
loop
    fetch c1 into empfname,emplname;
exit when c1%notfound;
dbms_output.put_line(empfname||'|'||emplname);
end loop;
    close c1;
end;
/

select * from jobs;

set serveroutput on;

declare 
    cursor c1 is select * from jobs;
    v_job jobs%ROWTYPE;
begin
    open c1;
loop
    fetch c1 into v_job;
exit when c1%notfound;
dbms_output.put_line(v_job.job_id);
dbms_output.put_line(v_job.job_title);
dbms_output.put_line(v_job.min_salary);
dbms_output.put_line(v_job.max_salary);
end loop;
    close c1;
end;
/
