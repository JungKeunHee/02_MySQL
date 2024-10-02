use employee;
use chundb;
-- 1.부서코드가 노옹철 사원과 같은 소속의 직원 명단 조회
select
	EMP_NAME
from
	employee
where
	DEPT_CODE = (
	select
		DEPT_CODE
	from
		employee
	where
		EMP_NAME = '노옹철'
    );
    
    
-- 2.전 직원의 평균 급여보다 많은 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
select
	EMP_ID as 사번,
    EMP_NAME as 이름,
    DEPT_CODE as 직급코드,
    SALARY as 급여
from
	employee
where
	SALARY > (
			select
				avg(SALARY)
			from
				employee
			);


-- 3.노옹철 사원의 급여보다 많이 받는 직원의
-- 사번, 이름, 부서, 직급, 급여를 조회하세요
select
	EMP_ID as 사번,
    EMP_NAME as 이름,
    DEPT_CODE as 부서,
    JOB_CODE as 직급,
    SALARY as 급여
from
	employee
where
	SALARY > (
			select
				SALARY
			from
				employee
			where
				EMP_NAME = '노옹철'
			);
    

-- 4.가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급, 부서, 급여, 입사일을 조회하세요 (MIN)

select
	EMP_ID as 사번,
    EMP_NAME as 이름,
    JOB_CODE as 직급,
    DEPT_CODE as 부서,
    SALARY as 급여,
    HIRE_DATE as 입사일
from
	employee
where
	SALARY = (
			select
				MIN(SALARY)
			from
				employee
			);
-- 서브쿼리는 SELECT, FROM, WHERE, HAVING, ORDER BY절에도 사용할 수 있다.


-- 5.부서별 최고 급여를 받는 직원의 이름, 직급, 부서, 급여 조회
-- 힌트 : where 절에 subquery
select
    EMP_NAME AS 이름,
    JOB_CODE AS 직급,
    DEPT_CODE AS 부서,
    SALARY AS 급여
from
    employee e
where
    SALARY = (
        select MAX(SALARY)
        from employee
        where DEPT_CODE = e.DEPT_CODE
    );

-- 여기서부터 난이도 극상

-- 6.관리자에 해당하는 직원에 대한 정보와 관리자가 아닌 직원의 
-- 정보를 추출하여 조회
-- 사번, 이름, 부서명, 직급, '관리자' AS 구분 / '직원' AS 구분
-- 힌트 : is not null, union(혹은 then, else), distinct
select
	EMP_ID as 사번,
    EMP_NAME as 이름,
    DEPT_TITLE as 부서명,
    JOB_NAME as 직급,
    '관리자' as 구분
from
	employee a
    join department b on a.DEPT_CODE = b.DEPT_ID
    join job c on a.JOB_CODE = c.JOB_CODE
where
	c.JOB_CODE between 'J1' and 'J3'
    
union

select
	EMP_ID as 사번,
    EMP_NAME as 이름,
    DEPT_TITLE as 부서명,
    JOB_NAME as 직급,
    '직원' as 구분
from
	employee a
    join department b on a.DEPT_CODE = b.DEPT_ID
    join job c on a.JOB_CODE = c.JOB_CODE
where
	c.JOB_CODE between 'J4' and 'J7';
    

-- 7.자기 직급의 평균 급여를 받고 있는 직원의
-- 사번, 이름, 직급코드, 급여를 조회하세요
-- 단, 급여와 급여 평균은 만원단위로 계산하세요
-- 힌트 : round(컬럼명, -5)
with 평균급여 as (
	select
		JOB_CODE,
		round(avg(SALARY), -5) as 직급별평균급여
	from
		employee
	group by
		JOB_CODE
)
select
	a.EMP_ID,
    a.EMP_NAME,
    a.JOB_CODE,
    a.SALARY
from
	employee a
    join 평균급여 b on a.JOB_CODE = b.JOB_CODE
where
	a.SALARY >= b.직급별평균급여;

-- 8.퇴사한 여직원과 같은 부서, 같은 직급에 해당하는
-- 사원의 이름, 직급, 부서, 입사일을 조회
select
	EMP_NAME,
    JOB_CODE,
    DEPT_CODE,
    HIRE_DATE
from
	employee
where
	EMP_NO like '______-2%' and
    DEPT_CODE = (
				select
					DEPT_CODE
				from
					(
                    select
						JOB_CODE
					from
						employee
					where
						ENT_YN = 'Y'
                    ) as ENT_DATE
				where
					ENT_YN = 'Y'
				);

-- 9.급여 평균 3위 안에 드는 부서의 
-- 부서 코드와 부서명, 평균급여를 조회하세요
-- limit 사용
select
	DEPT_CODE,
    DEPT_TITLE,
    avg(SALARY)
from
	employee a
    join department b on a.DEPT_CODE = b.DEPT_ID
group by
	DEPT_CODE
order by
	avg(SALARY) desc
limit 3;

-- 10.직원 정보에서 급여를 가장 많이 받는 순으로 이름, 급여, 순위 조회
-- 힌트 : DENSE_RANK() OVER or RANK() OVER
select
	EMP_NAME,
    SALARY,
	dense_rank() over (order by SALARY desc) as 순위
from
	employee;


-- 11.부서별 급여 합계가 전체 급여의 총 합의 20%보다 많은
-- 부서의 부서명과, 부서별 급여 합계 조회
-- 힌트 : SUM(E2.SALARY) * 0.2
with 전체급여 as (
	select
		sum(SALARY) as 부서전체합계급여
	from
		employee a
        join department b on a.DEPT_CODE = b.DEPT_ID
)


select
	a.DEPT_TITLE,
    sum(b.SALARY) as 부서별급여합계
from
	department a
    join employee b on a.DEPT_ID = b.DEPT_CODE

group by
	a.DEPT_TITLE
having
 sum(b.SALARY) > (
				 select
					부서전체합계급여
				 from
					전체급여
				 ) * 0.2;
	