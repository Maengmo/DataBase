-- ex29_plsql.sql
/*

    PL/SQL
    - Oracle's Procedural Language Extension to SQL
    - ANSI-SQL 표준 SQL에 절차 지향 언어의 기능을 추가한 SQL
    - ANSI-SQL + 자바같은 프로그래밍 언어의 기능 = PL/SQL
    
    ANSI-SQL
    - 비절차 지향 언어
    - 순서가 없고 문장간의 행동이 서로 독립적이다.
    - 문장 단위 구조 
    
    프로시저, Procedure
    - 메소드, 함수 등...
    - 순서가 있는 명령어의 집합(ANSI-SQL + PL/SQL)의 집합
    
    1. 익명 프로시저
        - 1회용 코드 작성용
    
    2. 실명 프로시저
        - 저장(데이터베이스) > DB object
        - 재사용 가능
        - 계정간 공유 가능
    
    PL/SQL 프로시저 블럭 구조
    - 4개의 키워드(블럭)으로 구성
        a. declare
        b. begin
        c. exception
        d. end 
        
    a. declare
        - 선언부
        - 프로시저 내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능 
        
    b. begin
        - 실행부, 구현부
        - begin ~ end
        - begin(구현부 시작) ~ end(구현부 끝)
        - 생략 불가능
        - 핵심 파트
        - 구현 코드 > ANSI-SQL + PL/SQL
        
    c. exception
        - 예외처리부
        - catch 역할
        - 예외 처리 코드를 작성
        - 생략 가능
        
    d. end
        - begin 블럭의 종료 역할
        - 생략 불가능
    
    -- 양식     
    declare
        변수 선언
        객체 선언
    begin 
        구현할 코드(SQL)
    exception
        예외처리 코드
    end;
   
    -- 양식 생략 후
    begin 
        구현할 코드(SQL)
    end;
    
    PL/SQL 환경 > ANSI-SQL의 환경과 거의 동일하게 구현
    
    PL/SQL 자료형
    - ANSI-SQL과 거의 동일
    
    변수 선언하기
    - 변수명 자료형 [not null] [default 값];
    - 주로 질의(select)의 결과값을 저장하는 용도
    - 일반적인 데이터를 저장하는 용도
    
    PL/SQL 연산자
    - ANSI-SQL 거의 동일
    
    대입 연산자
    - ANSI-SQL
        ex) update table set column = 값;
    - PL/SQL 
        ex) 변수 := 값; 
    
    
    
*/

-- dbms_out_put_line 결과 > 안보이게 설정(기본값)
-- 접속할 때마다 다시 실행

set serveroutput on;
set serverout on;

set serveroutput off;
set serverout off;

-- 메소드 : 선언(저장) > 호출
-- 익명프로시저 : 호출
begin
    -- 자바의 System.out.println(); 과 같음
    dbms_output.put_line(100);
    dbms_output.put_line('홍길동');
end;

declare
    num number;
    name varchar2(30);
    today date;
begin
    num := 10;
    dbms_output.put_line(num);
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    dbms_output.put_line(today);
end;

declare
    num1 number;
    num2 number;
    num3 number := 30; --int num3 = 30;
    num4 number default 40;
    num5 number not null := 50; --PLS-00218: a variable declared NOT NULL must have an initialization assignment -> 기본값을 초기화를 꼭 해줘야함
    num6 number not null default 0;
begin
    
    num1 := 10;
    dbms_output.put_line(num1);
    
    dbms_output.put_line('---');
    dbms_output.put_line(num2); --null
    dbms_output.put_line('---');
    
    dbms_output.put_line(num3);
    
    -- num4 := 400;
    dbms_output.put_line(num4);
    
    
    --num5 := 50;
    dbms_output.put_line(num5);
    
end;

-- select into 절
-- : PL/SQL의 변수에 ANSI-SQL의 결과값을 저장하는 구문

declare

    vname varchar2(30);
    buseo varchar2(30);

begin

    -- vname := select name from tblInsa where num = 1001;
    
    -- PLS-00428: an INTO clause is expected in this SELECT statement
    -- ***** PL/SQL 블럭안에서는 ANSI-SQL의 select문을 사용할 수 없다. > Select into 사용 
    -- ***** PL/SQL 블럭안에서는 select문을 제외한 ANSI-SQL은 그대로 사용 가능하다.(Insert,Update,delete)
    
    -- 대입 연산자 역할 
    -- select 컬럼 into 변수 
    select name into vname from tblInsa where num = 1001;
    dbms_output.put_line(vname);
    
    --      컬럼         변수
    select buseo into buseo from tblInsa where num = 1001;
    dbms_output.put_line(buseo);
    
end;

-- 회사 > 프로젝트 > 직원 중
create table tblTeam (
    num number primary key,
    name varchar2(15) not null,
    buseo varchar2(15) not null,
    jikwi varchar2(15) not null
);

