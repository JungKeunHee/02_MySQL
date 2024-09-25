-- 1. 직급이 대리이면서 아시아 지역에 근무하는 직원 조회
-- 사번, 이름, 직급명, 부서명, 근무지역명, 급여를 조회하세요
-- (조회시에는 모든 컬럼에 테이블 별칭을 사용하는 것이 좋다.)
-- (사용 테이블 : job, department, location, employee)
	select
		a.EMP_ID,
        a.EMP_NAME,
        c.JOB_NAME,
        b.DEPT_TITLE,
        d.LOCAL_NAME,
        a.SALARY
	from
		employee a
        join department b on a.DEPT_CODE = b.DEPT_ID
        join job c on a.JOB_CODE = c.JOB_CODE
        join location d on b.LOCATION_ID = d.LOCAL_CODE
	where
		c.JOB_NAME = '대리' and d.LOCAL_NAME like 'ASIA%';
		

-- 2. 주민번호가 70년대 생이면서 성별이 여자이고, 
--    성이 전씨인 직원들의 사원명, 주민번호, 부서명, 직급명을 조회하시오.
-- (사용 테이블 : employee, department, job)
select
	a.EMP_NAME,
    a.EMP_NO,
    b.DEPT_TITLE,
    c.JOB_NAME
from
	employee a
    join department b on a.DEPT_CODE = b.DEPT_ID
    join job c on a.JOB_CODE = c.JOB_CODE
where
	a.EMP_NAME like '전%' and a.EMP_NO like '7______2%';

-- 3. 이름에 '형'자가 들어가는 직원들의
-- 사번, 사원명, 직급명을 조회하시오.
-- (사용 테이블 : employee, job)
select
	a.EMP_ID,
    a.EMP_NAME,
    b.JOB_NAME
from
	employee a
    join job b on a.JOB_CODE = b.JOB_CODE
where
	a.EMP_NAME like '%형%';

-- 4. 해외영업팀에 근무하는 사원명, 
--    직급명, 부서코드, 부서명을 조회하시오.
-- (사용 테이블 : employee, department, job)
select
	b.EMP_NAME,
	a.JOB_NAME,
    b.JOB_CODE,
	c.DEPT_TITLE
from
	job a
    join employee b on a.JOB_CODE = b.JOB_CODE
    join department c on b.DEPT_CODE = c.DEPT_ID
where
	c.DEPT_TITLE like '해외영업%';
    
    
-- 5. 보너스포인트를 받는 직원들의 사원명, 
--    보너스포인트, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, department, location)
select
	EMP_NAME,
	BONUS,
    DEPT_TITLE,
    LOCAL_NAME
from
	employee a
	join department b on a.DEPT_CODE = b.DEPT_ID
    join location c on b.LOCATION_ID = c.LOCAL_CODE
where
	a.BONUS is not null;


-- 6. 부서코드가 D2인 직원들의 사원명, 
--    직급명, 부서명, 근무지역명을 조회하시오.
-- (사용 테이블 : employee, job, department, location)
select
	a.EMP_NAME,
    b.JOB_NAME,
    DEPT_TITLE,
    LOCAL_NAME
from
	employee a
    join job b on a.JOB_CODE = b.JOB_CODE
    join department c on a.DEPT_CODE = c.DEPT_ID
    join location d on c.LOCATION_ID = d.LOCAL_CODE
where
	a.DEPT_CODE = 'D2';

-- 7. 본인 급여 등급의 최소급여(MIN_SAL)를 초과하여 급여를 받는 직원들의
--    사원명, 직급명, 급여, 보너스포함 연봉을 조회하시오.
--    연봉에 보너스포인트를 적용하시오.
-- (사용 테이블 : employee, job, sal_grade)
select
	a.EMP_NAME,
    JOB_NAME,
    SALARY,
    ifnull((SALARY * 12) + (SALARY * BONUS), SALARY * 12) as '보너스 포함 연봉'
from
	employee a
    join job b on a.JOB_CODE = b.JOB_CODE
    join sal_grade c on a.SAL_LEVEL = c.SAL_LEVEL
where
	a.SALARY > c.MIN_SAL;


-- 8. 한국(KO)과 일본(JP)에 근무하는 직원들의 
--    사원명, 부서명, 지역명, 국가명을 조회하시오.
select
	a.EMP_NAME,
    b.DEPT_TITLE,
    c.LOCAL_NAME,
    if((c.NATIONAL_CODE = 'KO'), '한국', '일본') as NATIONAL_NAME
from
	employee as a
    join department as b on a.DEPT_CODE = b.DEPT_ID
    join location as c on b.LOCATION_ID = c.LOCAL_CODE
where
	c.LOCAL_NAME between 'ASIA1' and 'ASIA2';