-- ex30.seql

-- 일련번호가 필요하 업무 > 순차적으로 증가하는 숫자(날짜)가 필요한 업무
-- 오라클 전용 > 계층형 쿼리

select 
    level,
    prior name as "상사",
    name as "직원"
from tblSelf
   start with name = '홍사장'
        connect by super = prior seq;
        
select
    level
from dual
    connect by 1 = 1;

-- ******** 기억
select
    level
from dual
    connect by level <=5;

-- 2023-03-01 ~ 2023-03-31 > date
-- 1. ANSI-SQL
-- 2. PL/SQL
-- 3. JAVA

select
    to_date('2023-03-01', 'yyyy-mm-dd') + level -1
from dual
    connect by level <= 31;

rollback;

-- 근태 상황(출석) > 학교에 직접 출석했을때만 기록
create table tblDate (
    seq number primary key,        -- 번호(PK)
    state varchar2(30) not null,      -- 정상|지각|조퇴
    regdate date not null            -- 날짜
);

--insert into tblDate values (1, '정상', '2023-03-01');
insert into tblDate values (2, '정상', '2023-03-02');
insert into tblDate values (3, '정상', '2023-03-03');
--insert into tblDate values (4, '정상', '2023-03-04');
--insert into tblDate values (5, '정상', '2023-03-05');
insert into tblDate values (6, '정상', '2023-03-06');
insert into tblDate values (7, '지각', '2023-03-07');
insert into tblDate values (8, '조퇴', '2023-03-08');
insert into tblDate values (9, '정상', '2023-03-09');
insert into tblDate values (10, '정상', '2023-03-10');
--insert into tblDate values (11, '정상', '2023-03-11');
--insert into tblDate values (12, '정상', '2023-03-12');
insert into tblDate values (13, '정상', '2023-03-13');
insert into tblDate values (14, '지각', '2023-03-14');
--insert into tblDate values (15, '정상', '2023-03-15'); --결석
insert into tblDate values (16, '지각', '2023-03-16');
insert into tblDate values (17, '정상', '2023-03-17');
--insert into tblDate values (18, '정상', '2023-03-18');
--insert into tblDate values (19, '정상', '2023-03-19');
insert into tblDate values (20, '정상', '2023-03-20');

select * from tblDate;

-- 요구사항] 3월 1일 ~ 3월 20일까지 모든 날짜와 근태정보를 가져오시오.
-- **** 근태 기록이 없는 빠진 날짜도 같이 가져오시오.

-- 조회 기간 > 날짜 생성
select
    to_date('2023-03-20' , 'yyyy-mm-dd') - to_date('2023-03-01', 'yyyy-mm-dd') +1
from dual;

create or replace view vwDate
as
select
    to_date('2023-03-01', 'yyyy-mm-dd') + (level -1) as regdate
from dual
    connect by level <= (to_date('2023-03-20' , 'yyyy-mm-dd') - to_date('2023-03-01', 'yyyy-mm-dd') +1) ;

select * from vwDate;   --조회기간
select * from tblDate;   --근태기록

select
    v.regdate,
    t.state
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            order by v.regdate asc;

-- 주말 처리(토,일)
select
    v.regdate,
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
    end state
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            order by v.regdate asc;

-- 공휴일 처리
create table tblHoliday (
    seq number primary key,
    regdate date not null,
    name varchar2(30) not null
);

insert into tblHoliday values (1, '2023-03-01', '삼일절');
select * from tblHoliday;

select
    v.regdate,
    case
        when to_char(v.regdate, 'd') = '1' then '일요일'
        when to_char(v.regdate, 'd') = '7' then '토요일'
        when t.state is null and h.name is not null then h.name
        when t.state is null and h.name is null then '결석'
        else t.state
    end state
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            left outer join tblHoliday h
                on v.regdate = h.regdate
                    order by v.regdate asc;
                    
-----------------------------------------------------------
/*
    
    프로시저
    
    1. 익명 프로시저
        - 1회용 
    2. 실명 프로시저
        - 재사용
        - 오라클에 저장
    
    실명 프로시저
    - 저장 프로시저(Stored Procedure)
    
    1. 저장 프로시저, Stored Procedure
        - 매개변수 구성 / 반환값 구성 > 자유
        
    2. 저장 함수, Stored Function
        - 매개변수 필수 / 반환값 필수 > 고정 
        
    익명 프로시저 선언
    [declare
        변수 선언;
        커서 선언;]
    begin
        구현부;
    [exception
        처리부;]
    end;
    
    저장 프로시저 선언
    create [or replace] procedure 프로시저명
    is(as)
    [변수 선언;
        커서 선언;]
    begin
        구현부;
    [exception
        처리부;]
    end;
    
*/