-- 개발부 + 부장
-- 1. ANSI-SQL
-- 2. PL/SQL

-- 1.1 노가다 > 비추천 
select * from tblInsa where buseo = '개발부' and jikwi = '부장';
insert into tblTeam values (1003, '이순애', '개발부', '부장');

-- 1.2 서브쿼리
insert into tblTeam values ((select num from tblInsa where buseo = '개발부' and jikwi = '부장'), 
                                  (select name from tblInsa where buseo = '개발부' and jikwi = '부장'), 
                                  '개발부', '부장');
-- 2. PL/SQL 사용
declare
    vnum number;
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
begin
    
    -- ***** Select의 결과는 반드시 PL/SQL에 넣어야 한다. > select into 사용
    select num into vnum from tblInsa where buseo = '개발부' and jikwi = '부장';
    select name into vname from tblInsa where buseo = '개발부' and jikwi = '부장';
    select buseo into vbuseo from tblInsa where buseo = '개발부' and jikwi = '부장';
    select jikwi into vjikwi from tblInsa where buseo = '개발부' and jikwi = '부장';
    
    -- vnum, vname, vbuseo, vjikwi 확보
    insert into tblTeam values (vnum, vname, vbuseo, vjikwi);
    
end;

-- 결과 확인 및 roll-back
rollback;

select * from tblTeam;

-- select into > select 결과 1개 값 > PL/SQL 변수 1개에 대입 > 1:1

desc tblInsa;

declare
    -- select 값을 저장할 변수 > 해당 컬럼의 자료형 + 길이 > 미리 숙지!!!
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
begin
    
    -- into 주의점
    -- 1. 컬럼의 개수와 변수의 개수의 동일!!
    -- 값을 동일 하게 넣지 않으면 , 해당 에러 발생 : PL/SQL: ORA-00947: not enough values
    -- 컬럼 갯수를 동일하게 넣지 않으면, 해당 에러 발생 : PL/SQL: ORA-00913: too many values
    -- 2. 컬럼의 순서와 변수의 순서가 일치!!
    -- 3. 컬럼과 변수의 자료형이 일치!!
    select name, buseo, jikwi into vname, vbuseo, vjikwi from tblInsa where num = 1001;
    
     dbms_output.put_line(vname);
     dbms_output.put_line(vbuseo);
     dbms_output.put_line(vjikwi);
     
end;

select * from tblTeam;

/*

    타입 참조
    - 변수를 선언할 때 같이 사용
    
    1. %type
        - 컬럼 1개 참조 
        - 사용하는 테이블의 특정 컬럼의 스키마를 알아내서 변수에 적용
        - 복사되는 정보
            a. 자료형
            b. 길이
    
    2. %rowtype
        - 레코드 전체 참조(모든 컬럼 참조)
        - 와일드 카드의 성질

*/
declare
    vname tblInsa.name%type;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
begin
    select name, buseo, jikwi into vname, vbuseo, vjikwi from tblInsa where num = 1002;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
end;

select * from tblTeam;

-- 특정 직원에게 보너스 지급 > 내역 저장
-- 보너스 = basicpay * 1.5

create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num),
    bonus number not null
);

create sequence seqBonus;

-- 1.
select * from tblInsa where buseo ='총무부' and jikwi = '부장';
insert into tblBonus values (seqBonus.nextVal, 1046, 2650000*1.5);

-- 2.
insert into tblBonus values (seqBonus.nextVal, 
                                    (select num from tblInsa where buseo ='총무부' and jikwi = '부장'), 
                                    (select basicpay from tblInsa where buseo ='총무부' and jikwi = '부장') * 1.5);

select * from tblBonus;

-- 3.
declare
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
begin
    select num, basicpay into vnum, vbasicpay from tblInsa where buseo ='총무부' and jikwi = '부장';
    
    insert into tblBonus values (seqBonus.nextval, vnum, vbasicpay * 1.5);
    

    
end;

select * from tblBonus;


/*

    타입 참조
    - 변수를 선언할 때 같이 사용
    
    1. %type
        - 컬럼 1개 참조 
        - 사용하는 테이블의 특정 컬럼의 스키마를 알아내서 변수에 적용
        - 복사되는 정보
            a. 자료형
            b. 길이
    
    2. %rowtype
        - 레코드 전체 참조(모든 컬럼 참조)
        - 와일드 카드의 성질

*/

-- 굉장히 안좋은 예 (노가다)
-- 홍길동 > 모든 정보(컬럼 10개) 출력 > 프로시저
declare 
    vnum        tblInsa.num%type;
    vname       tblInsa.name%type;
    vbuseo      tblInsa.buseo%type;
    vjikwi         tblInsa.jikwi%type;
    vssn          tblInsa.ssn%type;
    vcity          tblInsa.city%type;
    vbasicpay    tblInsa.basicpay%type;
    vsudang      tblInsa.sudang%type;
    vibsadate     tblInsa.ibsadate%type;
    vtel            tblInsa.tel%type;

