-- SELECT 절은 MySQL 의 가장 기본적인 명령어로 특정 테이블에서 원하는 데이터를
-- 조회할 수 있는 명령어이다.

select -- 조회해줘
	menu_name -- 무엇을?
from	-- 어디서?
	tbl_menu; -- tbl_menu 테이블에서

-- tbl_menu 테이블에서 메뉴 코드와 카테고리 코드, 메뉴 가격을 조회해줘
select
	menu_code,
    category_code,
    menu_price
from
	tbl_menu;
    
-- tbl_menu 테이블에서 모든 컬럼을 조회해줘
select
	menu_code,
    menu_name,
    menu_price,
    category_code,
    orderable_status
from
    tbl_menu;
    
-- 모든 컬럼을 조회해야 할 상황일 때 * 문자를 사용하면 쉽게 가능하다.
-- * -> all(모두) 
select
	*
from
    tbl_menu;
    
-- mysql 도 내장된 함수가 존재한다.

-- 현재 시간 조회
select now();

-- concat() : 합치기
select concat('정', '문자열', '근희');

-- 컬럼에 별칭을 지정할 수 있다.
select concat('정', '문자열', '근희') as 내이름;
-- 별칭을 띄어쓰기가 포함 된 문자열을 적용할 때는 '' 을 사용해야 한다.
select concat('정', '문자열', '근희') as '내 이름';
