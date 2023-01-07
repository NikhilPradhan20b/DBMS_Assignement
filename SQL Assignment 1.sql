CREATE DATABASE Employee_database;
CREATE TABLE employee (
  employee_name VARCHAR(255) PRIMARY KEY, 
  street VARCHAR(255), 
  city VARCHAR(255)
);
CREATE TABLE works (
  employee_name VARCHAR(255), 
  company_name VARCHAR(255), 
  salary int, 
  FOREIGN KEY(employee_name) REFERENCES employee(employee_name)
);
CREATE TABLE company (
  company_name VARCHAR(255) PRIMARY KEY, 
  city VARCHAR(255)
);
CREATE TABLE manages (
  employee_name VARCHAR(255), 
  manager_name VARCHAR(255), 
  FOREIGN KEY(employee_name) REFERENCES employee(employee_name)
);
INSERT INTO employee (employee_name, street, city) 
VALUES 
  ('Nikhil', 'Balaju', 'Kathmandu'), 
  (
    'Mishan', 'Buddhanagar', 'Lumbini'
  ), 
  ('Bishal', 'Gabahal', 'Lalitur'), 
  (
    'Ankit', 'Narayangadh', 'Chitwan'
  ), 
  ('Ram', 'Balaju', 'Kathmandu'), 
  ('Shyam', 'Chameli', 'Palpa'), 
  ('Sita', 'Rumebazar', 'Parbat'), 
  ('Hari', 'Sauraha', 'Chitwan');
INSERT INTO works (
  employee_name, company_name, salary
) 
VALUES 
  (
    'Nikhil', 'First Bank Corporation', 
    5000
  ), 
  (
    'Mishan', 'Autoworks Nepal', 9000
  ), 
  ('Bishal', 'Electronepal', 6000), 
  (
    'Ankit', 'Zipo Handicrafts', 7000
  ), 
  (
    'Ram', 'First Bank Corporation', 
    20000
  ), 
  (
    'Shyam', 'Autoworks Nepal', 15000
  ), 
  ('Sita', 'Electronepal', 50000), 
  (
    'Hari', 'Zipo Handicrafts', 30000
  );
INSERT INTO manages (employee_name, manager_name) 
VALUES 
  ('Nikhil', 'Ram'), 
  ('Mishan', 'Shyam'), 
  ('Bishal', 'Sita'), 
  ('Ankit', 'Hari');
INSERT INTO company(company_name, city) 
VALUES 
  (
    'First Bank Corporation', 'Kathmandu'
  ), 
  ('Autoworks Nepal', 'Chitwan'), 
  ('Electronepal', 'Lalitur'), 
  ('Zipo Handicrafts', 'Bhaktapur'), 
  ('Red Bank', 'Chitwan');
  
/* 2a Query */
SELECT 
  employee_name 
FROM 
  works 
WHERE 
  company_name = 'First Bank Corporation';
  
/* 2a JOIN */
SELECT employee_name 
FROM 
employee NATURAL JOIN works
WHERE (company_name='First Bank Corporation');


  
/* 2b Query */
SELECT 
  employee_name, 
  city 
FROM 
  employee 
WHERE 
  employee_name in (
    SELECT 
      employee_name 
    FROM 
      works 
    WHERE 
      company_name = 'First Bank Corporation'
  );
  
  
/* 2b Join */
SELECT employee.employee_name ,employee.city
FROM
employee NATURAL JOIN works

 WHERE works.company_name =
'First Bank Corporation' ;
  
/* 2c Query */
SELECT 
  * 
FROM 
  employee 
WHERE 
  employee_name in (
    SELECT 
      employee_name 
    FROM 
      works 
    WHERE 
      company_name = 'First Bank Corporation' 
      AND salary > 10000
  );
  
  /* 2c Join */
SELECT employee.employee_name ,employee.city,employee.street
FROM
employee
NATURAL JOIN
works
WHERE
 works.company_name  =
'First Bank Corporation' and works.salary>10000 ;
  
/* 2d Query */
SELECT 
  employee.employee_name 
FROM 
  employee, 
  works, 
  company 
