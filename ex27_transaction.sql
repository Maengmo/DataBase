/*

    ex27_transaction.sql
    
    트랜잭션, Transaction
    - 데이터를 조작하는 업무의 시간적 단위
    - 일련의 사건의 집합. ex) 은행에서 돈을 인출하는 행동(1~8번 행동)
    - 1개 이상의 명령어로 구성된 작업 단위
    
    트랜잭션 명령어
    - DCL, TCL 
    1. commit
    2. rollback
    3. savepoint

*/

create table tblTran -- 완전한 복사본
as
select name, buseo, jikwi from tblInsa;

select * from tblTran;

-- ***************** 어떤 명령어를 어떤 순서대로 실행했는지 반드시 기억!!

commit; -- 이 시각부터 새로운 트랜잭션이 시작된다!! > insert, update, delete만 트랜잭션에 포함된다.

delete from tblTran where name = '박문수';

select * from tblTran; -- 메모리

-- 우리가 하는 모든 insert, update, delete는 데이터베이스에 적용되지 않는다.
--> 임시로 메모리에 적용된다. > 실제 DB에는 적용이 안된다. 

commit; -- 현재 트랜잭션에 했던 모든 명령어를 있었던 일로 만들어라.
rollback; -- 현재 트랜잭션에 했던 모든 명령어를 없었던 일로 만들어라. 

-- rollback 직후 > 이전 트랜잭션 완료 > 새로운 트랜잭션이 시작된다.
select * from tblTran;

delete from tblTran where name = '홍길동';
update tblTran set jikwi = '대리' where name = '이순신';

select * from tblTran; -- 임시 메모리 공간

commit; -- 현재 트랜잭션의 모든 작업을 실제 DB에 반영 > 현재 트랜잭션 완료 > 새로운 트랜잭션 시작
rollback;

select * from tblTran; -- 커밋 완료 후, 실제 DB

rollback; -- 이미 commit을 완료했기 때문에, rollback 불가능

select * from tblTran; 

/*

    트랜잭션이 언제 시작하고? 언제 끝나는지?
    
    새로운 트랜잭션이 시작하는 경우
    1. commit 실행 직 후
    2. rollback 실행 직 후
    3. 클라이언트 접속 직 후(로그인)
    
    현재 트랜잭션이 종료되는 경우
    1. commit 실행 > 현재 트랜잭션을 DB에 반영함
    2. rollback 실행 > 현재 트랜잭션을 DB에 반영 안함
    3. 클라이언트 접속 종료 
        a. 정상 종료
            - 현재 트랜잭션에 아직 반영 안된 명령이 남아있으면 사용자에게 질문?
        b. 비정상 종료
            - rollback 처리
    4. DDL 실행
        a. create, alter, drop > 실행 > 그 즉시 commit 동반!!! > Auto Commit
            - 위의 행동은 DB 구조 변경 > 데이터 영향 O > 사전에 미리 저장
            
*/
delete from tblTran where name = '이순신';

select * from tblTran;

-- 잠시 뒤에 commit or rollback ? > 보류


-- 테이블 or 시퀀스 만들어달라
create sequence seqTest; -- ddl 사용 동시에, 자동으로 commit 

rollback; -- 복구 불가능.. 

select * from tblTran;

-- 클라이언트 툴 > 자동 커밋 > 모든 insert, update, delete > 실행과 무조건 commit 동반 

delete from tblTran where name = '이기자';

rollback; -- 복구 불가능..

select * from tblTran;

commit;

select * from tblTran; -- 59명

delete from tblTran where jikwi = '사원';

select count(*) from tblTran; -- 28

commit;

delete from tblTran where jikwi = '대리';

-- 3. savepoint
-- rollback 하는 시점을 사용자가 마음대로 정의 

commit;

select * from tblTran;

--김종서
update tblTran set jikwi = '이사' where name = '김종서'; -- 가

savepoint a; -- 중간 저장

select * from tblTran;

--허경운
delete from tblTran where name = '허경운'; -- 나

savepoint b; -- 중간 저장

insert into tblTran values ('하하하', '기획부', '사원'); -- 다 

rollback to b; -- b지점 위치로 돌아감

select * from tblTran;

rollback to a; -- a지점 위치로 돌아감

select * from tblTran;















