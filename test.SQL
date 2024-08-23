use hr;

select * from employees;

select first_name from employees;
SELECT
*
FROM
employees;

Desc employees;

SELECT
*
FROM
employees
WHERE
job_id = 'FI_ACCOUNT';

SELECT
first_name,
salary + 300
FROM
employees;

SELECT
employee_id,
salary,
300 + 500,
2 * ( salary + 300 + 500 - 800 ) / 2
FROM
employees;

SELECT
employee_id,
hire_date
FROM
employees
WHERE
first_name = 'Steven'
AND last_name = 'King';

SELECT
salary,
commission_pct,
12 * ( salary * commission_pct ) AS "TOTAL SALARY"
FROM
employees
WHERE
12 * ( salary * commission_pct ) IS NULL;

--PRODUCT OF NULL WITH A NUMBER IS NULL.

SELECT
salary,
commission_pct,
12 * ( salary * commission_pct ) AS "TOTAL SALARY"
FROM
employees
WHERE
12 * ( salary * commission_pct ) IS NOT NULL;

SELECT
first_name  AS "NAME OF THE EMPLOYEE",
salary * 12 AS "ANNUAL SALARY"
FROM
employees;

SELECT
employee_id,
hire_date
FROM
employees
WHERE
first_name = 'Steven'
OR last_name = 'King';

SELECT
*
FROM
countries;

desc countries;

SELECT
first_name,
last_name,
first_name
|| ' '
|| last_name AS fullname
FROM
employees;

SELECT
first_name
|| ' IS A '
|| job_id
FROM
employees;

SELECT
job_id
FROM
employees;

SELECT DISTINCT
job_id
FROM
employees;

SELECT DISTINCT
( job_id )
FROM
employees;

SELECT DISTINCT
job_id,
department_id
FROM
employees;

SELECT
employee_id,
first_name,
job_id,
department_id,
salary
FROM
employees
WHERE
department_id = 100;

SELECT
employee_id,
first_name,
job_id,
department_id,
salary
FROM
employees
WHERE
last_name = 'King';

SELECT
first_name,
salary
FROM
employees
WHERE
salary >= 5000;

SELECT
first_name,
salary
FROM
employees
WHERE
salary <> 3000;

SELECT
first_name,
salary
FROM
employees
WHERE
salary != 3000;

SELECT
first_name,
salary
FROM
employees
WHERE
salary BETWEEN 1000 AND 5000;

SELECT
employee_id,
first_name,
salary,
manager_id
FROM
employees
WHERE
manager_id BETWEEN 100 AND 103;

SELECT
employee_id,
first_name,
salary,
manager_id
FROM
employees
WHERE
manager_id IN ( 100, 101, 102, 103 );

SELECT
employee_id,
first_name,
salary,
manager_id
FROM
employees
WHERE
last_name IN ( 'King', 'Ernst', 'Chen' );

SELECT
first_name
FROM
employees
WHERE
first_name LIKE 'A%';

SELECT
first_name
FROM
employees
WHERE
first_name LIKE '_a%';

SELECT
first_name
FROM
employees
WHERE
first_name LIKE '%e';

SELECT
employee_id,
first_name,
job_id
FROM
employees
WHERE
job_id LIKE '%ST\_%' ESCAPE '\';

SELECT
first_name,
manager_id
FROM
employees
WHERE
manager_id IS NULL;

SELECT
first_name,
job_id,
commission_pct AS commission
FROM
employees
WHERE
commission_pct IS NULL;

SELECT
RANK()
OVER(
ORDER BY
salary DESC
)            AS rank,
first_name
|| ' '
|| last_name AS fullname,
salary
FROM
employees;

SELECT
*
FROM
employees
WHERE
salary IN ( 7000, 6000 )
ORDER BY
salary DESC;

SELECT
last_name
FROM
employees
WHERE
last_name LIKE 'K%';

SELECT
first_name
FROM
employees
WHERE
first_name LIKE '%K_';

SELECT
first_name
FROM
employees
WHERE
first_name LIKE 'A%'
ORDER BY
first_name ASC;

SELECT
first_name,
length(first_name)
FROM
employees
WHERE
first_name LIKE 'K%';

SELECT
first_name,
length(first_name) AS flen
FROM
employees
WHERE
length(first_name) < 3;

SELECT
*
FROM
employees
WHERE
commission_pct IS NULL;

SELECT
*
FROM
employees
WHERE
commission_pct IS NOT NULL;

SELECT
employee_id,
first_name,
job_id,
salary
FROM
employees
WHERE
salary >= 6000
AND job_id LIKE 'SA%';--35 rows

