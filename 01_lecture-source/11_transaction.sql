-- transaction
-- 데이터베이스에서 한 번에 수행되는 작업의 단위이다.
-- 시작, 진행, 종료 단계를 거치게 되면서 만약 중간에 예기치 못한 값 or 에러
-- 발생할 시 rollback (시작하기 이전 단계로 돌아감) 을 진행한다.
-- MySQL 은 default 설정이 auto-commit(자동 저장) 이기 때문에
-- 우리가 수행한 쿼리문을 돌릴 수 없다.
-- 따라서 transaction 기능을 사용하기 위해서는 auto-commit 설정을
-- 해제 해주어야 한다.

-- java 복습 boolean 기본값은 false, false 가 정수로는 0
-- 1 -> true

-- autocommit 활성화
set autocommit = 1;

-- 비활성화
set autocommit = 0;
set autocommit = OFF;

-- start transaction 구문을 작성을 하면
-- 이제 하나의 과정으로 인식을 하고 commit, roollback 과정을 수행할 수 있다.

start transaction;

select * from tbl_menu;

-- dml 수정, 삭제, 삽입
insert into tbl_menu values(null, '해장국', 9000, 2, 'Y');
update tbl_menu set menu_name = '해장끝' where menu_code = 29;

-- 작성한 dml 구문이 에러나 이상한 값이 없다면 직접 commit 을 해주어야 반영이 된다.
commit;

rollback;