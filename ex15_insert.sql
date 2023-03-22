/*

    ex15_insert.sql
    
    insert
    - DML
    - 테이블에 데이터를 추가하는 명령어(행 추가)
    
    구문
    - insert into 테이블(컬럼리스트) values (값리스트);
    

*/

drop table tblMemo;

create table tblMemo (

    seq number(3) primary key,
    name varchar2(50) ,      -- 작성자
    memo varchar2(1000) not null,                   -- 메모
    regdate date default sysdate        -- 작성날짜
    
);

drop sequence seqMemo;
create sequence seqMemo;

-- 1. 표준 적인 방법(권장)
-- : 원본 테이블에 정의된 컬럼 순서와 개수대로 컬럼리스트를 만들고(a)
-- : 값 리스트를 구성하는 방법(b)
insert into tblMemo (seq, name, memo, regdate) -- a
            values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate); --b

-- 2. 컬럼 리스트의 순서는 원본 테이블과 상관없다.
-- : 컬럼 리스트의 순서와 값리스트의 순서는 반드시 일치해야 한다 (*******************)
insert into tblMemo (name, memo, regdate, seq) 
            values ('홍길동', '메모입니다.', sysdate,seqMemo.nextVal); 

-- ORA-00932: inconsistent datatypes: expected NUMBER got DATE
insert into tblMemo (memo, regdate, seq, name) 
            values ('홍길동', '메모입니다.', sysdate,seqMemo.nextVal); 
            
-- 3. ORA-00947: not enough values
-- : 컬럼 리스트의 컬럼 개수와 값 리스트의 값 개수는 반드시 일치해야 한다.
insert into tblMemo (seq, name, memo, regdate) -- a
            values (seqMemo.nextVal, '홍길동', sysdate); --b

-- 4 .ORA-00913: too many values
-- : 컬럼 리스트의 컬럼개수와 값리스트의 값 개수는 반드시 일치해야 한다.
insert into tblMemo (seq, name, memo) -- a
            values (seqMemo.nextVal, '홍길동', '메모입니다.', sysdate); --b
            
-- 5. null 조작 > name 을 안넣고 싶다. > null 대입
-- 5.1 null 상수 사용 > 명시적
insert into tblMemo (seq, name, memo, regdate) -- a
            values (seqMemo.nextVal, null, '메모입니다.', sysdate); --b
            
-- 5.2 컬럼 생략 > 암시적
insert into tblMemo (seq, memo, regdate) -- a
            values (seqMemo.nextVal, '메모입니다.', sysdate); --b

-- 6. default 조작
-- 6.1 default 상수 사용 
insert into tblMemo (seq, name, memo, regdate) -- a
            values (seqMemo.nextVal, '홍길동', '메모입니다.', default); --b

-- 6.2 컬럼 생략 > null 대입 x > default가 동작함.
insert into tblMemo (seq, name, memo) -- a
            values (seqMemo.nextVal, '홍길동', '메모입니다.'); --b

-- 6.3 null 상수 사용하면, 사용자의 의사를 우선해서 default가 동작을 안한다.
insert into tblMemo (seq, name, memo, regdate) -- a
            values (seqMemo.nextVal, '홍길동', '메모입니다.', null); --b

-- 7. 단축 표현
-- : 컬럼 리스트를 생략할 수 있다. > 원본 테이블의 컬럼 순서를 참고해서 실행
insert into tblMemo values (seqMemo.nextVal, '홍길동', '메모입니다.', default); --b

-- : 컬럼 리스트를 생략하면 값 리스트의 순서를 변경할 수 없다. > 순서 잘 생각 안남 .. 
insert into tblMemo values ('홍길동', '메모입니다.', default, seqMemo.nextVal); --b

-- null 조작
insert into tblMemo values (seqMemo.nextVal,  null, '메모입니다.', default);
-- 아래 상태는 쓰지 못함. 생략 불가능
insert into tblMemo values (seqMemo.nextVal, '메모입니다.', default);

-- default 조작
insert into tblMemo values (seqMemo.nextVal, '홍길동' , '메모입니다.', default);
-- 아래 상태는 쓰지 못함. 생략 불가능
insert into tblMemo values (seqMemo.nextVal,  '홍길동' , '메모입니다.');

-- 8. tblMemo 테이블 > (복사) > tblMemoCopy 테이블 > 실사용O
create table tblMemoCopy (

    seq number(3) primary key,
    name varchar2(50) ,      -- 작성자
    memo varchar2(1000) not null,                   -- 메모
    regdate date default sysdate        -- 작성날짜
    
);
-- 서브 쿼리 > 테이블 복사
insert into tblMemoCopy select * from tblMemo;

drop table tblMemoCopy;

--9. tblMemo 테이블 > (복사) > tblMemoCopy 테이블 > 실사용X, 테스트용
-- : 테이블 생성 + 데이터 복사
-- : ************ 컬럼 구조는 복사가 되는데, 제약 사항은 복사되지 않는다.
-- : 개발용으로 대용량의 더미가 필요한 경우에 사용한다.
create table tblMemoCopy as select * from tblMemo;
-- 아래와 같이 기본키의 제약사항이 안먹히고 삽입되는 것을 볼 수 있음 
insert into tblMemoCopy (seq, name, memo, regdate) -- a
            values (1, '홍길동', '메모입니다.', sysdate); --b

-- 출력 확인
select * from tblMemo;
select * from tblMemoCopy;


















