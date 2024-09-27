-- 1. 춘 기술대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과 명", "계열"으로 표시하도록 한다
-- 학과명 계열
-- --------- --------------------
-- 국어국문학과 인문사회
-- 영어영문학과 인문사회
-- 사학과 인문사회
-- 철학과 인문사회
-- 법학과 인문사회
-- 행정학과 인문사회
-- ...
-- ...
-- 체육학과 예체능
-- -------------------------------
-- 63 rows selected

select
	DEPARTMENT_NAME,
    CATEGORY
from
	tb_department;
    
-- 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
-- 학과별 정원
-- ------------------------------------------------
-- 국어국문학과의 정원은 20 명 입니다.
-- 영어영문학과의 정원은 36 명 입니다.
-- 사학과의 정원은 28 명 입니다.
-- 철학과의 정원은 28 명 입니다.
-- ...
-- ...
-- ------------------------------------------------
select
	concat(DEPARTMENT_NAME, '의') as 학과,
    concat(CAPACITY, ' 명 입니다.') as 정원
from
	tb_department;

-- 3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달라는 요청이
-- 들어왔다. 누구인가? (국문학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서
-- 찾아 내도록 하자)
-- STUDENT_NAME
-- --------------------
-- 한수현

select
	STUDENT_NAME
from
	tb_student
where
	STUDENT_SSN like '______-2%' and
    ABSENCE_YN = 'Y' and DEPARTMENT_NO = (
					select
						DEPARTMENT_NO
					from
						tb_department
					where
						DEPARTMENT_NAME = '국어국문학과'
					);

-- 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 그 대상자들의
-- 학번이 다음과 같을 때 대상자들을 찾는 적 SQL 구문을 작성하시오.
-- A513079, A513090, A513091, A513110, A513119
-- STUDENT_NAME
-- --------------------
-- 홍경희
-- 최경희
-- 정경훈
-- 정경환
-- 이경환
-- --------------------
-- 5 rows selected

select
	STUDENT_NAME
from
	tb_student
where
	STUDENT_NO in ('A513079', 'A513090', 'A513091', 'A513110', 'A513119')
order by
	STUDENT_NO desc;
    
-- 5. 입학정원이 20 명 이상 30 명 이하인 학과들의 학과 이름과 계열을 출력하시오.
-- DEPARTMENT_NAME CATEGORY
-- -------------------- --------------------
-- 국어국문학과 인문사회
-- 사학과 인문사회
-- 철학과 인문사회
-- ...
-- ...
-- 미술학과 예체능
-- 산업디자인학과 예체능
-- 체육학과 예체능
-- -----------------------------------------
-- 24 rows selected
select
	DEPARTMENT_NAME,
    CATEGORY
from
	tb_department
where
	CAPACITY >= 20 && CAPACITY <= 30;
    
-- 6. 춘기술대학교는총장을제외하고모든교수들이소속학과를가지고있다. 그럼 춘기술대학교 총장의 이름을 알아낼 수 있는 SQL 문장을 작성하시오.
-- PROFESSOR_NAME
-- --------------------
-- 임해정
-- --------------------
-- 1 rows selected

select
	PROFESSOR_NAME
from
	tb_professor 
where
	DEPARTMENT_NO is null;
    
-- 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
-- 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.

select
	STUDENT_NAME
from
	tb_student a
    join tb_department b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
where
	b.DEPARTMENT_NAME is null;
    
-- 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
-- 과목들은 어떤 과목인지 과목번호를 조회해보시오.
-- CLASS_NO
-- ----------
-- C0405500
-- C0409000
-- C3745400
-- C0432500
-- C3051900
-- C3221500
-- ----------
-- 6 rows selected

select
	CLASS_NO
from
	tb_class
where
	PREATTENDING_CLASS_NO is not null;
    
-- 9. 춘 대학에는 어떤 계열(CATEGORY)들이 있는지 조회해보시오
-- CATEGORY
-- --------------------
-- 공학
-- 예체능
-- 의학
-- 인문사회
-- 자연과학
-- --------------------
-- 5 rows selected

select
	distinct(CATEGORY)
from
	tb_department
order by
	CATEGORY;
    
-- 10. 19 학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은 제외하고, 재학중인
-- 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오.

-- STUDENT_NO STUDENT_NAME STUDENT_SSN
-- ---------- -------------------- --------------
-- A217005 고수현 991119-2122202
-- ...
-- ...
-- A217201 황숭인 000603-3110188
-- -----------------------------------------------
-- 11 rows selected

select
	STUDENT_NO,
    STUDENT_NAME,
    STUDENT_SSN
from
	tb_student
where
year(ENTRANCE_DATE) = 2019 and STUDENT_ADDRESS like '전주%' and ABSENCE_YN = 'N';