-- 익명 프로시저 > 즉시 실행 > 실행 회차별 비용 = 동일
declare
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;

-- 저장 프로시저
create or replace procedure procTest
is
    vnum number;
begin
    vnum := 100;
    dbms_output.put_line(vnum);
end;

-- 저장 프로시저 호출하는 방법 (메소드 실행하는 방법)
-- 현재 코딩하는 영역 > ANSI-SQL 영역
select * from tblInsa;

procTest;

-- PL/SQL을 영역을 만든 뒤 > 그안에서 프로시저를 호출할 수 있다.
begin
    -- 이 안이 PL/SQL 영역
    procTest;
end;

-- output 실행 안되서 이걸 실행시킴
SET serveroutput ON;

execute procTest;
exec procTest;
call procTest();


-- 저장 프로시저 = 메소드
-- 매개변수 & 반환값

-- 1. 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number) --매개변수 
is
    vnum number; --일반변수(지역 변수)
begin

    vnum := pnum * 2;
    dbms_output.put_line(vnum);

end procTest;

begin
    procTest(100);
    procTest(200);
    procTest(300);
end;

create or replace procedure procTest(
    width number, 
    height number
)
is
    vnum number;
begin

    vnum := width * height;
    dbms_output.put_line(vnum);

end procTest;

begin
    procTest(10,20);
end;

-- 일반 변수 : vname varchar2(30) not null default '이름'

-- *** 프로시저 매개변수는 길이와 not null 표현이 불가능하다.
create or replace procedure procTest(
    pname varchar2
)
is --declare 대신하는 is(as)는 변수 선언이 없어도 반드시 기재
begin
    dbms_output.put_line('안녕하세요. ' || pname || '님');
end procTest;

begin
    procTest('홍길동');
end;


create or replace procedure procTest(
    width number, 
    height number default 10
)
is
    vnum number;
begin

    vnum := width * height;
    dbms_output.put_line(vnum);

end procTest;

begin
    -- 오버로딩..(x) > 매개변수 기본값(O)
    procTest(10,20);
    procTest(10);
end;



/*

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    - call by value
    - call by reference
    
    1. in 모드 > 기본 모드
    2. out 모드 
    3. in out 모드 > X

*/
create or replace procedure procTest (
    pnum1 in number,    -- 우리가 알고있는 기존의 매개변수(호출할 때 넘기는 데이터)
    pnum2 in number,    --
    presult1 out number, -- 변수 자체가 전달, 변수의 주소값 전달 > 반환값 역할
    presult2 out number,
    presult3 out number
)
is
begin
    dbms_output.put_line(pnum1+pnum2);
    presult1 := pnum1 + pnum2;
    presult2 := pnum1 * pnum2;
    presult3 := pnum1 / pnum2;
end procTest;

-- PLS-00363: expression 'TO_NUMBER(SQLDEVBIND1Z_1)' cannot be used as an assignment target
declare
    vresult number;
begin
    procTest(10,20,vresult);
    dbms_output.put_line(vresult);
end;

declare
    vresult1 number;
    vresult2 number;
    vresult3 number;
begin
    procTest(10,20,vresult1,vresult2,vresult3);
    dbms_output.put_line(vresult1);
    dbms_output.put_line(vresult2);
    dbms_output.put_line(vresult3);
end;

-- 1. 부서 지정 > 해당 부서 직원 중 급여 가장 많이 받는 사람의 번호 반환
--      in 1개 > out 1개
-- procTest1
select * from tblInsa;
create or replace procedure procTest1 (
    pbuseo in varchar2,    -- 우리가 알고있는 기존의 매개변수(호출할 때 넘기는 데이터)
    pnum out number    --
)
is
begin
    select num into pnum from tblInsa where basicpay = (select max(basicpay) from tblInsa where buseo = pbuseo);
    
end procTest1;
declare
    vnum number;
begin
    procTest1('기획부', vnum);
    dbms_output.put_line(vnum);
end;

