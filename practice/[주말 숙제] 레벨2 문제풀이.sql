-- 1. 영어영문학과(학과코드 `002`) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른순으로 표시하는 SQL 문장을 작성하시오.
--     
--     ( 단, 헤더는 "학번", "이름", "입학년도" 가 표시되도록 한다.)
--     학번 이름 입학년도
-- ---------- -------------------- -----------

-- A9973003 김용근  2016-03-01
-- A473015 배용원  2021-03-01
-- A517105 이신열  2022-03-01
select
	STUDENT_NO as 학번,
    STUDENT_NAME as 이름,
	ENTRANCE_DATE as 입학년도
from
	tb_student 
where
    DEPARTMENT_NO = 002
order by
	ENTRANCE_DATE;

-- 2. 춘 기술대학교의 교수 중 이름이 세 글자가 아닌 교수가 두 명 있다고 한다. 그 교수의 이름과 주민번호를 화면에 출력하는 SQL 문장을 작성해 보자. 
-- PROFESSOR_NAME PROFESSOR_SSN
-- -------------------- --------------
-- 강혁 601004-1100528
-- 박강아름 681201-2134896
select
	PROFESSOR_NAME,
    PROFESSOR_SSN
from
	tb_professor
where
	PROFESSOR_NAME not like '___';
    
-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오. 
-- (단, 교수 중 2000 년 이후 출생자는 없으며 출력 헤더는 "교수이름", "나이"로 한다. 나이는 ‘만’으로 계산한다.)
-- 교수이름 나이
-- -------------------- ----------
-- 주영상 43
-- 제상철 44
-- 김명석 45
-- 신영호 45
-- 김태봉 47
-- ...
-- --------------------------------
-- 75 rows selected

select
    PROFESSOR_NAME AS 교수이름,
    case
		when month(curdate() >= substring(PROFESSOR_SSN, 3,2))
		and day(curdate()) >= substring(PROFESSOR_SSN, 5, 2)
        then year(now()) - (1900 + substring(PROFESSOR_SSN, 1, 2))
        else year(now()) - (1900 + substring(PROFESSOR_SSN, 1, 2)) - 1
        end as 나이
	from
		tb_professor
	where
		PROFESSOR_SSN like '______-1%'
	order by
		나이 asc;

-- 4. 교수들의 이름 중 성을 제외한 이름만 출력하는 SQL 문장을 작성하시오. 출력 헤더는’이름’ 이 찍히도록 핚다. (성이 2 자인 경우는 교수는 없다고 가정하시오)
-- 이름
-- --------------------------------------
-- 진영
-- 윤필
-- ...
-- ...
-- 해원
-- 혁호
-- ---------------------------------------
-- 114 rows selected

select
	substring(PROFESSOR_NAME, 2, 3) as 이름 -- 혹시나 이름이 3자리인 사람도 있을 수 있어서 3으로 선택
from
	tb_professor;
    
-- 5. 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼 것인가? 이때, 만 19살이 되는 해에 입학하면 재수를 하지 않은 것으로 간주한다.
-- STUDENT_NO STUDENT_NAME
-- ---------- --------------------
-- A011032,김태광
-- A011113,박태규
-- ...
-- ...
-- A9931311,조기현
-- A9931312,조기환
-- --------------------------------
-- 204 rows selected
select
    STUDENT_NO,
    STUDENT_NAME
from
    tb_student
where
	year(ENTRANCE_DATE) > year(now()) - (year(now()) - if(SUBSTRING(STUDENT_SSN, 1, 2) between 50 and 99, 1900 + SUBSTRING(STUDENT_SSN, 1, 2),
    2000 + SUBSTRING(STUDENT_SSN, 1, 2)) - 19);

-- 6. 2020년 크리스마스는 무슨 요일이었는가?
select
	dayofweek('2020-12-25') as '해당일자 번호',
    case dayofweek('2020-12-25')
		when 1 then '일요일'
        when 2 then '월요일'
        when 3 then '화요일'
        when 4 then '수요일'
        when 5 then '목요일'
        when 6 then '금요일'
        when 7 then '토요일'
        end as 요일;
        
-- 7. `*STR_TO_DATE*('99/10/11', '%y/%m/%d')` `*STR_TO_DATE*('49/10/11', '%y/%m/%d')`은 각각 몇 년 몇 월 몇 일을 의미할까? 
--     
--     또 `*STR_TO_DATE*('70/10/11', '%y/%m/%d')` `*STR_TO_DATE*('69/10/11', '%y/%m/%d')` 은 각각 몇 년 몇 월 몇 일을 의미할까?
select
	str_to_date('99/10/11', '%y/%m/%d'); -- 1999-10-11 이라는 뜻
