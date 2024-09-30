use chundb;
-- 1. 학생이름과 주소지를 표시하시오. 단, 출력 헤더는 "학생 이름", "주소지"로 하고, 정렬은 이름으로 오름차순 표시하도록 한다.
-- 학생 이름 주소지
-- -------------------- ----------------------------------------------------------
-- 감현제 서울강서등촌동691-3부영@102-505
-- 강동연 경기도 의정부시 민락동 694 산들마을 대림아파트 404-1404
-- ...
-- 황형철 전남 숚천시 생목동 현대a 106/407 T.061-772-2101
-- 황효종 인천시서구 석남동 564-4번지
-- 588 rows selected

select
	STUDENT_NAME as '학생 이름',
    STUDENT_ADDRESS as '주소지'
from
	tb_student
order by
	STUDENT_NAME;
    
-- 2. 휴학중인 학생들의 이름과 주민번호를 나이가 적은 순서로 화면에 출력하시오.
-- STUDENT_NAME STUDENT_SSN
-- -------------------- --------------
-- 릴희권	041222-3124648
-- 황효종	041125-3129980
-- 전효선	041030-4176192
-- 김진호	041013-3140536
-- ...
-- ...
-- 91 rows selected

select
	STUDENT_NAME,
    STUDENT_SSN
from
	tb_student
where
	ABSENCE_YN = 'Y'
order by
	year(now()) - (if(substring(STUDENT_SSN, 1, 2) between 50 and 99,
    1900 + substring(STUDENT_SSN, 1, 2), 2000 + substring(STUDENT_SSN, 1, 2)));
    
-- 3. 주소지가 강원도나 경기도인 학생들 중 2020년대 학번을 가진 학생들의 이름과 학번, 주소를 이름의 오름차순으로 화면에 출력하시오.
-- 단, 출력헤더에는 "학생이름","학번", "거주지 주소" 가 출력되도록 한다.
-- 학생이름 학번 거주지 주소
-- -------------------- ---------- -------------------------------------------------------------
-- 고리나  A331017  경기도 안산시 상록구 사동 푸르지오6차 610-104
-- 공현준  A411012  경기남양주와부읍도곡리1012한강우성@105-601
-- ...

-- 88 rows selected
select
	STUDENT_NAME as '학생이름',
    STUDENT_NO as '학번',
    STUDENT_ADDRESS as '거주지 주소'
from
	tb_student
where
	year(ENTRANCE_DATE) >= 2020 and
    STUDENT_ADDRESS like '경기%' or STUDENT_ADDRESS like '강원%'
order by
	학생이름;

-- 4. 현재 법학과 교수 중 가장 나이가 많은 사람부터 이름을 확인할 수 있는 SQL 문장을 작성하시오.
-- (법학과의 '학과코드'는 학과 테이블(TB_DEPARTMENT)을 조회해서 찾아 내도록 하자)
-- PROFESSOR_NAME PROFESSOR_SSN
-- -------------------- --------------
-- 홍남수 540304-1112251
-- 김선희 551030-2159000
-- 임진숙 640125-1143548
-- 이미경 741016-2103506
select
	PROFESSOR_NAME,
    PROFESSOR_SSN
from
	tb_professor
where
	DEPARTMENT_NO = (
					select
						DEPARTMENT_NO
					from
						tb_department
					where
						DEPARTMENT_NAME = '법학과'
					)
order by
	PROFESSOR_SSN;
    
-- 5. 2022 년 2학기에 C3118100 과목을 수강한 학생들의 학점을 조회하려고 한다.
-- 학점이 높은 학생부터 표시하고, 학점이 같으면 학번이 낮은 학생부터 표시하는 구문을 작성해보시오.
-- STUDENT_NO POINT
-- ---------- -----
-- A331076	4.50
-- A213128	4.00
-- A219089	1.50
-- -----------------
-- 3 rows selected
select
	STUDENT_NO,
	POINT
from
	tb_grade
where
	substring(TERM_NO, 1, 6) = '202202' and
    CLASS_NO = 'C3118100'
order by
	POINT desc;
    
-- 6. 학생 번호, 학생 이름, 학과 이름을 학생 이름으로 오름차순 정렬하여 출력하는 SQL 문을 작성하시오.
-- STUDENT_NO STUDENT_NAME         DEPARTMENT_NAME
-- ---------- -------------------- --------------------
-- A411001 감현제 치의학과
-- A131004 강동연 디자인학과
-- ...
-- ...
-- A411335 황형철 사회학과
-- A511332 황효종 컴퓨터공학과
-- ----------------------------------------------------
-- 588 rows selected

