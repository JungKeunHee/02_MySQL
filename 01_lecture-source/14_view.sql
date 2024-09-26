-- view
-- select 쿼리문을 저장한 객체로 가상 테이블 이라고 불리운다.
-- 실질적인 데이터를 물리적으로 저장하고 있지 않고, 쿼리만 저장을 했지만
-- 테이블을 쓰는 것과 동일하게 사용을 할 수 있다.

select * from tbl_menu;

-- view 생성 표현식
-- create view 사용할이름 as 쿼리문;
create view hansik as
select
	*
from
	tbl_menu
where
	category_code = 4;
    
-- 만들어진 view 조회
select * from hansik;
   
-- 한식이라고 하는 view 는 원본인 tbl_menu 에서 만든 가상의 테이블
insert into tbl_menu
values(null, '해장국', 5500, 4, 'Y');

-- 베이스 테이블의 정보가 변경이 되면, view 도 같이 반영이 된다.
select * from hansik;

-- view 에서의 dml 수행
-- 주의점 !! 베이스 테이블에서는 auto increment 가 설정이 되어 있으나
-- view 에서는 설정하지 않았기 때문에 제약조건 위반여부 고려
insert into hansik
values(99, '뼈다구해장국', 8000, 4, 'Y');

-- view 실행여부 확인
select * from hansik;
-- view 에서 실행항 dml 구문이 원본에도 영향을 미쳤는지 확인
select * from tbl_menu;

update hansik
set 
	menu_name = '우거지해장국',
    menu_price = 9000
where
	menu_code = 99;

select * from tbl_menu;

-- view 사용 시 dml 주의점
-- 1. 뷰 정의할 때 포함되지 않는 컬럼을 사용하려는 경우
-- 2. 뷰에 포함되지 않은 컬럼 중 베이스가 되는 테이블 컬럼이 not null 제약조건 지정된 경우
-- 3. 산술 표현식이 정의 된 경우
-- 4. join 을 이용해 여러 테이블을 연결 한 경우
-- 5. 그룹함수나 group by 절을 포함한 경우
-- 6. distinct 를 포함 한 경우

-- 생성한 view 삭제
drop view hansik;

-- or replace 옵션
-- 테이블을 drop 하지 않고 기존의 view 를 새로운 view 로 대체
create or replace view hansik as
select
	a.menu_name as 메뉴명,
    b.category_name as 카테고리명
from
	tbl_menu a
    join tbl_category b on a.category_code = b.category_code
where
	b.category_name = '한식';
    
select * from hansik;