-- 2. 직원 번호 지정 > 같이 지역에 사는 직원 수, 같은 직위의 직원 수, 해당 직원보다 급여를 더 많이 받은 직원 수를 반환
--      in 1개 > out 3개
-- procTest2
select * from tblInsa;
select count(*) from tblInsa where city = (select city from tblInsa where num = 1001);
select count(*) from tblInsa where jikwi = (select jikwi from tblInsa where num = 1001);
select count(*) from tblInsa where basicpay > (select basicpay from tblInsa where num = 1001);

create or replace procedure procTest2 (
    pnum in number,    -- 우리가 알고있는 기존의 매개변수(호출할 때 넘기는 데이터)
    pcnt1 out number,
    pcnt2 out number,
    pcnt3 out number
)
is
    vcity tblInsa.city%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
begin
    select city, jikwi, basicpay into vcity, vjikwi, vbasicpay from tblInsa where num = pnum;
    
    select count(*) into pcnt1 from tblInsa where city = vcity;
    select count(*) into pcnt2 from tblInsa where jikwi = vjikwi;
    select count(*) into pcnt3 from tblInsa where basicpay > vbasicpay;
    
end procTest2;
declare
    vcnt1 number; vcnt2 number; vcnt3 number;
begin
    procTest2(1001, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;
--------------------------------------------2023-03-29
select * from tblStaff;
select * from tblProject;

-- A. 신입 사원 추가 + 프로젝트 담당

-- B. 사원 퇴사 : 담당 프로젝트 확인 > 다른 직원에게 위임 > 퇴사

-- A. 신입 사원 추가 + 프로젝트 담당
create or replace procedure procAddStaff (
    pname in varchar2,     -- 신입 사원명
    psalary in number,      -- 신입 급여
    paddress in varchar2,  -- 신입 주소
    pproject in varchar2,   -- 프로젝트명
    presult out number    -- 피드백(성공/실패)
)
is
    vseq number; --신입 사원 번호
begin
    -- 신입 사원 번호 생성
    select nvl(max(seq), 0) + 1 into vseq from tblStaff;
    -- 1. 신입 사원 추가
    insert into tblStaff (seq, name, salary, address)
        values (vseq, pname, psalary, paddress);
        
    -- 2. 프로젝트 담당
    insert into tblProject (seq, project, staff_seq)
        values ((select nvl(max(seq),0) + 1 from tblProject), pproject, vseq);
        
    presult := 1; -- 성공 
    
exception
    when others then
        presult := 0; -- 실패
        
end procAddStaff;

-- 기존 방식 > 프로시저
-- 1. 단순화(모듈화)
-- 2. 팀작업 원활
-- 3. 저장 객체(공유)
-- 4. 속도 향상

-- 테스트
declare
    vresult number; -- 결과(out)
begin
    --procAddStaff('이순신', 300, '서울시', '박물관 건립', vresult);
    procAddStaff('유관순', 350, '부천시', '미술관 건립', vresult);
    
    if vresult = 1 then
        dbms_output.put_line('성공');
    else
        dbms_output.put_line('실패');
    end if;
end;

set serveroutput on;

-- B. 사원 퇴사 : 담당 프로젝트 확인 > 다른 직원에게 위임 > 퇴사
create or replace procedure procRemoveStaff (
    pseq in number,      --퇴사할 직원번호
    pdseq in number,     --위임할 직원 번호
    presult out number
)
is
    vcnt number;
begin
    -- 1. 퇴사 직원 번호가 유효한지? 존재 하는 번호인지?
    select count(*) into vcnt from tblStaff where seq = pseq;
    
    -- 2. 확인
    if vcnt = 1 then
         -- 존재
         -- 3. 위임받은 직원 번호 확인
         select count(*) into vcnt from tblStaff where seq = pdseq;
         
         if vcnt = 1 then
            -- 4. 담당 프로젝트 확인 > 위임 
            select count(*) into vcnt from tblProject where staff_seq = pseq;
            
            if vcnt > 0 then 
                --5. 위임
                update tblProject set
                    staff_seq = pdseq
                        where staff_seq = pseq;
           
            end if;
            
            --6. 퇴사
                delete from tblStaff where seq = pseq;
                presult := 1;
            
         else
            presult := 0;
         end if;
         
    else
        presult := 0;
    end if;

exception
    when others then
        presult := 0; -- 실패
        
end procRemoveStaff;

-- 테스트
declare
    vresult number; -- 결과(out)
begin
    procRemoveStaff (6, 5, vresult);
    
    if vresult = 1 then
        dbms_output.put_line('성공');
    else
        dbms_output.put_line('실패');
    end if;
end;

select * from tblStaff;
select * from tblProject;

rollback;


/*

    저장 프로시저
    1. 저장 프로시저
    2. 저장 함수, Stored Function > 함수, Function
    
    저장 함수, Stored Function > 함수, Function
    - 저장 프로시저와 동일
    - 반환값이 반드시 존재 > out 파라미터 사용(X) > return 문 사용(O)
    - out 파라미터 사용 안함 > out 동작 가능 
    - in 파라미터 사용함
    - 이 특성때문에 함수는 프로시저와 조금 다른 상황에서 사용(****) : 함수 vs 프로시저

*/

-- 1 + 2 > 3
create or replace function fnSum (
    pnum1 in number,
    pnum2 in number
) return number
is
begin
    return pnum1 + pnum2;
end fnSum;

declare
    vresult number;
begin
    -- 프로시저 out > 개수 1개 이상
    -- 함수 return > 개수 딱 1개
    vresult := fnSum(10,20);
    dbms_output.put_line(vresult);
end;
-- 프로시저 맨 끝에다가 '/' 를 붙이면 자동으로 블럭이 다시 잡힘
/

select
    height, weight,
    height + weight,
    fnSum(height, weight) -- 프로시저 저장 함수는 ANSI-SQL에서 사용할 수 있음.
    --procSum(height,weight) -- 프로시저 저장 프로시저는 ANSI-SQL에서 사용할 수 없음.
from tblComedian;

-- 인사테이블 > 이름, 부서, 직위, 성별(남자|여자)
-- 팀 프로젝트 (A 팀원 작업)
select
    name, buseo, jikwi,
    case substr(ssn,8,1)
        when '1' then '남자'
        when '2' then '여자'
    end as gender
from tblInsa;

-- 팀 프로젝트 (B 팀원 작업)
-- 이름, 급여, 성별(남자|여자)
select
    name, basicpay,
    case substr(ssn,8,1)
        when '1' then '남자'
        when '2' then '여자'
    end as gender
from tblInsa;

-- 해결 방안
create or replace function fnGender (
    pssn varchar2
) return varchar2
is
begin
    return case substr(pssn,8,1)
                when '1' then '남자'
                when '2' then '여자'
            end;
end fnGender;
/
-- 실행
select
    name, basicpay,
    fnGender(ssn) as Gender
from tblInsa;

/*

    SQL 처리 순서
    - select 문 실행(select * from tblInsa;)
    
    1. ANSI-SQL or 익명 프로시저
         a. 클라이언트 > 구문 작성(select)
         b. 클라이언트 > 실행(ctrl+Enter)
         c. 명령어를 오라클 서버로 전송
         d. 서버 > 명령어 수신
         e. 서버 > 파싱(토큰 분해) > 문법 검사 
         f. 서버 > 컴파일(기계어)
         g. 서버 > 실행(SQL)
         h. 서버 > 결과셋 생성
         i. 서버 > 결과셋을 클라이언트에게 반환
         j. 클라이언트 > 결과셋 > 화면 출력
         - 동일한 명령어를 재실행해도 실행비용이 항상 동일하다.
         
    2. 저장 프로시저(프로시저 or 함수)
         a. 클라이언트 > 구문 작성(select)
         b. 클라이언트 > 실행(ctrl+Enter)
         c. 명령어를 오라클 서버로 전송
         d. 서버 > 명령어 수신
         e. 서버 > 파싱(토큰 분해) > 문법 검사 
         f. 서버 > 컴파일(기계어)
         g. 서버 > 실행(SQL)
         h. 서버 > 서버에 프로시저가 생성 > 영구 저장(HDD)
         i. 서버 > 종료
         
         a. 클라이언트 > 구문 작성(호출)
         b. 클라이언트 > 실행(ctrl+Enter)
         c. 명령어를 오라클 서버로 전송
         d. 서버 > 명령어 수신
         e. 서버 > 파싱(토큰 분해) > 문법 검사 
         f. 서버 > 컴파일(기계어)
         g. 서버 > 실행(SQL)
         h. 서버 > 이전의 컴파일 완료된 프로시저가 실행 > 프로시저에 관련된 작업을 재사용
         i. 서버 > select > 결과셋 반환
         j. 클라이언트 > 결과셋 > 화면에 출력 
         
         - 동일한 명령어 실행 > 반복 비용 저렴(컴파일된 프로시저 호출 > 파싱 + 컴파일 > 생략) > 속도 향상
         
*/
select * from tblInsa;

/*

    트리거, Trigger
    - 프로시저의 한 종류
    - 개발자가 호출하는게 아니라, 미리 지정한 특정 사건이 발생하면 자동으로 실행되는 프로시저
    - 예약(사건) > 사건 발생 > 프로시저 호출
    - 특정 테이블 지정 > 감시(insert or update or delete) > 미리 준비해 놓은 프로시저 호출
    
    트리거 구문
    create or replace trigger 트리거명
        before|after
        insert|update|delete on 테이블명
        [for each row]
    declare
        선언부;
    begitn
        구현부;
    exception
        예외처리부;
    end;

*/

-- tblInsa > 직원 삭제
create or replace trigger trgInsa
    before --삭제하기직전에 프로시저를 실행해라
    update -- 삭제가 발생하는지 감시해라
    on tblInsa -- 감시 대상 > tblInsa
begin   
    dbms_output.put_line('트리거가 실행되었습니다');
end trgInsa;
/

select * from tblInsa;

rollback;

delete from tblBonus where num = 1001;
delete from tblInsa where name = '홍길동';

select * from tblInsa;
update tblInsa set
    name = '탈퇴',
    ssn = '탈퇴',
    ibsadate = sysdate,
    city = '탈퇴',
    tel = '탈퇴',
    buseo = '탈퇴',
    basicpay = 0,
    sudang = 0
        where num = 1001;

/*
    시나리오
    
    레코드 삭제 > 관계 맺은 자식 테이블에서 참조가 있는 경우..
    
    1. 홍길동 > 삭제 취소 
    2. 홍길동 > 삭제
        a. 홍길동 삭제 + 자식 삭제 : 오라클 delete cascade
        b. 홍길동 삭제 + 자식 보존
        c. 홍길동 변형 + 자식 보존
*/
select * from tblBonus where num = 1001;

drop table tblBonus;

select * from tblInsa;
delete from tblInsa where num = 1002;

update tblInsa set city = '서울' where num = 1003;

rollback;
-- tblInsa > 직원 퇴사
-- 수요일 > 퇴사 금지!!
create or replace trigger trgRemoveInsa
    before
    delete
    on tblInsa
begin

    dbms_output.put_line('트리거 실행');
    
    -- 수요일 퇴사 금지 > 현재 무슨 요일?
   -- if to_char(sysdate, 'day') = '수요일' then
    --if to_char(sysdate, 'dy') = '수' then
    if to_char(sysdate, 'd') = '4' then
        dbms_output.put_line('수요일');
        -- 퇴사 금지 > 지금 트리거 호출의 원인 > 실행 중인 delete문을 없었던 일로 > 취소 > 강제 예외 발생!!
        -- 자바 > throw new Exception();
        -- -20000 ~ -29999
        raise_application_error (-20000, '수요일에는 퇴사가 불가능 합니다.');
    else
        dbms_output.put_line('다른 요일');
    end if;

end trgRemoveInsa;
/
select * from tblInsa;
rollback;
delete from tblInsa where num = 1004;


select * from tblMen;

create table tblLogMen (
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
);

create sequence seqLogMen;

create or replace trigger trgLogMen
    after 
    insert or update or delete
    on tblMen
declare
    vmessage varchar2(1000);
begin
    
    -- 호출 : insert? update? delete?
    dbms_output.put_line('트리거 실행');
    
    if inserting then
         dbms_output.put_line('새로운 항목이 추가되었습니다.');
         vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
        dbms_output.put_line('항목이 수정되었습니다.');
        vmessage := '항목이 수정되었습니다.';
    elsif deleting then
        dbms_output.put_line('항목이 삭제되었습니다.');
        vmessage := '항목이 삭제되었습니다.';
    end if;
    
    insert into tblLogMen values (seqLogMen.nextVal, vmessage, default);
    
end trgLogMen;
/
select * from tblMen;

-- 업무 중 트리거가 발생한다는 사실을 당사자는 모름;;
insert into tblMen values ('테스트', 22, 175, 60, null);
update tblMen set weight = 65 where name = '테스트';
delete from tblMen where name = '테스트';

select * from tblLogMen;

-- 보통, 트리거 선언시, 감시 대상 테이블을 구현부에서 조작하지 않는다.
create or replace trigger trgCountry
    after
    update
    on tblCountry
begin

    update tblCountry set
        population = population * 1.1;
        
end trgCountry;
/
-- ORA-00036: maximum number of recursive SQL levels (50) exceeded
update tblCountry set capital = '제주' where name = '대한민국';

/*

    [for each row]
    
    1. 사용 x
        - 문장(Query) 단위 트리거
        - 트리거 실행 1회
    
    2. 사용 o
        - 행(Record) 단위 트리거 
        - 트리거 실행 반복

*/
select * from tblWomen;

-- 문장 단위 트리거 > 집단을 대상으로 실행
-- : delete 1회 실행 > 적용된 행 1개  > 프로시저 1회 호출
-- : delete 1회 실행 > 적용된 행 10개 > 프로시저 1회 호출

-- for each row 사용
-- 행 단위 트리거
-- : delete 1회 실행 > 적용된 행 1개 > 프로시저 1회 호출
-- : delete 1회 실행 > 적용된 행 10개 > 프로시저 10회 호출
create or replace trigger tblWomen
    after 
    delete
    on tblWomen
    for each row
begin
    dbms_output.put_line('레코드를 삭제했습니다.' || :old.name);
    
end trgWomen;
/

delete from tblWomen where name = '하하하';
delete from tblWomen;

rollback;

-- insert 트리거
create or replace trigger tblWomen
    after 
    insert
    on tblWomen
    for each row
begin
    -- 상관관계(:new) > 새롭게 추가되는 행 참조 객체
    dbms_output.put_line('레코드를 추가했습니다.' || :new.name || :new.age);
end trgWomen;
/

insert into tblWomen values ('호호호', 20, 160, 50, null);

select * from tblWomen;

-- 상관 관계
-- 1. :new
-- 2. :old

create or replace trigger trgWomen
    after
    insert
    on tblWomen
    for each row
begin
    dbms_output.put_line(':old > ' || :old.name);
    dbms_output.put_line(':new > ' || :new.name); --:new > 테스트
    dbms_output.put_line(' ');
end trgWomen;
/

create or replace trigger trgWomen
    after
    update
    on tblWomen
    for each row
begin
    dbms_output.put_line(':old > ' || :old.weight); --:old > 60 
    dbms_output.put_line(':new > ' || :new.weight); --:new > 65
    dbms_output.put_line(' ');
end trgWomen;
/

create or replace trigger trgWomen
    after
    delete
    on tblWomen
    for each row
begin
    dbms_output.put_line(':old > ' || :old.name);  --:old > 테스트 
    dbms_output.put_line(':new > ' || :new.name);  --:new
    dbms_output.put_line(' ');
end trgWomen;
/

insert into tblwomen values ('테스트',22,175,60,null);
update tblwomen set weight = 65 where name = '테스트';
delete from tblwomen where name = '테스트';

select * from tblwomen;

rollback;




-- 퇴사 > 위임
select * from tblstaff;
select * from tblproject;

-- '이순신' 퇴사
create or replace trigger trgRemoveStaff
    before          --3. 퇴사 직전에
    delete          --2. 퇴사를 하면
    on tblstaff     --1. 직원 테이블을 감시
    for each row    --4. 담당 프로젝트 위임한다.
declare
    vdseq number;
begin
    --5. 퇴사전에 담당 프로젝트를 다른 사람에게 위임한다. > 현재 맡고있는 프로젝트 수가 가장 적은 직원에게
    --select mim(count(*)) from tblproject group by staff_seq;
    
--    select seq into vdseq from (select
--                            s.seq
--                        from tblStaff s
--                            left outer join tblProject p
--                                on s.seq = p.staff_seq
--                                    having count(p.seq) = (select
--                                                                min(count(p.seq))
--                                                            from tblStaff s
--                                                                left outer join tblProject p
--                                                                    on s.seq = p.staff_seq
                                                                        group by s.seq)
                                        group by s.seq)
                                            where rownum = 1;
                
     
    update tblproject set
        staff_seq = vdseq
            where staff_seq = :old.seq;
    —select * from tblproject; — 1, 4(1), 5
    —select * from tblstaff; — 1, 2(0), 3(0), 4, 5
    
end trgRemoveStaff;

delete from tblstaff where seq = 5;

---------------------------------------------------------2023-03-30
-- 테이블 생성
create table tblUser (
    id varchar2(30) primary key,
    point number default 1000 not null
);

insert into tblUser values ('hong', default);

create table tblBoard (
    seq number primary key,
    subject varchar2(1000) not null,
    id varchar2(30) not null references tblUser(id)
);

create sequence seqBoard;

-- 회원 > 글쓰기 > +100
-- 회원 > 글삭제 > -50

-- A. 글을 쓴다(삭제한다) > insert
-- B. 포인트를 누적시킨다.

-- Case 1. ANSI-SQL
-- 절차 > 개발자 직접 제어 

-- 1.1 글쓰기
insert into tblBoard values (seqBoard.nextVal, '게시판입니다.', 'hong');

-- 1.2 포인트 누적하기
update tblUser set point = point + 100 where id = 'hong';

-- 1.3 글 삭제
delete from tblBoard where seq = 3;

-- 1.4 포인트 누적하기
update tblUser set point = point -50 where id = 'hong';

select * from tblBoard;
select * from tblUser;

-- Case 2. Procedure
create or replace procedure procAddBoard (
    psubject varchar2,
    pid varchar2
)
is
begin

    -- 2.1 글쓰기
    insert into tblBoard values (seqBoard.nextVal, psubject, pid);

    -- 2.1 포인트 누적하기
    update tblUser set point = point + 100 where id = pid;

    commit;
    
exception
    when others then
        rollback;
        
end procAddBoard;

create or replace procedure procRemoveBoard(
    pseq number
)
is
    vid varchar2(30);
begin
    
    -- 삭제글을 작성한 id   
    select id into vid from tblBoard where seq = pseq;
    
    -- 2.3 글 삭제
    delete from tblBoard where seq = pseq;
    
    -- 2.4 포인트 누적하기
    update tblUser set point = point -50 where id = vid;
    
    commit;

exception
    when others then
        rollback;

end procRemoveBoard;
/
begin
    --procAddBoard('다시 글을 작성합니다.', 'hong');
    procRemoveBoard(2);
end;
/
select * from tblBoard;
select * from tblUser;

-- Case 3. Trigger
-- 글쓰기, 글삭제 > 트리거 호출(포인트 누적)
create or replace trigger trgBoard
    after
    insert or delete
    on tblBoard
    for each row
begin
    
    if inserting then
        update tblUser set point = point + 100 where id = :new.id;
    elsif deleting then
        update tblUser set point = point - 50 where id = :old.id;
    end if;
    
end;
/
select * from tblBoard;
select * from tblUser;

-- 프로시저 vs 트리거
-- 프로시저 : 모든 작업을 명시적으로 직접 관리
-- 트리거 : 메인작업 명시적 + 보조작업 암시적

/*

    커서를 반환하는 프로시저 > 결과셋을 반환(테이블을 통째로 반환)
    - out > cursor (O)
    - return > cursor(X)
    

*/
set serveroutput on;

create or replace procedure procBuseo (
    pbuseo varchar2
)
is
    cursor vcursor is 
        select * from tblInsa where buseo = pbuseo;
        
    vrow tblInsa%rowtype;
        
begin

    -- 1. loop + cursor
    open vcursor;
    
    loop
    
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name);
    
    end loop;
    
    close vcursor;

end procBuseo;

create or replace procedure procBuseo (
    pbuseo varchar2
)
is
    cursor vcursor is 
        select * from tblInsa where buseo = pbuseo;
        
begin

    -- 2. for loop + cursor
    for vrow in vcursor loop
        dbms_output.put_line(vrow.name);
    end loop;

end procBuseo;

begin
    procBuseo('개발부');
end;

create or replace procedure procBuseo (
    pbuseo in varchar2,
    pcursor out sys_refcursor -- 커서를 반환값으로 사용할 때 쓰는 자료형
)
is
    -- cursor vcursor is select ...
begin
    open pcursor
    for
    select * from tblInsa where buseo = pbuseo;
    
end procBuseo;
/

declare
    vcursor sys_refcursor; -- 커서 참조 변수(out)
    vrow tblInsa%rowtype;
begin

    procBuseo('영업부', vcursor);
    
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name);
    end loop;
    
end;










