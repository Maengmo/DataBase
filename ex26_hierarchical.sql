/*

    ex26_hierarchical.sql
    
    계층형 쿼리, Hierarchical Query
    - 오라클 전용
    - 레코드 관계가 서로 상하 수직구조일때 사용
    - 서로 다른 테이블간의 관계가 수직 구조일 때 사용
    - 자기 참조를 하는 테이블에서 사용
    - ex) 카테고리, 답변형 게시판, 조직도 등.. 트리 구조에 사용 
    
    컴퓨터
        - 본체
            - 메인보드
            - 그래픽카드
            - CPU
            - 메모리
        - 모니터
            - 모니터암
            - 보호필름

*/

-- Case 1.

create table tblComputer (
    seq number primary key,                             -- 식별자
    name varchar2(50) not null,                          -- 부품명
    qty number not null,                                   -- 수량
    pseq number null references tblComputer(seq)  -- 부모부품(FK)
);

insert into tblComputer values (1, '컴퓨터', 1, null);

insert into tblComputer values (2, '본체', 1, 1);
insert into tblComputer values (3, '메인보드', 1, 2);
insert into tblComputer values (4, '그래픽카드', 1, 2);
insert into tblComputer values (5, 'CPU', 1, 2);
insert into tblComputer values (6, '메모리', 2, 2);

insert into tblComputer values (7, '모니터', 1, 1);
insert into tblComputer values (8, '모니터암', 1, 7);
insert into tblComputer values (9, '보호필름', 1, 7);

select * from tblComputer;


-- Case 2.

create table tblCategoryBig (
    seq number primary key,                 --식별자(PK)
    name varchar2(100) not null             --카테고리명
);

create table tblCategoryMedium (
    seq number primary key,                             --식별자(PK)
    name varchar2(100) not null,                        --카테고리명
    pseq number not null references tblCategoryBig(seq) --부모카테고리(FK)
);

create table tblCategorySmall (
    seq number primary key,                                 --식별자(PK)
    name varchar2(100) not null,                            --카테고리명
    pseq number not null references tblCategoryMedium(seq)  --부모카테고리(FK)
);


insert into tblCategoryBig values (1, '카테고리');

insert into tblCategoryMedium values (1, '컴퓨터용품', 1);
insert into tblCategoryMedium values (2, '운동용품', 1);
insert into tblCategoryMedium values (3, '먹거리', 1);

insert into tblCategorySmall values (1, '하드웨어', 1);
insert into tblCategorySmall values (2, '소프트웨어', 1);
insert into tblCategorySmall values (3, '소모품', 1);

insert into tblCategorySmall values (4, '테니스', 2);
insert into tblCategorySmall values (5, '골프', 2);
insert into tblCategorySmall values (6, '달리기', 2);

insert into tblCategorySmall values (7, '밀키트', 3);
insert into tblCategorySmall values (8, '베이커리', 3);
insert into tblCategorySmall values (9, '도시락', 3);


-- tbl Computer 
-- 1. 조인
select
    c1.name as "부품명",
    c2.name as "부모 부품명"
from tblComputer c1 -- 자식 부품
    inner join tblComputer c2 --부모 부품
        on c2.seq = c1.pseq;


-- 2. 계층형 쿼리
/*
    구문
    - start with절 + connect by 절

    계층형 쿼리 의사 컬럼
    a. prior > 자기와 연관된 부모 레코드 참조
    b. level > 세대수(depth)
    
*/

select
    seq,
    lpad (' ', (level-1) * 5) || name,
    prior name,
    level
from tblComputer
   -- start with seq = 1 -- 결과 셋의 루트 지정
   --start with seq = (select seq from tblComputer where name = '본체')
   start with pseq is null
        connect by prior seq = pseq; -- 현재 레코드와 부모 레코드를 연결하는 조건(조인 on 역할)
        
select * from tblself;

select
    lpad(' ', (level-1) * 2) || name as "직원명"
from tblself
    start with seq = 1
        connect by super = prior seq;

----------------------------------------------------------------
select * from tblCategoryBig;
select * from tblCategoryMedium where pseq = 1;
select * from tblCategorySmall where pseq = 2;

select
    *
from tblCategoryBig b
    inner join tblCategoryMedium m
        on b.seq = m.pseq
            inner join tblCategorySmall s
                on m.seq = s.pseq;
                
/*

    1. SQL
    
    3. 설계(모델링)
    
    ------------------------------------------ 수업
    
    2. PL/SQL
    
    ------------------------------------------ 수업(오전) + 프로젝트(오후) > 프로젝트(종일)
*/

