SELECT
employee_id,
first_name,
job_id,
salary
FROM
employees
WHERE
salary >= 6000
OR job_id LIKE 'SA%';--50 rows

SELECT
employee_id,
first_name,
job_id,
salary
FROM
employees
WHERE
job_id IN ( 'ST_MAN%', 'ST_CLERK', 'SA_MAN' );

SELECT
employee_id,
first_name,
job_id,
salary
FROM
employees
WHERE
job_id NOT IN ( 'ST_MAN%', 'ST_CLERK', 'SA_MAN' );

SELECT
first_name,
job_id,
department_id
FROM
employees
ORDER BY
first_name ASC;

SELECT
first_name,
job_id,
department_id
FROM
employees
ORDER BY
first_name DESC;

SELECT
first_name,
job_id,
department_id,
12 * salary AS annual_salary
FROM
employees
ORDER BY
annual_salary ASC;

SELECT
first_name,
job_id,
department_id,
12 * salary AS annual_salary
FROM
employees
ORDER BY
first_name,
job_id ASC;

SELECT
first_name,
job_id,
department_id,
12 * salary AS annual_salary
FROM
employees
ORDER BY
job_id,
first_name ASC;

desc employees;

SELECT
*
FROM
employees
WHERE
hire_date = '01-Jan-06';

SELECT
*
FROM
employees
WHERE
hire_date > '01-Jan-06';

SELECT
*
FROM
employees
WHERE
hire_date < '01-Jan-06';

SELECT
*
FROM
employees
WHERE
hire_date <= '01-Jan-06';

SELECT
*
FROM
employees
WHERE
hire_date >= '01-Jan-06';

SELECT
*
FROM
employees
WHERE
hire_date <> '01-Jan-06';

SELECT
*
FROM
employees
WHERE
hire_date BETWEEN '01-Jan-06' AND '01-Jan-10';

SELECT
*
FROM
employees
WHERE
hire_date IN ( '03-JAN-06', '21-MAY-07' );

SELECT
*
FROM
employees
WHERE
hire_date LIKE '%06';

SELECT
*
FROM
employees
WHERE
hire_date LIKE '%JAN%';

SELECT
*
FROM
employees
WHERE
hire_date LIKE '3%';

SELECT
*
FROM
dual;

SELECT
sai'
FROM
dual;

SELECT
1'
FROM
dual;

SELECT
sysdate
FROM
dual;

SELECT
1 + 1
FROM
dual;

SELECT
1 + 1
FROM
employees;

SELECT
upper('SQL')
FROM
dual;

-- WHY is dual which has name coloumn with varchar 2 datatype and size 1 allowing 3 characters into its data?

SELECT
first_name,
upper(first_name),
upper(last_name),
last_name
FROM
employees;

SELECT
first_name,
lower(first_name),
lower(last_name),
last_name
FROM
employees;

SELECT
email
FROM
employees;

SELECT
initcap(email)
FROM
employees;

SELECT
concat('Oracle', ' SQL')
FROM
dual;

SELECT
Oracle' || ' SQL' AS concatfunc
FROM
dual;

SELECT
concat(first_name, last_name)
FROM
employees;

SELECT
substr('ORACLE SQL', 1, 6)
FROM
dual;
-- it is showing same for starting from 0 and also 1 .//double check gpt
-- ans: oracle sql or sql in general starts start_pos from 1 irrespective of i give 0 or 1 .

SELECT
substr('ORACLE SQL', 1, 6)
FROM
dual;

SELECT
length('ORACLE SQL')
FROM
dual;

SELECT
MIN(length(first_name)),
MAX(length(first_name))
FROM
employees;

SELECT
instr('ORACLE SQL', 'L')
FROM
dual;

SELECT
first_name,
instr(first_name, 'e')
FROM
employees
WHERE
instr(first_name, 'e') > 0;

SELECT
first_name,
substr(first_name, 1, 5)
FROM
employees;

SELECT
lpad(first_name, 10, '*'),
length(first_name),
length(lpad(first_name, 10, '*')) - length(first_name) AS lpad_length,
length(lpad(first_name, 10, '*'))                      AS length
FROM
employees;

SELECT
rpad(first_name, 10, ', Good'),
length(first_name),
length(rpad(first_name, 10, '*')) - length(first_name) AS rpad_length,
length(rpad(first_name, 10, '*'))                      AS length
FROM
employees;

SELECT
*
FROM
dual;

SELECT
round(3456.6826, 0)
FROM
dual;

SELECT
round(3456.6826, 2)
FROM
dual;

SELECT
round(3456.6240, 2)
FROM
dual;

SELECT
round(3456.6240, 0)
FROM
dual;

SELECT
trunc(3456.6826, 4)
FROM
dual;