select
	a.STUDENT_NO as '학생 번호',
    a.STUDENT_NAME as '학생 이름',
    b.DEPARTMENT_NAME as '학과 이름'
from
	tb_student a
    join tb_department b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
order by
	a.STUDENT_NAME;
    
-- 7. 춘 기술대학교의 과목 이름과 과목의 학과 이름을 출력하는 SQL 문장을 작성하시오.
-- CLASS_NAME                     DEPARTMENT_NAME
-- ------------------------------ --------------------
-- 가족상담과 정신간호             간호학과
-- 가족상담실습                    간호학과
-- ...
-- ...
-- 자본시장회계연구                회계학과
-- 회계학연구방법론1               회계학과
-- ---------------------------------------------------
--  882 rows selected
select
	a.CLASS_NAME as '과목 이름',
    b.DEPARTMENT_NAME as '학과'
from
    tb_class a
    join tb_department b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
where
	a.DEPARTMENT_NO = b.DEPARTMENT_NO
order by
	b.DEPARTMENT_NAME;
    
-- 8. 과목별 교수 이름을 찾으려고 한다. 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
-- CLASS_NAME PROFESSOR_NAME
-- ------------------------------ --------------------
-- 19C미국소설 제상철
-- 19C미국소설 이지현
-- ...
-- ...
-- 환경생리학연구 유용석
-- 회계학연구방법론1 김봉건
-- --------------------------------------------------
-- 776 rows selected

select
	a.CLASS_NAME,
    b.PROFESSOR_NAME
from
	tb_class a
    join tb_professor b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
where
	a.DEPARTMENT_NO = b.DEPARTMENT_NO
order by
	a.CLASS_NAME;
    
-- 9. 8 번의 결과 중 ‘인문사회’ 계열에 속한 과목의 교수 이름을 찾으려고 한다. 이에 해당하는 과목 이름과 교수 이름을 출력하는 SQL 문을 작성하시오.
-- CLASS_NAME PROFESSOR_NAME
-- ------------------------------ --------------------
-- 고전시가론특강 김선정
-- 국어어휘론특강 김선정
-- ...
-- ...
-- --------------------------------------------------
-- 197 rows selected

select
	a.CLASS_NAME,
    b.PROFESSOR_NAME
    
from
	tb_class a
    join tb_professor b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
    join tb_department c on a.DEPARTMENT_NO = c.DEPARTMENT_NO
where
	c.CATEGORY  = '인문사회';
    
-- 10. ‘음악학과’ 학생들의 평점을 구하려고 한다. 음악학과 학생들의 "학번", "학생 이름", "전체 평점"을 출력하는 SQL 문장을 작성하시오.
-- (단, 평점은 소수점 1 자리까지만 반올림하여 표시한다.)

-- 학번 학생 이름 전체 평점
-- ---------- -------------------- ----------
-- A612052 신광현 4.1
-- A9931310 조기현 4.1
-- A431021 구병훈 3.9
-- A431358 조상진 3.7
-- A411116 박현화 3.6
-- A354020 양재영 3.5
-- A557031 이정범 3.3
-- A415245 조지선 3.2
-- --------------------------------------------
-- 8 rows selected
SELECT
    a.STUDENT_NO AS '학번',
    a.STUDENT_NAME AS '학생 이름',
    round(AVG(b.POINT),1) AS '전체 평점'
FROM
    tb_student a
JOIN
    tb_grade b ON a.STUDENT_NO = b.STUDENT_NO
JOIN
    tb_department c ON a.DEPARTMENT_NO = c.DEPARTMENT_NO
WHERE
    a.DEPARTMENT_NO = (
        SELECT
            DEPARTMENT_NO
        FROM
            tb_department
        WHERE
            DEPARTMENT_NAME = '음악학과'
    )
GROUP BY
    c.DEPARTMENT_NO, a.STUDENT_NO, a.STUDENT_NAME;
    
-- 11. 학번이 `A313047` 인 학생이 학교에 나오고 있지 않다. 지도 교수에게 내용을 전달하기 위한 학과 이름, 학생 이름과 지도 교수 이름이 필요하다. 이때 사용할 SQL 문을 작성하시오. 
--     
-- 단, 출력헤더는 ‚’학과이름‛, ‚학생이름‛, ‚지도교수이름‛으로 출력되도록 한다.
-- 학과이름 학생이름 지도교수이름
-- -------------------- -------------------- --------------------
-- 경제학과 손건영 박태환

