-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT 
    COUNT(emp_no)
FROM
    salaries
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            to_date = '9999-01-01')
        AND to_date = '9999-01-01';
        
        -- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

SELECT 
    a.emp_no, a.first_name, a.last_name, d.dept_name, b.salary
FROM
    employees a,
    salaries b,
    dept_emp c,
    departments d
WHERE
    a.emp_no = b.emp_no
        AND c.dept_no = d.dept_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND b.salary IN (SELECT 
            MAX(d.salary)
        FROM
            employees a,
            dept_emp b,
            salaries d
        WHERE
            a.emp_no = b.emp_no
                AND a.emp_no = d.emp_no
                AND b.to_date = '9999-01-01'
                AND d.to_date = '9999-01-01'
        GROUP BY b.dept_no)
ORDER BY b.salary DESC;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 

SELECT 
    a.emp_no, CONCAT(a.first_name, ' ', a.last_name), c.salary
FROM
    employees a,
    dept_emp b,
    salaries c,
    (SELECT 
        AVG(d.salary) average_sal, b.dept_no average_dept
    FROM
        employees a
    JOIN dept_emp b ON a.emp_no = b.emp_no
    JOIN departments c ON b.dept_no = c.dept_no
    JOIN salaries d ON a.emp_no = d.emp_no
    WHERE
        b.to_date = '9999-01-01'
            AND d.to_date = '9999-01-01'
    GROUP BY b.dept_no) d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.dept_no = d.average_dept
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND c.salary > d.average_sal;
        
        
-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요

SELECT 
    a.emp_no,
    CONCAT(a.first_name, ' ', a.last_name),
    e.manager_name,
    d.dept_name
FROM
    employees a,
    dept_emp b,
    departments d,
    (SELECT 
        CONCAT(a.first_name, ' ', a.last_name) manager_name,
            b.dept_no
    FROM
        employees a, dept_manager b
    WHERE
        a.emp_no = b.emp_no
            AND b.to_date = '9999-01-01') e
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = d.dept_no
        AND b.dept_no = e.dept_no
        AND b.to_date = '9999-01-01';
        
        
        
-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.

SELECT 
    a.emp_no,
    CONCAT(a.first_name, ' ', a.last_name),
    e.title,
    b.salary
FROM
    employees a,
    salaries b,
    dept_emp c,
    (SELECT 
        AVG(b.salary), c.dept_no
    FROM
        employees a, salaries b, dept_emp c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no
    ORDER BY AVG(b.salary) DESC
    LIMIT 0 , 1) d,
    titles e
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND a.emp_no = e.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND e.to_date = '9999-01-01'
ORDER BY b.salary DESC;


-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 

SELECT 
    d.dept_name
FROM
    employees a,
    salaries b,
    dept_emp c,
    departments d
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND c.dept_no = d.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.dept_no
HAVING (AVG(b.salary) , c.dept_no) = (SELECT 
        AVG(b.salary), c.dept_no
    FROM
        employees a,
        salaries b,
        dept_emp c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.dept_no
    ORDER BY AVG(b.salary) DESC
    LIMIT 0 , 1);

    
    
-- 문제7.
-- 평균 연봉이 가장 높은 직책?


SELECT 
    c.title
FROM
    employees a,
    salaries b,
    titles c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY c.title
HAVING (AVG(b.salary) , c.title) = (SELECT 
        AVG(b.salary), c.title
    FROM
        employees a,
        salaries b,
        titles c
    WHERE
        a.emp_no = b.emp_no
            AND a.emp_no = c.emp_no
            AND b.to_date = '9999-01-01'
            AND c.to_date = '9999-01-01'
    GROUP BY c.title
    ORDER BY AVG(b.salary) DESC
    LIMIT 0 , 1);


        -- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

SELECT 
    d.dept_name,
    CONCAT(a.first_name, ' ', a.last_name),
    c.salary,
    e.manager_name,
    e.manager_salary
FROM
    employees a,
    dept_emp b,
    salaries c,
    departments d,
    (SELECT 
        CONCAT(a.first_name, ' ', a.last_name) manager_name,
            b.dept_no,
            c.salary manager_salary
    FROM
        employees a, dept_manager b, salaries c
    WHERE
        a.emp_no = b.emp_no
			AND c.emp_no = a.emp_no
            AND c.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01') e
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = d.dept_no
        AND b.dept_no = e.dept_no
        AND c.emp_no = a.emp_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
        AND c.salary > e.manager_salary;
        