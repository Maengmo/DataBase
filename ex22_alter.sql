/*

    ex22_alter.sql
    
    DDL > Object
    - 객체 생성 : create
    - 객체 삭제 : drop
    - 객체 수정 : alter
    
    DML > Data(Record)
    - 데이터 생성 : insert
    - 데이터 삭제 : delete
    - 데이터 수정 : update 

    테이블 수정하기
    - 테이블 정의 수정 > 컬럼 수정 > 컬럼명 or 자료형(길이) or 제약사항
    
    테이블 수정해야 하는 상황 발생!!
    1. 테이블 삭제(drop) > 테이블 DDL(Create) 수정 > 수정된 DDL로 새롭게 테이블 생성
        a. 기존 테이블 데이터가 없었을 경우 > 아무 문제 없음
        b. 기존 테이블 데이터가 있었을 경우 > 미리 데이터 백업 > 테이블 삭제 > 수정 후 생성 > 데이터 복구 
            - 공부할 때 자주 사용
            - 개발 중에 사용 
            - 서비스 운영 중 > 불가능 !!
            
    2. alter 명령어 사용 > 기존 테이블 구조(컬럼 정의) 변경
        a. 기존 테이블 데이터가 없었을 경우 > 아무 문제 없음
        b. 기존 테이블 데이터가 있었을 경우 > 경우에 따라 다름
            - 공부할 때 사용
            - 개발 중에 사용
            - 서비스 운영 중 > 이 방식을 사용 > 운영 중에도 이 방식을 사용 금지

*/
drop table tblEdit;

create table tblEdit (
    seq number primary key,
    data varchar2(20) not null
);

insert into tblEdit values (1, '마우스');
insert into tblEdit values (2, '키보드');
insert into tblEdit values (3, '모니터');

select * from tblEdit;

-- 1. 새로운 컬럼 추가하기
-- 가격 컬럼 추가하기 > price, number
-- alter table tblEdit add (컬럼 정의);

-- ORA-01758: table must be empty to add mandatory (NOT NULL) column
-- 테이블이 비어있는 상태가 아니라서 not null 에러 발생
alter table tblEdit 
    add (price number not null);

alter table tblEdit 
    add (price number null);

desc tblEdit;

delete from tblEdit;

select * from tblEdit;

alter table tblEdit
    add (memo varchar2(100) not null);


insert into tblEdit values (1, '마우스', 10000, '로지텍');
insert into tblEdit values (2, '키보드', 20000, 'MS');
insert into tblEdit values (3, '모니터', 30000, 'Dell');

select * from tblEdit;

-- 2. 컬럼 삭제하기
alter table tblEdit
    drop column memo;

alter table tblEdit
    drop column seq;  -- PK 컬럼 삭제 > 절대 금지!!!


select * from tblEdit;

-- 3. 컬럼 수정하기
-- ORA-12899: value too large for column "HR"."TBLEDIT"."DATA" (actual: 38, maximum: 20)
insert into tblEdit values (4, '인텔 i7 13세대 최신형 노트북');

-- 3.1 컬럼의 길이 수정하기(확장/축소)
alter table tblEdit
    modify (data varchar2(100)); -- not null 은 그대로 유지

desc tblEdit;

-- 3.2 컬럼의 제약 사항 수정하기
alter table tblEdit
    modify (data varchar2(100) null);
    
-- 3.3 컬럼의 자료형 바꾸기
-- 마찬가지로, 안에 데이터들이 비어있는 상태여야 가능하다.
alter table tblEdit
    modify (data number);

alter table tblEdit
    modify (seq varchar2(30));

delete from tblEdit;

select * from tblEdit;

alter table tblEdit
    add (price number default 0 not null);


