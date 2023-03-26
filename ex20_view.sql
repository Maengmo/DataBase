/*

    ex20_view.sql
    
    데이터베이스 객체
    1. 테이블
    2. 계정(hr)
    3. 제약사항
    4. 시퀀스
    5. 뷰 
    
    View, 뷰
    - 데이터베이스 객체 중 하나
    - 가상 테이블, 뷰 테이블 등...
    - 테이블처럼 사용한다.(*****)
    - 뷰는 SQL을 저장한 객체이다.
    - 뷰는 호출될때마다 저장된 SQL이 실행된다. (실시간 가상 테이블)
    
    View 역할(목적)
    1. 쿼리를 단순화한다. > 가독성 향상
    2. 보안 관리
    3. 쿼리 > 다른 사용자(hr 등)과 공유
    
        
    create view 뷰명
    as
    select문;
    
    create [or replace] view 뷰명
    as
    select문;

*/

create or replace view vwInsa -- tblInsa 테이블의 복사본
as
select * from tblInsa;

select *
from vwInsa; -- tblInsa 처럼 행동

create or replace view vwInsa
as
select name, jikwi, city, buseo from tblInsa where buseo = '영업부';

select *
from vwInsa; -- 뷰 == 영업부 테이블

-- 비디오 대여점 사장 > 반복 업무
create or replace view 대여체크 
as
select 
    m.name as mname,
    v.name as vname,
    to_char(r.rentdate, 'yyyy-mm-dd') as rentdate,
    case
        when r.retdate is not null then '반납완료'
        else '미반납'
    end as state,
    case
       when r.retdate is null then round((sysdate - (r.rentdate + (select period from tblGenre where seq = v.genre))))
    end as "연체날짜",
    r.rentdate as "대여날짜",
    (select period from tblGenre where seq = v.genre) as "대여기간(일)",
    case
        when r.retdate is null
            then round((sysdate - (r.rentdate + (select period from tblGenre where seq = v.genre))) * g.price * 0.1)
    end as "연체금" -- 대여가격(10%) x 연체일
from tblRent r
    inner join tblVideo v
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member
                    inner join tblGenre g
                        on g.seq = v.genre
                    order by state asc;

select * from tblGenre;

select * from tblRent;
select * from tblVideo;

select sysdate - (r.rentdate + 3) from tblRent r;
select sysdate - (r.rentdate + (select priod from tblGenre where seq = )) from tblRent r;

select * from 대여체크;

------------------
-- 뷰 정의 > select 결과셋의 복사본 : 80%정답 > 데이터 저장한 객체(X)
-- 뷰 정의 > select문을 저장한 객체 : 100% 정답 > SQL 저장한 객체
create or replace view vwComedian
as
select * from tblComedian;

select* from tblComedian; -- 원본 테이블
select* from vwComedian; -- 복사 테이블

update tblComedian set weight = 70 where first = '재석';

select * from vwComedian; -- 재사용 목적
select * from (select * from tblComedian); -- from 서브쿼리 == 인라인 뷰 > 1회용

-- 보안(권한)
select * from tblInsa; -- 전직원 + 모든 정보

-- 신입사원(hr) > 영업부 > 업무 > 영업부 직원들에게 일괄 문자 메시지 전송
select * from tblInsa; -- 신입사원에게 tblInsa 접근할 권한 > tblInsa 접근 제한

create or replace view 연락처
as 
select name, tel from tblInsa where buseo = '영업부';

select * from 연락처; -- 신입사원에게 연락처 객체에 대한 접근 권한만 부여

------------------------------------------
create or replace view vwTodo
as
select * from tblTodo;

-- 뷰 사용 
-- 1. select > 실행 O > 뷰는 Only 읽기 전용이다. (******) == 읽기 전용 테이블
-- 2. insert > 실행 O > 절대 사용 금지
-- 3. update > 실행 O > 절대 사용 금지
-- 4. delete > 실행 O > 절대 사용 금지

select * from vwTodo; -- 단순뷰 > 뷰의 select 문이 1개의 테이블로 구성
insert into vwTodo values (21, '오라클 복습하기', sysdate, null);
update vwTodo set title = '오라클 정리하기' where seq = 21;
delete from vwTodo where seq = 21;

select * from 대여체크; --복합뷰 > 2개 이상 테이블을 사용해서 select
insert into 대여체크 values ('홍길동', '반지의 제왕', sysdate, '미반납', 0, 0);

-- 이 뷰를 사용하는 사용자의 입장에서 이 뷰가 복합뷰인지 단순뷰인지 알 수 없다. 
select * from vwTodo;   -- 단순뷰 >
select * from 대여체크;  -- 복합뷰 > 














