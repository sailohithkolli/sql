set serveroutput on;

begin
dbms_output.put_line('Welcome to Oracle - PL/SQL');
end;
/

declare 
var1 VARCHAR2(20);
num1 int(3);
BEGIN
var1 := 'Sai';
num1 := 100;
dbms_output.put_line('var1 is:' || var1);
dbms_output.put_line('num1 is:' || num1);
END;
/

--Assigning data after the declare block

Declare 
temp varchar2(10) ;
temp1 int(10) ;
temp2 numeric(4,2) ;
temp3 DATE ;
BEGIN
temp := 'test';
temp1 := 6789255690;
temp2 := 20.00;
temp3 := to_date('12-09-2024','DD-MM-YYYY');

dbms_output.put_line('temp:' || temp);
dbms_output.put_line('temp1:' || temp1);
dbms_output.put_line('temp2:' || temp2);
dbms_output.put_line('temp3:' || temp3);
END;
/

--Assigning the data inside the declare block

Declare 
temp varchar2(10) := 'test';
temp1 int(10) := 6789255690;
temp2 numeric(4,2) := 20.00;
temp3 DATE := to_date('12-09-2024','DD-MM-YYYY');
BEGIN
dbms_output.put_line('temp:' || temp);
dbms_output.put_line('temp1:' || temp1);
dbms_output.put_line('temp2:' || temp2);
dbms_output.put_line('temp3:' || temp3);
END;
/

declare
employeeid int ;
fullname varchar2(30);
begin
select eid,fname||' '||lname into employeeid,fullname from emp where eid = 1;
dbms_output.put_line('The Employee id is ' || employeeid);
dbms_output.put_line('The Employee name is ' || fullname);
end;
/


--for getting a row record:

declare
record emp%rowtype;
begin
select * into record from emp where eid = 1;
dbms_output.put_line( record.eid || '|' || record.fname || '|' || record.lname);
end;
/