SELECT
trunc(3456.9999, 3)
FROM
dual;
-- chopd off the number

SELECT
mod(6, 5)
FROM
dual;

SELECT
mod(2, 10)
FROM
dual;

SELECT
mod(15, 2)
FROM
dual;

SELECT
TO_DATE('31/05/2000', 'DD/MM/YYYY')
FROM
dual;

SELECT
TO_DATE('11-01-2010', 'DD-MM-YYYY')
FROM
dual;

SELECT
TO_DATE('01-SEP-2007', 'DD-MON-YYYY')
FROM
dual;

SELECT
TO_DATE('20-SEP-07', 'DD-MON-YY')
FROM
dual;

SELECT
sysdate
FROM
dual;

SELECT
to_char(sysdate, 'DD-MON-YY')
FROM
dual;

SELECT
to_char(sysdate, 'DD/MON/YYYY')
FROM
dual;

SELECT
to_char(sysdate, 'DD/MM/YY')
FROM
dual;

SELECT
to_char(sysdate, 'DD MON YYYY')
FROM
dual;

SELECT
to_char(sysdate, 'DD DAY MON YYYY')
FROM
dual;

SELECT
to_char(sysdate, 'DD DAY MON YEAR')
FROM
dual;

SELECT
to_char(sysdate, 'DD MON YEAR, DAY')
FROM
dual;

SELECT
to_char(sysdate, 'DD MON YEAR, DAY, HH:MI:SS')
FROM
dual;

SELECT
to_char(sysdate, 'DD MON YEAR, DAY, HH24:MI:SS')
FROM
dual;

SELECT
to_char(hire_date, 'DD-MON-YYYY ,DAY , HH:MI:SS')
FROM
employees;

SELECT
TO_NUMBER('3456')
FROM
dual;

desc employees;

SELECT
TO_NUMBER('3456')
FROM
employees;

SELECT
sysdate + 1
FROM
dual;

SELECT
sysdate + 2
FROM
dual;

SELECT
sysdate + 3
FROM
dual;

SELECT
sysdate + 4
FROM
dual;

SELECT
sysdate + 5
FROM
dual;

SELECT
hire_date
FROM
employees;

SELECT
hire_date,
hire_date + 3
FROM
employees;

SELECT
sysdate
FROM
dual;

SELECT
to_char(sysdate + 6 / 24, 'DD-MON-YY DAY HH:MI:SS')
FROM
dual;

SELECT
to_char(sysdate - 6 / 24, 'DD-MON-YY DAY HH:MI:SS')
FROM
dual;

SELECT
months_between('06-SEP-85', '17-JAN-84')
FROM
dual;

SELECT
add_months('24-JAN-04', 5)
FROM
dual;

SELECT
add_months(sysdate, 5)
FROM
dual;

SELECT
hire_date,
add_months(hire_date, 5)
FROM
employees;

SELECT
next_day(sysdate, 'FRIDAY')
FROM
dual;

SELECT
last_day(sysdate)
FROM
dual;

SELECT
last_day(hire_date),
hire_date
FROM
employees;

SELECT
hire_date,
to_char(round(hire_date, 'YEAR'),
YYYY')
FROM
employees;

SELECT
sysdate,
round(sysdate, 'YYYY')
FROM
dual;

SELECT
trunc(sysdate, 'YYYY')
FROM
dual;

SELECT
first_name,
manager_id,
job_id,
salary,
CASE job_id
WHEN 'AD_PRES'    THEN
( 1.15 * salary )
WHEN 'AD_VP'      THEN
( 1.25 * salary )
WHEN 'FI_AACOUNT' THEN
( 1.35 * salary )
ELSE
salary
END AS salary
FROM
employees;

SELECT
first_name,
manager_id,
job_id,
salary,
decode(job_id, 'AD_PRES',(1.15 * salary), 'AD_VP',(1.25 * salary),
FI_ACCOUNT',(1.35 * salary), salary) AS "REVISED SALARY"
FROM
employees;

SELECT
first_name,
manager_id,
job_id,
salary,
decode(job_id, 'AD_PRES', 'PRESIDENT', 'AD_VP', 'VICE PRESIDENT',
FI_ACCOUNT', 'FINANCIAL ACCOUNT') AS expansion
FROM
employees
WHERE
decode(job_id, 'AD_PRES', 'PRESIDENT', 'AD_VP', 'VICE PRESIDENT',
FI_ACCOUNT', 'FINANCIAL ACCOUNT') IS NOT NULL;

SELECT
*
FROM
dual;

SELECT
sysdate
FROM
dual;

SELECT
hire_date,
add_months(hire_date, 5)
FROM
employees;
