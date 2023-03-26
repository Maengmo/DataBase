/*

    ex21_union.sql
    
    관계 대수 연산
    1. 셀렉션 > select where
    2. 프로젝션 > select column
    3. 조인 > a join b
    4. 합집합, 차집합, 교집합 
    
    union
    - 합집합
    
    intersect
    - 교집합
    
    minus
    - 차집합

*/

-- 조인 : 컬럼 + 컬럼
-- 유니온 : 레코드 + 레코드

select * from tblMen 
union
select * from tblWomen;

-- 회사 부서별 > 게시판
select * from 게시판; -- 4천만 건

select * from 영업부게시판; -- 천만 건
select * from 총무부게시판; --2천만 건
select * from 개발부게시판; -- 천만 건

-- 사장님 > 모든 부서의 게시판 > 한번에 열람!
select * from 영업부게시판
union
select * from 총무부게시판
union
select * from 개발부게시판;

-- SNS > 게시물 > 년도별로~ > 싸이월드
select * from 게시판2020;
select * from 게시판2021;
select * from 게시판2022;

select * from 게시판2023;

select * from 게시판2023 where 검색;

select * from 게시판2020
union
select * from 게시판2021
union
select * from 게시판2022
union
select * from 게시판2023 where 검색;

-- 조건 > 스키마가 동일해야 한다.
-- 조건 > 데이터 성질도 동일해야한다.
-- 오류 발생
select * from tblCountry -- 5개의 컬럼
union
select * from tblInsa; -- 10개의 컬럼

-- 해결 방법
-- 하지만, 데이터가 의미가 없는 데이터(형편없는 데이터)가 생성됨. 억지로 끼워넣기..
select name, capital, population from tblCountry 
union
select name, buseo, basicpay from tblInsa; 

create table tblUnionA (
    name varchar2(30) not null
);

create table tblUnionB (
    name varchar2(30) not null
);

insert into tblUnionA values ('강아지'); -- *
insert into tblUnionA values ('고양이'); -- *
insert into tblUnionA values ('토끼');
insert into tblUnionA values ('거북이');
insert into tblUnionA values ('병아리');

insert into tblUnionB values ('호랑이');
insert into tblUnionB values ('사자');
insert into tblUnionB values ('강아지'); -- *
insert into tblUnionB values ('코끼리');
insert into tblUnionB values ('고양이'); -- *

select * from tblUnionA;
select * from tblUnionB;

-- union >> 수학 집합의 개념 > 합집합 > 중복값 허용 X 
select * from tblUnionA
union
select * from tblUnionB;

-- union all > 중복값 허용O
select * from tblUnionA
union all
select * from tblUnionB;

-- intersect > 교집합
select * from tblUnionA
intersect
select * from tblUnionB;

-- minus > 차집합
select * from tblUnionA
minus
select * from tblUnionB;

select * from tblUnionB
minus
select * from tblUnionA;



