/*
    update와 delete > 심사숙고
    
    ex16_update.sql
    
    update
    - DML
    - 데이터 수정하는 명령어
    - 원하는 행의 원하는 컬럼값을 수정하는 명령어
    
    구문
    - update 테이블 set 컬럼명=값
    - update 테이블명 set 컬럼명=값, 컬럼명=값, 컬럼명=값;
    - update 테이블명 set 컬럼명=값 where 절;
    - update 테이블 set 컬럼명=값 [ , 컬럼명=값] x N [where절];

*/

commit;
rollback;

select * from tblCountry;

-- 대한민국 수도 : 서울 > 세종
update tblCountry set Capital = '세종';  --모든 레코드 대상

update tblCountry set Capital = '세종' where name ='대한민국'; -- 원하는 대상 1개 

-- 대한민국 이름 > 한국, 수도 > 제주, 대륙 > EU 
update tblCountry set 
            name = '한국', capital = '제주', continent = 'EU'
                where name ='대한민국';

-- 모든 나라의 인구 증가!! > 일괄적으로 증가 > 10% 증가 > 4405 > 4845.5
update tblCountry set
            population = population * 1.1;

----------------------------------------------------------------------------------------------

/*

    delete
    - DML
    - 데이터 삭제하는 명령어
    - 행을 삭제하는 명령어
    
    구문
    - delete [from] 테이블명 [where절]
    


*/

commit;
rollback;

select * from tblCountry;

delete from tblCountry where name = '일본';

delete from tblCountry where continent = 'EU';

delete from tblCountry;

-- update, delete > 실수
-- 1. 백업
-- 2. commit/rollback > 트랜잭션 > 현재 세션에 한해서..
-- 3. 스크립트

/*
    



*/











