-- ex03_select.sql

/*

    SQL, Query(질의) > SELECT
    
    SELECT 문
    - DML, DQL
    - 관계대수 연산 중 셀렉션 작업을 구현한 명령어
    - 대상 테이블로부터 원하는 행을 추출하는 작업 > 오라클 서버한테 데이터 좀 주세요~ 요청하는 명령어
    - 읽기
                                                                 - select문
    [WITH <Sub Query>]                                  - WITH 절
    SELECT column_list                                     - SELECT 절 
    FROM table_name                                     - FROM 절
    [WHERE search_condition]                            - WHERE 절
    [GROUP BY group_by_expression]                  - GROUP BY 절
    [HAVING search_condition]                          - HAVING 절
    [ORDER BY order_expresstion [ASC|DESC]];      - ORDER BY 절
    
    ********** 절의 실행순서가 정해져있다.
    
*/

-- 1. select 절
select 컬럼리스트          -- 2. 원하는 컬럼을 지정
from 테이블명;              -- 1. 데이터 소스를 지정(어느 테이블로부터 데이터를 가져올지)

-- 처음 보는 테이블의 구조(스키마, Scheme) 확인?
-- 1. 툴
-- 2. 명령어(SQL Developer, SQL Plus)

desc employees; --SQL(X), 특정 툴 명령어

-- 단일 컬럼
select first_name
from employees;

select email
from employees;

-- 다중 컬럼
select first_name, last_name
from employees;

select first_name, last_name, email, salary, phone_number
from employees;

select 
    first_name, last_name, email, salary, phone_number
from 
    employees;

-- 컬럼명을 모두 명 시
select first_name, last_name, email, salary, phone_number
    from employees;

-- 와일드 카드 사용
select * -- 와일드 카드(*) > 모든 컬럼
    from employees;
    
-- 컬럼 리스트의 컬럼 순서는 원본 테이블의 컬럼순서와 무관하다.
select last_name, first_name from employees;

-- 똑같은 컬럼을 가져오는 횟수는 제한이 없다. 반복으로 가져오는것 가능
select first_name, first_name from employees;

select first_name, length(first_name) from employees;

select * from zipcode;

select 절    -- 2. 컬럼 지정 
from 절;     -- 1. 테이블 지정 

select name
    from tblInsa;

select name, buseo, jikwi
    from tblInsa;

-- 항상 select 문의 결과는 테이블이다. > 메모리에 존재하는 임시 테이블 > 결과 테이블 or 결과셋(ResultSet)

select name, length(name)
    from tblInsa;
    
select *
    from tblInsa;

-------------------------------------------------------------에러 종류 ------------------------------
select *
    from tblIns; --ORA-00942: table or view does not exist 에러 : 테이블 명 오류
    
select nama
    from tblInsa; --ORA-00904: "NAMA": invalid identifier 에러 : 컬럼 이름 오류
    

    
---------------------------------------------파싱한 데이터 테이블 목록-------------------------------------------------------
select * from tblAddressBook; -- 주소록
select * from tblComedian; -- 코미디언
select * from tblCountry; -- 국가정보
select * from tblDiary; -- 다이어리
select * from tblHousekeeping; -- 가계부
select * from tblInsa; -- 직원정보
select * from tblMen; -- 남자정보
select * from tblWolmen; -- 여자정보
select * from tblTodo; -- 할일 
select * from tblzoo; -- 동물 
