begin
    select num, name, buseo, jikwi, ssn, city, basicpay, sudang, ibsadate, tel
            into vnum, vname, vbuseo, vjikwi, vssn, vcity, vbasicpay, vsudang, vibsadate, vtel
        from tblInsa where name = '홍길동';
end;

-- 좋은 예
declare 
    vrow tblInsa%rowtype; --총 10개의 컬럼 참조
    vrow2 tblInsa%rowtype; --총 10개의 컬럼 참조
begin
    
    -- ex) 덜 좋은 예
    select 
        num, name, ssn, ibsadate, city, tel, buseo, jikwi, basicpay, sudang
        into vrow
    from tblInsa where name = '이순신';
    
    -- ex) 가장 좋은 예
    select 
        * into vrow2
    from tblInsa where name = '이순애';
    
    --dbms_output.put_line(vrow);
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow2.name);
    
end;

-- 1번째 방법 : 시스템적으로 낭비 없음.
declare
    vname       tblInsa.name%type;
    vbuseo      tblInsa.buseo%type;
    vjikwi         tblInsa.jikwi%type;
    vcity          tblInsa.city%type;
    vbasicpay    tblInsa.basicpay%type;
begin
    select 
        name, buseo, jikwi, city, basicpay 
        into 
        vname, vbuseo, vjikwi, vcity, vbasicpay  
        from tblInsa where name = '홍길동';
end;

-- 2번째 방법 : 내가 필요없는 나머지 방법들도 가져와짐
declare
    vrow tblInsa%rowtype;
begin
    select 
        * --name, buseo, jikwi, city, basicpay 
        into
        vrow
    from tblInsa where name = '홍길동';
end;


select * from tblMen;
select * from tblWomen;

-- '하하하' > 성전환 > tblWomen 이동
-- 1. tblMen > select > 정보
-- 2. tblWomen > insert(1번) > 복사
-- 3. tblMen > delete

declare
    vrow tblMen%rowtype;
begin
    --1.
    select * into vrow from tblMen where name = '하하하';
    
    --2. 
    insert into tblWomen values(vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);
    
    --3.
    delete from tblMen where name = '하하하';
    
end;

select * from tblMen;
select * from tblWomen;



-- 제어문
-- 1. 조건문
-- 2. 반복문

declare
    vnum number := 10;
begin
    
    if (vnum > 0) then 
        dbms_output.put_line('양수');
    end if;
    
end;

declare
    vnum number := -10;
begin
    
    if (vnum > 0) then 
        dbms_output.put_line('양수');
    elsif vnum < 0 then
        dbms_output.put_line('음수');
    else
        --dbms_output.put_line('양수 아님');
        null; -- 빈블럭 만들 때 사용
    end if;
    
end;

-- 특정 직원 선택 > 보너스 지급 > 간부(basicpay * 1.5), 대리,사원(baiscpay * 2)
declare
    vnum        tblInsa.num%type;
    vbasicpay   tblInsa.basicpay%type;
    vjikwi        tblInsa.jikwi%type;
    vbonus      number;
begin
    --1.
    select num, basicpay, jikwi into vnum, vbasicpay, vjikwi from tblInsa where name = '이순신';
    
    --2.
    if vjikwi = '부장' or vjikwi = '과장' then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('대리','사원') then
        vbonus := vbasicpay * 2;
    end if;
    
    --3.
    insert into tblBonus values (seqBonus.nextVal, vnum, vbonus);
    
end;

select 
    b.*,
    (select name from tblInsa where num = b.num) as name,
    (select jikwi from tblInsa where num = b.num) as jikwi,
    (select basicpay from tblInsa where num = b.num) as basicpay
from tblBonus b;

/*

    조건문
    1. if문
    2. case
        - ANSI-SQL과 동일

*/

declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin
    select continent into vcontinent from tblCountry where name = '대한민국';

    if vcontinent = 'AS' then
        vresult := '아시아';
    elsif vcontinent = 'EU' then
        vresult := '유럽';
    elsif vcontinent = 'AF' then
        vresult := '아프리카';
    else
        vresult := '기타';
    end if;
    
    dbms_output.put_line(vresult);
    
    case
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
    case vcontinent
        when 'AS' then vresult := '아시아';
        when 'EU' then vresult := '유럽';
        when 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
    dbms_output.put_line(vresult);
    
end;

-- '신숙주'가 대여한 비디오 제목?>
select * from tblMember;
select * from tblRent;
select * from tblVideo;

-- 1. 조인
-- 2. 서브쿼리
-- 3. 프로시저

