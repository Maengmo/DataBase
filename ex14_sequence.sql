/*

    ex14_sequence.sql
    
    데이터베이스 객체
    1. 테이블
    2. 계정(hr)
    3. 제약사항
    
    시퀀스, Sequence
    - 데이터베이스 객체 중 하나
    - 오라클 전용 객체(다른 DBMS에는 없음)
    - 일련 번호를 생성한는 객체(*********************************************)
    - (주로) 식별자를 만드는 용도로 많이 사용한다. > PK 컬럼에 일련 번호를 넣을 때 많이 사용한다.
    
    시퀀스 객체 생성하기
    - create sequence 시퀀스명 [옵션];
    
    시퀀스 객체 삭제하기
    - drop sequence 시퀀스명;
    
    시퀀스 객체 사용하기
    - 시퀀스명.nextVal > 주로 사용
    - 시퀀스명.currVal > 가끔 사용
    
*/

create sequence seqNum;

drop sequence seqNum;

select seqNum.nextVal from dual; --10 > 11 번호는 서로 영향을 받지 않음 .

create sequence seqTest;

select seqTest.nextVal from dual; -- 5 > 6

drop table tblMemo;

create table tblMemo (

    seq number(3) primary key,
    name varchar2(50) ,      -- 작성자
    memo varchar2(1000),                   -- 메모
    regdate date         -- 작성날짜
    
);

-- 메모 번호 시퀀스 객체
create sequence seqMemo;
drop sequence seqMemo;

insert into tblMemo (seq, name, memo, regdate) 
    values (seqMemo.nextVal, '홍길동', '메모입니다.' || seqMemo.nextVal , sysdate);

select seqMemo.nextVal from dual;

select max(seq) from tblMemo;
create sequence seqMemo start with 7;

select * from tblMemo;


-- currVal > 시퀀스 객체가 마지막에 만든 숫자를 확인하는 함수 > 큐,스택 peek() 역할
-- > 로그인을 한 뒤(접속) 최소 1회 이상 nextVal를 호출하고 난뒤에만 currVal 호출할 수 있다.
select seqMemo.currVal from dual; -- 5

-- 일련번호 > 숫자로만 X
-- 쇼핑몰 상품번호 > ABC10010
select seqMemo.currVal from dual;  --13 > ABC0013 

select 'ABC' || seqNum.nextVal from dual;


select 'ABC' || to_char(seqNum.nextVal, '0000') from dual; --ABC 0010


select 'ABC' || ltrim(to_char(seqNum.nextVal, '0000')) from dual; --ABC0011

/*

    시퀀스 객체 생성하기
    
    create sequence 시퀀스명;
    
    create sequence 시퀀스명 
                            increment by n  -- 증감치(**)
                            start with n         -- 시작값(**)
                            maxvalue n         -- 최댓값
                            minvalue n          -- 최솟값
                            cycle                 -- 루프
                            cache n;             -- 캐시

*/

drop sequence seqNum;
-- 번호를 200번 부터 시작 
create sequence seqNum
                        start with 200;

-- 번호를 100씩 증가 +100 
create sequence seqNum
                        increment by 100;

-- 번호를 -1씩 감소                         
create sequence seqNum
                        increment by -1;
                        
-- 100 부터 -1 씩 감소
create sequence seqNum
                        start with 100
                        increment by -1
                        maxvalue 100;

-- 10까지만 증가, 정해진 maxvalue를 초과하면 에러 발생.
create sequence seqNum
                        maxvalue 10;

-- -10까지 감소, 정해진 minvalue보다 작아지면 에러 발생.
create sequence seqNum
                        increment by -1
                        minvalue -10;

-- 1~10까지 계속 반복 
create sequence seqNum
                        increment by 1
                        start with 1
                        maxvalue 10 
                        cycle
                        cache 5;
                        
create sequence seqNum;


select seqNum.nextVal from dual;

-- 메모 번호 > 역할 > 1다음 2어야만 하는가?(x) > 유일한 식별자!!
-- 1, 2, 3, 4, 5 > 21 

-- 버그 > 가끔씩 캐시 날라감
-- 게시판 글쓰기 > 마지막 15번 > 21번

-- 구멍이 발생(x) > 안되는 번호!!
drop sequence seqMemo;
create sequence seqMemo start with 16;