WHERE 
  employee.employee_name = works.employee_name 
  AND works.company_name = company.company_name 
  AND employee.city = company.city;
  
  
  /* 2d Join */
SELECT employee.employee_name
FROM
employee
NATURAL JOIN 
works
NATURAL JOIN
company
;

/* 2e Query */
SELECT 
  employee_name 
FROM 
  employee 
WHERE 
  street IN (
    SELECT 
      street 
    from 
      employee, 
      manages 
    where 
      employee.employee_name = manager_name
  ) 
  AND city IN (
    SELECT 
      city 
    from 
      employee, 
      manages 
    where 
      employee.employee_name = manager_name
  ) 
  and employee_name IN(
    SELECT 
      employee_name 
    from 
      manages
  );
  

  
/* 2f Query */
SELECT 
  employee_name 
FROM 
  works 
WHERE 
  NOT company_name = 'First Bank Corporation';
  
/* 2f Join */
SELECT employee_name 
FROM
employee
NATURAL JOIN
works
WHERE (company_name!='First Bank Corporation');
  
/* 2g Query */
SELECT 
  employee_name 
FROM 
  works 
WHERE 
  salary > ALL (
    SELECT 
      salary 
    FROM 
      works 
    WHERE 
      company_name = 'Autoworks Nepal'
  );
  
  
  /* 2g Join */
  
SELECT employee_name
FROM 
employee
NATURAL JOIN
works
WHERE
salary >( SELECT max(salary) FROM works
WHERE
company_name='First Bank Corporation')
;

  
/* 2h Query */
SELECT 
  company_name 
FROM 
  company 
WHERE 
  city IN (
    SELECT 
      city 
    FROM 
      company 
    WHERE 
      company_name = 'Autoworks Nepal'
  ) 
  AND company_name != 'Autoworks Nepal';
  
/* 2h Join */

SELECT company_name
FROM
company
NATURAL JOIN
works
WHERE
city = 
(SELECT
city
FROM 
company
WHERE
company.company_name='First Bank Corporation');
  
  
  
/* 2i Query */
SELECT 
  employee_name 
FROM 
  works 
WHERE 
  salary > (
    SELECT 
      AVG(salary) 
    FROM 
      works, 
      company, 
      employee 
    WHERE 
      works.company_name = company.company_name
  );
  
  
  
  
/* 2j Query */
SELECT 
  company_name 
FROM 
  (
    SELECT 
      company_name, 
      COUNT(employee_name) AS employee_count 
    FROM 
      works 
    GROUP BY 
      company_name
  ) as Tbl_count 
ORDER BY 
  employee_count DESC 
LIMIT 
  1;
  
/* 2k Query */
SELECT 
  company_name 
FROM 
  works 
WHERE 
  salary = (
    SELECT 
      MIN(salary) 
    FROM 
      works
  );
  
  
/* 2l Query */
SELECT 
  company_name 
FROM 
  works 
WHERE 
  salary > (
    SELECT 
      AVG(salary) 
    FROM 
      works 
    WHERE 
      company_name = 'First Bank Corporation'
  ) 
  AND company_name != 'First Bank Corporation';
  
/* 3a Query */
UPDATE 
  employee 
SET 
  city = 'Newtown' 
WHERE 
  employee_name = 'Ankit';
  
/* 3b Query */
UPDATE 
  works 
SET 
  salary = salary + 0.1 * salary 
WHERE 
  company_name = 'First Bank Corporation';
  
  
/* 3c Query */
UPDATE 
  works, 
  manages 
SET 
  salary = salary + 0.1 * salary 
WHERE 
  works.employee_name = manager_name 
  AND company_name = 'First Bank Corporation';
  
/* 3d Query */
UPDATE 
  works, 
  manages 
SET 
  salary = CASE WHEN salary + 0.1 * salary > salary THEN salary + 0.03 * salary ELSE salary + 0.1 * salary END 
WHERE 
  works.employee_name = manager_name 
  AND company_name = 'First Bank Corporation';

/* 3e Query */
DELETE
FROM
works
WHERE company_name = 'Autoworks Nepal';