declare
    mseq tblMember.seq%type;
    vseq tblVideo.seq%type;
    vname tblVideo.name%type;
    
begin
    select seq into mseq from tblMember where name = '신숙주';
    select video into vseq from tblRent where member = mseq;
    select name into vname from tblVideo where seq = vseq;
    dbms_output.put_line(vname);
end;

/*

    반복문
    
    1. loop
        - 단순 반복
        
    2. for loop
        - 횟수 반복(자바 for)
        - loop 기반
        
    3. while loop
        - 조건 반복(자바 while)
        - loop 기반
        
*/
declare
    vnum number := 1;
begin
    
    -- ORA-20000: ORU-10027: buffer overflow, limit of 1000000 bytes
    loop
        -- 실행문;
        dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss'));
        dbms_output.put_line(vnum);
        
        vnum := vnum+1;
        
        exit when vnum > 10; -- 조건 만족 > loop 탈출
        
    end loop;

end;

-- 더미 데이터 추가 x 1000 건
create table tblLoop (
    seq number primary key,
    data varchar2(30) not null
);

create sequence seqLoop;

insert into tblLoop values (seqLoop.nextVal, '데이터1');
insert into tblLoop values (seqLoop.nextVal, '데이터2');
insert into tblLoop values (seqLoop.nextVal, '데이터3');

declare
    vnum number := 4;
begin
    
    loop
        insert into tblLoop values (seqLoop.nextVal, '데이터' || vnum);
        vnum := vnum +1;
        
        exit when vnum > 1000;
        
    end loop;
    
end;

select * from tblLoop;
select count(*) from tblLoop;

begin
    
    for i in 1..10 loop
        
        dbms_output.put_line(i);
        
    end loop;

end;

create table tblGugudan (
    dan number,
    num number,
    result number not null,
    
    constraint tblgugudan_dan_num_pk primary key(dan,num)
);

begin
    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan (dan, num, result) values (dan, num, dan*num);
        end loop;
    end loop;

end;

select * from tblGugudan;

declare
    vnum number := 1;
begin
    while vnum <= 10 loop
    
        dbms_output.put_line(vnum);
        vnum := vnum +1;
    
    end loop;
end;

/*

    select > 결과셋 >  PL/SQL 변수에 대입
    
    1. select into
        - 결과셋의 레코드가 1개일때만 가능하다.
    
    2. cursor + loop
        - 결과셋의 레코드가 N개일때 사용한다.
        
    사용양식
    
    declare
        변수 선언;
        커서 선언;
    begin
        
        커서 열기;
            loop
                커서 사용 > 데이터 접근 > 조작        
            end loop;
        커서 닫기;
        
    end;

*/
-- ORA-01422: exact fetch returns more than requested number of rows
-- ORA-01403 : no data found
declare
    vname tblInsa.name%type;
begin
    select name into vname from tblInsa where name = '유재석';
    dbms_output.put_line(vname);
end;

create or replace view vwTest
as
select * from tblInsa;

-- cursor 선언은 view 선언과 비슷함.
declare
    cursor vcursor 
    is 
    select name from tblInsa;
    vname tblInsa.name%type;
begin
    open vcursor; -- select문 실행 > 결과셋에 커서 연결(참조) > 탐색 > 자바의 Iterator
        /*
        fetch vcursor into vname;   -- select into와 동일한 역할
        dbms_output.put_line(vname);
        
        fetch vcursor into vname;   -- select into와 동일한 역할
        dbms_output.put_line(vname);
        */
        
        /* 잘안씀.. 
        for i in 1..60 loop
             fetch vcursor into vname;
             dbms_output.put_line(vname);
        end loop;
        */
        
        loop
            fetch vcursor into vname;
            -- exit when 커서가 더이상 다음 레코드를 발견하지 못할때;
            exit when vcursor%notfound; --상태값(boolean)
            
            dbms_output.put_line(vname);
        end loop;
        
    close vcursor;
end;

-- *********** 가장 많이 사용
declare
    cursor vcursor is select name from tblInsa;
    vname tblInsa.name%type;
begin
    open vcursor; 
        
        loop
            fetch vcursor into vname;
            exit when vcursor%notfound; 
            dbms_output.put_line(vname);
        end loop;
        
    close vcursor;
    
end;

---------------------------------------------------
--null 처리 함수
--null value 함수
-- 1. nvl(컬럼, 대체값)
-- 2. nvl2(컬럼, 값A, 값B)

select nvl(name, '대체값') from tblInsa where num = 1101;

select name, nvl(tel, '대체값') from tblInsa;

select
    name,
    case
        when tel is not null then tel
        else '대체값'
    end
from tblInsa;

select name, nvl2(tel, '값A', '값B') from tblInsa;
-- null 이 아니면 값A, null 이면 값B

select
    name,
    case
        when tel is not null then '값A'
        else '값B'
    end
from tblInsa;



