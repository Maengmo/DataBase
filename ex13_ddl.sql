/*
    ex01 ~ ex12 : DML 기본
    
    ex13_ddl.sql
    
    1. DDL
            - Data Definition Language
            - 데이터 정의어
            - 테이블, 뷰, 사용자, 인덱스, 트리거 등의 데이터베이스 오브젝트를 생성/수정/삭제하는 명령어
            a. create : 생성
            b. drop : 삭제
            c. alter : 수정
      
      테이블 조작하기
      
      create table 테이블명
      (
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        컬럼 정의,
        
        컬럼명 자료형(길이) Null 제약사항
      );

    제약 사항, Constraint
    - 해당 컬럼에 들어갈 데이터(값)에 대한 조건
        - 조건을 만족하면 > 대입
        - 조건을 불만족하면 > 에러발생
    - 유효성 검사 도구
    - 데이터베이스 > 데이터 관리 > 데이터 무결성(***)을 보장하는 도구
  
    1. NOT NULL
        - 해당 컬럼이 반드시 값을 가져야한다.
        - 해당 컬럼에 값이 없으면 에러발생
        - 필수값
        
    2. PRIMARY KEY, PK
        - 기본키 
        - 테이블에서 행과 행을 구분하기 위한 수단 > 제약
        - 행을 식별하는 대표 컬럼을 지정하는 역할
        - 모든 테이블은 반드시 1개의 기본키가 존재해야 한다. (***************************)
        - 중복 값을 가질 수 없다. > Unique
        - 값을 반드시 가진다 . > Not Null
        - Not null + unique > Primary key
        
    3. FOREIGN KEY
    
    4. UNIQUE
        - 유일하다. > 행들간에 동일한 값을 가질 수 없다.
        - null을 가질 수 있다. > 식별자가 될 수 없다.
        ex) 경품 
            - 고객(번호, 이름, 주소, 당첨(UQ))
                1, 홍길동, 서울, 1등
                2, 아무개, 부산, null
                3, 하하하, 서울, 2등
                4, 호호호, 인천, 3등
                
            ex) 초등학교 교실
                - 학생(번호(pk), 이름(not null), 직책(UQ))
                    1,홍길동,반장
                    2,아무개,부반장
                    3,하하하,null
                    4,호호호,체육부장
                
    5. CHECK
        - 사용자 정의 제약 조건
        - where절과 동일한 조건을 컬럼에 적용한다.
    
    6. DEFAULT 
        - 기본값 설정
        - insert/update 작업 때 값을 대입하지 않으면, 미리 준비해놓은 기본값을 대신 넣는 역할
        
*/

-- 메모 테이블
create table tblMemo (
    
    -- 컬럼명 자료형(길이) NULL 제약사항
    -- 뒤에 null을 붙이면 null을 허용한다는 의미
    seq number(3) null, -- 메모번호
    name varchar2(30) null, -- 작성자
    memo varchar2(1000) null, -- 메모
    regdate date null -- 작성날짜
    
);

insert into 테이블 (컬럼리스트) values (값리스트);

insert into tblMemo(seq, name, memo, regdate)
                values (1, '홍길동', '메모입니다.', sysdate);

insert into tblMemo(seq, name, memo, regdate)
                values (2, '아무개', null, sysdate); -- 메모 내용 생략(null)
                
insert into tblMemo(seq, name, memo, regdate)
                values (3, null, null, null);

insert into tblMemo(seq, name, memo, regdate)
                values (null, null, null, null); --절대 생성 금지!!!

insert into tblMemo(seq, name, memo, regdate)
                values (4, '홍길동', '메모입니다.', '2023-03-15');
                
insert into tblMemo(seq, name, memo, regdate)
                values (5, '홍길동', '메모입니다.', to_date('2023-03-15 12:30:50', 'yyyy-mm-dd hh24:mi:ss' ));
                
select * from tblMemo;

drop table tblMemo;

-- 메모 테이블
create table tblMemo (
    
    seq number(3) not null, -- 메모번호
    name varchar2(30) null, -- 작성자
    memo varchar2(1000) not null, -- 메모
    regdate date null -- 작성날짜
    
);

insert into tblMemo(seq, name, memo, regdate)
                values (1, '홍길동', '메모입니다.', sysdate);

-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."MEMO")
insert into tblMemo(seq, name, memo, regdate)
                values (2, '홍길동', null, sysdate);

insert into tblMemo(seq, name, memo, regdate)
                values (3, '홍길동', '', sysdate); --빈문자( '' ) > SQL은 빈문자도 null로 취급한다.

select * from tblMemo;

-- 메모 테이블
create table tblMemo (
    
    seq number(3) primary key,             -- 메모번호(일련번호), Primary Key
    name varchar2(30) null,                  -- 작성자
    memo varchar2(1000) not null,         -- 메모
    regdate date                               -- 작성날짜
    
);

insert into tblMemo(seq, name, memo, regdate)
                values (1, '홍길동', '메모입니다.', sysdate);

