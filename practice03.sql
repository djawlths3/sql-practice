-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
SELECT 
    a.emp_no, CONCAT(a.first_name, ' ', a.last_name), b.salary
FROM
    employees a,
    salaries b
WHERE
    a.emp_no = b.emp_no
ORDER BY b.salary DESC;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
SELECT 
    a.emp_no, CONCAT(a.first_name, ' ', a.last_name), b.title
FROM
    employees a
        JOIN
    titles b ON a.emp_no = b.emp_no
WHERE
    b.to_date = '9999-01-01';
    
-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
SELECT 
    a.emp_no,
    CONCAT(a.first_name, ' ', a.last_name),
    c.dept_name
FROM
    employees a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
WHERE
    b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name);

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
SELECT 
    a.emp_no,
    CONCAT(a.first_name, ' ', a.last_name),
    c.dept_name
FROM
    employees a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
WHERE
    b.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name);

SELECT 
    a.emp_no,
    CONCAT(a.first_name, ' ', a.last_name),
    d.salary,
    f.title,
    c.dept_name
FROM
    employees a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
        JOIN
    salaries d ON a.emp_no = d.emp_no
        JOIN
    titles f ON a.emp_no = f.emp_no
WHERE
    b.to_date = '9999-01-01'
        AND f.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
ORDER BY CONCAT(a.first_name, ' ', a.last_name);

    
-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력 합니다.
SELECT 
    a.emp_no,  CONCAT(a.first_name, ' ', a.last_name)
FROM
    employees a,
    titles b
WHERE
    a.emp_no = b.emp_no
        AND b.title = 'Technique Leader'
        AND b.to_date != '9999-01-01';
        
-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT 
    CONCAT(a.first_name, ' ', a.last_name),
    c.dept_name,
    d.title
FROM
    employees a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
        JOIN
    titles d ON a.emp_no = d.emp_no
WHERE
    BINARY a.last_name LIKE 'S%';
    
-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
SELECT 
    *
FROM
    employees a
        JOIN
    titles b ON a.emp_no = b.emp_no
        JOIN
    salaries c ON a.emp_no = c.emp_no
WHERE
    b.title = 'Engineer'
        AND b.to_date = '9999-01-01'
        AND c.salary >= 40000
        AND c.to_date = '9999-01-01'
ORDER BY c.salary DESC;

-- 문제8.
-- 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
SELECT 
    b.salary, c.title
FROM
    employees a,
    salaries b,
    titles c
WHERE
    a.emp_no = b.emp_no
        AND a.emp_no = c.emp_no
        AND b.to_date = '9999-01-01'
        AND b.salary >= 50000
        AND c.to_date = '9999-01-01'
ORDER BY salary DESC;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.

SELECT 
    AVG(d.salary), c.dept_name
FROM
    employees a
        JOIN
    dept_emp b ON a.emp_no = b.emp_no
        JOIN
    departments c ON b.dept_no = c.dept_no
        JOIN
    salaries d ON a.emp_no = d.emp_no
WHERE
    b.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
GROUP BY b.dept_no
ORDER BY AVG(d.salary) DESC;



-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
SELECT 
    AVG(c.salary), b.title
FROM
    employees a
        JOIN
    titles b ON a.emp_no = b.emp_no
        JOIN
    salaries c ON a.emp_no = c.emp_no
WHERE
    b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY AVG(c.salary) DESC;
