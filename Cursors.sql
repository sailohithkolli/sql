set serveroutput on;

-- basic Cursor:

declare
    cursor c2 is select * from employees;
    r employees%rowtype;
begin
    open c2;
    fetch c2 into r;
    dbms_output.put_line(r.first_name);
close c2;
end;
/

-- Cursor with loop:

declare
    cursor c2 is select * from employees;
    r employees%rowtype;
begin
    open c2;
--loop
    fetch c2 into r;
--exit when c2%notfound;
    dbms_output.put_line(r.first_name);
--end loop;
close c2;
end;
/

-- Cursor with for loop

declare
cursor c3 is select * from jobs;
begin
for r in c3
    loop
        dbms_output.put_line(r.job_id);
    end loop;
end;
/

--play around

declare
    cursor c4 is select job_id,job_title from jobs where min_salary>3000;
    begin
    for s in c4
        loop
            dbms_output.put_line(s.job_id||' '||s.job_title);
        end loop;
    end;
    /

--current of clause

declare cursor c5 is select * from employees for update of salary nowait;
begin
for r in c5
loop
update employees set salary =salary+1000 where current of c5;
end loop;
for r in c5
loop
dbms_output.put_line(r.salary);
end loop;
end;
/