-- ORA-00001: unique constraint (HR.SYS_C007072) violated  : 유니크 제약사항을 위반했다.
insert into tblMemo(seq, name, memo, regdate)
                values (2, '홍길동', '메모입니다.', sysdate);

-- ORA-01400: cannot insert NULL into ("HR"."TBLMEMO"."SEQ") : null 값 제약사항 위반 > primary key 는 자동으로 null 제약사항을 검
insert into tblMemo(seq, name, memo, regdate)
                values (null, '홍길동', '메모입니다.', sysdate);

select * from tblMemo;


-- 메모 테이블
create table tblMemo (
    
    seq number(3) primary key,             -- 메모번호(일련번호), Primary Key
    name varchar2(30) unique not null,   -- 작성자(UQ) > 이름은 중복 될 수 없다. > 한 사람이 딱 1개의 글만 작성할 수 있다.
    memo varchar2(1000) not null,         -- 메모
    regdate date                               -- 작성날짜
    
);

insert into tblMemo(seq, name, memo, regdate)
                values (1, '홍길동', '메모입니다.', sysdate);

-- ORA-00001: unique constraint (HR.SYS_C007075) violated
insert into tblMemo(seq, name, memo, regdate)
                values (2, '아무개', '메모입니다.', sysdate);
                
insert into tblMemo(seq, name, memo, regdate)
                values (3, null, '메모입니다.', sysdate);
                
select * from tblMemo;

-- 메모 테이블
create table tblMemo (
    
    seq number(3) primary key,             -- 메모번호(일련번호), Primary Key
    name varchar2(30) check(length(name) > 1),                        -- 작성자
    memo varchar2(1000),                   -- 메모
    regdate date,                               -- 작성날짜
    priority number  check(priority between 1 and 3),  -- 1(중요), 2(보통), 3(사소)
    category varchar2(30) check(category in('할일', '장보기', '공부'))
);

insert into tblMemo(seq, name, memo, regdate, priority, category)
                values (1, '홍길동', '메모입니다.', sysdate, 1, '할일');

-- ORA-02290: check constraint (HR.SYS_C007081) violated                
insert into tblMemo(seq, name, memo, regdate, priority, category)
                values (2, '홍', '메모입니다.', sysdate, 1, '할일');

select * from tblMemo
    where priority between 1 and 3;

-- 메모 테이블
create table tblMemo (
    
    seq number(3) primary key,             -- 메모번호(일련번호), Primary Key
    name varchar2(30) default '익명',      -- 작성자
    memo varchar2(1000),                   -- 메모
    regdate date default sysdate           -- 작성날짜
);

insert into tblMemo(seq, name, memo, regdate)
                values (1, '홍길동', '메모입니다.', sysdate);

insert into tblMemo(seq, name, memo, regdate)
                values (2, '홍길동', '메모입니다.', '2023-01-01');
                
insert into tblMemo(seq, name, memo, regdate)
                values (3, null, '메모입니다.', sysdate);
                
insert into tblMemo(seq, memo, regdate)
                values (4, '메모입니다.', sysdate);
                
insert into tblMemo(seq, memo, regdate)
                values (5, '메모입니다.', default); -- default를 적으면, 해당 컬럼의 default를 적용해라 라는 의미
                
select * from tblMemo;

/*

    제약 사항을 만드는 방법
    - 코드 관리 기법
    
    1. 컬럼 수준에서 만드는 방법
        - 어제 수업내용
        - 컬럼 선언 + 제약 선언
    2. 테이블 수준에서 만드는 방법
        - 컬럼 선언과 제약 선언을 분리해서 관리
    3. 외부에서 만드는 방법
        - alter 명령어를 사용할 때, 씀
        - 테이블 선언과 제약 선언을 분리해서 관리
*/

drop table tblMemo;

create table tblMemo (
    -- 1. 컬럼 수준에서 만드는 방법
    -- seq number(3) primary key,             -- 메모번호(일련번호), Primary Key
    -- seq number(3) [constraint 제약사항명] 제약종류,
    -- seq number(3) constraint tblmemo_seq_pk primary key,
    
    -- 컬럼선언
    seq number(3),
    name varchar2(50) ,      -- 작성자
    memo varchar2(1000),                   -- 메모
    regdate date,         -- 작성날짜
    
    -- 2. 테이블 수준에서 만드는 방법
    -- 제약 사항 선언
    constraint tblmemo_seq_pk primary key(seq),
    constraint tblmemo_name_uq unique(name),
    constraint tblmemo_memo_ck check(length(memo) >=10)
    
);

insert into tblMemo (seq, name, memo, regdate) values (1, '홍길동', '메모입니다. 안녕하세요.', sysdate);
insert into tblMemo (seq, name, memo, regdate) values (1, '홍길동', '메모입니다. 안녕하세요.', sysdate);

select *
from tblMemo;

drop table tblMemo;

create table tblMemo (
    seq number(3), -- 메모번호
    name varchar2(50), -- 작성자
    memo varchar2(1000), -- 메모
    regdate date -- 작성날짜
    
);

-- 3. 외부에서 추가하는 방법
alter table tblMemo
    add constraint tblmemo_seq_pk primary key(seq);