select
	DEPARTMENT_NAME as '학과이름',
    STUDENT_NAME as '학생이름',
    PROFESSOR_NAME as '지도교수이름'
from
	tb_department a
    join tb_student b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
    join tb_professor c on b.COACH_PROFESSOR_NO = c.PROFESSOR_NO
where
	b.STUDENT_NO = 'A313047';
    
--   12.  2022년도에 인간관계론 과목을 수강한 학생을 찾아 학생이름과 수강학기를 표시하는 SQL 문장을 작성하시오.
--   STUDENT_NAME TERM_NAME
-- -------------------- --------------------
-- 최지현	202201
select
	a.STUDENT_NAME,
    b.TERM_NO,
    c.CLASS_NAME as '과목이름'
from
	tb_student a
    join tb_grade b on a.STUDENT_NO = b.STUDENT_NO
    join tb_class c on c.DEPARTMENT_NO = a.DEPARTMENT_NO
where
	substring(TERM_NO, 1, 4) = 2022 and
    c.CLASS_NO = (
					select
						CLASS_NO
					from
						tb_class
					where
						CLASS_NAME = '인간관계론'
				)
group by
	a.STUDENT_NAME;
    
-- 13. 예체능 계열 과목 중 과목 담당교수를 한명도 배정받지 못한 과목을 찾아 그 과목 이름과 학과 이름을 출력하는 SQL 문장을 작성하시오.
-- CLASS_NAME DEPARTMENT_NAME
-- ------------------------------ --------------------
-- CELLO실기2 음악학과
-- FLUTE실기2 음악학과
-- ...
-- ...
-- 환경디자인특론 디자인학과
-- 회화재료연습 미술학과
-- --------------------------------------------------
-- 44 rows selected

SELECT
    a.CLASS_NAME,
    b.DEPARTMENT_NAME
FROM
    tb_class a
JOIN
    tb_department b ON a.DEPARTMENT_NO = b.DEPARTMENT_NO
LEFT JOIN
    tb_class_professor c ON a.CLASS_NO = c.CLASS_NO
WHERE
    b.CATEGORY = '예체능' AND
    c.PROFESSOR_NO IS NULL
ORDER BY
    a.CLASS_NAME;


-- 14. 춘 기술대학교 서반아어학과 학생들의 지도교수를 게시하고자 한다. 학생이름과 지도교수 이름을 찾고 맡길 지도 교수가 없는 학생일 경우 "지도교수 미지정”으로 표시하도록 하는 SQL 문을 작성하시오. 
--     
--     단, 출력헤더는 “학생이름”, “지도교수”로 표시하며 고학번 학생이 먼저 표시되도록 한다.
--     학생이름 지도교수
-- -------------------- --------------------
-- 주하나 허문표
-- 이희진 남명길
-- ...
-- ...
-- 최철현 백양임
-- -----------------------------------------
-- 14 rows selected
SELECT
    a.STUDENT_NAME AS 학생이름,
    ifnull(b.PROFESSOR_NAME, '지도교수 미지정') as 지도교수
FROM
    tb_student a
LEFT JOIN
    tb_professor b ON a.COACH_PROFESSOR_NO = b.PROFESSOR_NO
JOIN
    tb_department c ON a.DEPARTMENT_NO = c.DEPARTMENT_NO
WHERE
    a.DEPARTMENT_NO = (
						select
							DEPARTMENT_NO
						from
							tb_department
						where
							DEPARTMENT_NAME = '서반아어학과'
						)
ORDER BY
    a.STUDENT_NO;
    
-- 15. 휴학생이 아닌 학생 중 평점이 4.0 이상인 학생을 찾아 그 학생의 학번, 이름, 학과 이름, 평점을 출력하는 SQL 문을 작성하시오.
-- 학번 이름 학과이름 평점
-- ---------- -------------------- -------------------- ----------
-- A071041 인정성 지리학과 4.1
-- A098008 김동민 의학과 4.0
-- A131231 이동인 생물학과4.0
-- ...
-- ...
-- 19 rows selected
SELECT
    a.STUDENT_NO,
    a.STUDENT_NAME,
    b.DEPARTMENT_NAME,
    ROUND(AVG(c.POINT), 1) AS 평점
FROM
    tb_student a
JOIN
    tb_department b ON a.DEPARTMENT_NO = b.DEPARTMENT_NO
JOIN
    tb_grade c ON a.STUDENT_NO = c.STUDENT_NO
WHERE
    a.ABSENCE_YN = 'N'
GROUP BY
    a.STUDENT_NO, a.STUDENT_NAME, b.DEPARTMENT_NAME