select
	STR_TO_DATE('49/10/11', '%y/%m/%d'); -- 2049-10-11 이라는 뜻
select
	STR_TO_DATE('70/10/11', '%y/%m/%d'); -- 1970-10-11 이라는 뜻
select
	STR_TO_DATE('69/10/11', '%y/%m/%d'); -- 2069-10-11 이라는 뜻

-- 8. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
-- 평점
-- ----------
-- 3.6
-- ----------
-- 1 개의 행이 선택되었습니다.
select
	rpad(avg(POINT), 3, 0) as 평점,
    STUDENT_NAME
from
	tb_grade a
    join tb_student b on a.STUDENT_NO = b.STUDENT_NO
where
	b.STUDENT_NO = 'A517178';

-- 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오.

-- 학과번호 학생수(명)
-- ---------- ----------
-- 001 14
-- 002 3
-- ...
-- ...
-- 061 7
-- 062 8
-- --------------------
-- 62 rows selected

select
	a.DEPARTMENT_NO as 학과번호,
    COUNT(*) as '학생수(명)'
FROM
	tb_department a
    join tb_student b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
group by
	a.DEPARTMENT_NO;
    
-- 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오.
-- COUNT(*)
-- ----------
--          9

select
	count(*)
from
	tb_student
where
	COACH_PROFESSOR_NO is null;
    
-- 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오.
-- 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 표시한다.
-- 년도 년도별 평점
-- -------- ------------
-- 2018	2.8
-- 2019	2.3
-- 2020	4.0
-- 2021	3.5

select
	substring(a.TERM_NO, 1, 4) as 년도,
	round(avg(a.POINT),1) as '년도별 평점'
from
	tb_grade a
    join tb_student b on a.STUDENT_NO = b.STUDENT_NO
where
	b.STUDENT_NO = 'A112113'
group by
	substring(a.TERM_NO, 1, 4);

-- 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오.
-- 학과코드명 휴학생 수
-- ------------- ------------------------------
-- 001 2
-- 002 0
-- 003 1
-- ...
-- 061 2
-- 062 2
-- -------------------------------------------
-- 62 rows selected

SELECT 
    DEPARTMENT_NO AS 학과코드명,
    sum(case
		when ABSENCE_YN = 'Y'
        then 1
        else 0 end) as '휴학생 수'
FROM 
    tb_student
GROUP BY 
    DEPARTMENT_NO
ORDER BY 
    DEPARTMENT_NO ASC;

-- 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능하겠는가?
-- 동일이름 동명인 수
-- -------------------- ----------
-- 김경민 2
-- 김명철 2
-- ...
-- 조기현 2
-- 최효정 2
-- -------------------------------------------
-- 20 rows selected

select
	STUDENT_NAME as 동일이름,
	count(*) as '동명인 수'
from
	tb_student a
group by
	STUDENT_NAME
having
	count(*) > 1
order by
	STUDENT_NAME;
    
-- 학번이 A112113 인 김고운 학생의 년도, 학기 별 평점과 년도 별 누적 평점 , 총평점을 구하는 SQL 문을 작성하시오.
-- (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)
-- 년도 학기 평점
-- -------- ---- ------------
-- 2018	01	2.5
-- 2018	02	3.0
-- 2018		  2.8
-- 2019	01	2.0
-- 2019	02	2.5
-- 2019		  2.3
-- 2020	01	3.5
-- 2020	02	4.5
-- 2020	03	4.0
-- 2020		  4.0
-- 2021	01	4.0
-- 2021	02	3.0
-- 2021		  3.5
-- 					3.2
-- -------------------------------------------
-- 14 rows selected
select
	substring(a.TERM_NO, 1, 4) as 년도,
    substring(a.TERM_NO, 5, 2) as 학기,
    round(avg(a.POINT),1) as 평점
from
	tb_grade a
    join tb_student b on a.STUDENT_NO = b.STUDENT_NO
where 
    b.STUDENT_NO = 'A112113'
group by
    SUBSTRING(a.TERM_NO, 1, 4), substring(a.TERM_NO, 5, 2)

union all

select
	substring(a.TERM_NO, 1, 4) as 년도,
    null as 학기,
    round(avg(a.POINT),1) as 평점
from
	tb_grade a
    join tb_student b on a.STUDENT_NO = b.STUDENT_NO
where 
    b.STUDENT_NO = 'A112113'
group by
    SUBSTRING(a.TERM_NO, 1, 4)
order by
	년도;
	