HAVING
    ROUND(AVG(c.POINT), 1) >= 4.0;
    
-- 16. 환경조경학과 전공과목들의 과목 별 평점을 파악할 수 있는 SQL 문을 작성하시오.
-- CLASS_NO   CLASS_NAME                     AVG(POINT)
-- ---------- ------------------------------ ----------
-- C3016200 전통계승방법론 3.678571
-- C3081300 조경계획방법론 3.692307
-- C3087400 조경세미나 3.909090
-- C4139300 환경보전및관리특론 3.027777
-- C4477600 조경시학 3.176470
-- C5009300 단지계획및설계스튜디오 3.375000
-- 6 rows selected

SELECT
    a.CLASS_NO,
    a.CLASS_NAME,
    avg((b.POINT)) AS 평점
FROM
    tb_class a
JOIN
    tb_grade b ON a.CLASS_NO = b.CLASS_NO
JOIN
    tb_department c ON a.DEPARTMENT_NO = c.DEPARTMENT_NO
WHERE
	a.CLASS_TYPE like '전공%' and
    a.DEPARTMENT_NO = (
        SELECT
            DEPARTMENT_NO
        FROM
            tb_department
        WHERE
            DEPARTMENT_NAME = '환경조경학과'
    )
GROUP BY
    a.CLASS_NO, a.CLASS_NAME
ORDER BY
    a.CLASS_NO;
    
-- 17. 춘 기술대학교에 다니고 있는 최경희 학생과 같은 과 학생들의 이름과 주소를 출력하는 SQL 문을 작성하시오.
-- STUDENT_NAME STUDENT_ADDRESS
-- -------------------- ----------------------------------------------------------
-- 기혜미 대전시 유성구 덕진동 한국원자력안전기술원 행정부장 
-- 김석민 경기도안산시상록구2동664번지투루지오2차@205/601
-- ...
-- ...
-- 17 rows selected
SELECT A.STUDENT_NAME, A.STUDENT_ADDRESS
FROM tb_student A
	JOIN tb_department B ON A.DEPARTMENT_NO = B.DEPARTMENT_NO
WHERE B.DEPARTMENT_NO = (
						SELECT DEPARTMENT_NO
                        FROM tb_student
                        WHERE STUDENT_NAME = '최경희'
						)
ORDER BY A.STUDENT_NAME;

-- 18. 국어국문학과에서 총 평점이 가장 높은 학생의 이름과 학번을 표시하는 SQL 문을 작성하시오.
-- STUDENT_NO STUDENT_NAME
-- ---------- --------------------
-- 9931165 송근우
WITH AvgPoints AS (
    SELECT
        A.STUDENT_NO,
        A.STUDENT_NAME,
        AVG(C.POINT) AS 평점
    FROM
        tb_student A
    JOIN
        tb_grade C ON A.STUDENT_NO = C.STUDENT_NO
    WHERE
        A.DEPARTMENT_NO = (
            SELECT DEPARTMENT_NO
            FROM tb_department
            WHERE DEPARTMENT_NAME = '국어국문학과'
        )
    GROUP BY
        A.STUDENT_NO, A.STUDENT_NAME
)
SELECT
    SUBSTRING(STUDENT_NO, 2, 7) AS 학번,
    STUDENT_NAME AS 학생이름
FROM
    AvgPoints
WHERE
    평점 = (SELECT MAX(평점) FROM AvgPoints);
            
-- 19. 춘 기술대학교의 "환경조경학과"가 속한 같은 계열 학과들의 학과 별 전공과목 평점을 파악하기 위한 적절한 SQL 문을 찾아내시오.
-- 단, 출력헤더는 "계열 학과명", "전공평점"으로 표시되도록 하고, 평점은 소수점 한 자리까지만 반올림하여 표시되도록 한다.
-- 계열 학과명 전공평점
-- -------------------- --------
-- 간호학과 3.2
-- 물리학과 3.3
-- ...
-- ...
-- 환경조경학과 3.3
-- 20 rows selected
select
	a.DEPARTMENT_NAME,
    round(avg(c.POINT),1)
from
	tb_department a
    join tb_student b on a.DEPARTMENT_NO = b.DEPARTMENT_NO
    join tb_grade c on b.STUDENT_NO = c.STUDENT_NO
where
	a.CATEGORY = (
				select
					CATEGORY
				from
					tb_department
				where
					DEPARTMENT_NAME = '환경조경학과'
				 )
group by
	a.DEPARTMENT_NAME
order by
	a.DEPARTMENT_NAME;