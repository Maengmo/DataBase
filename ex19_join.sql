/*

    ex19_join.sql
    
    관계형 데이터베이스 시스템(RDBMS, Oracle)이 지양하는 것들…
    
        1. 테이블에 기본키가 없는 상태 > 데이터 조작 곤란
        2. null이 많은 상태의 테이블 > 데이터 조작 곤란 + 공간 낭비
        3. 데이터가 중복되는 상태 > 데이터 조작 곤란 + 공간 낭비
        4. 하나의 속성값이 원자값이 아닌 상태

*/

-- 1. 테이블에 기본키가 없는 상태 > 데이터 조작 곤란
create table tbltest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null
);

insert into tblTest (name, age, address) values ('홍길동', 20, '서울시');
insert into tblTest (name, age, address) values ('아무개', 25, '인천시');
insert into tblTest (name, age, address) values ('호호호', 27, '부산시');

-- 3. 데이터가 중복되는 상태 > 데이터 조작 곤란 + 공간 낭비
insert into tblTest (name, age, address) values ('홍길동', 20, '서울시'); -- 중복된 값이 들어감

-- 홍길동이 강릉으로 이사.
update tbltest set address = '강릉시' where name = '홍길동';

drop table tbltest;

-- 2. null이 많은 상태의 테이블 > 데이터 조작 곤란 + 공간 낭비
create table tbltest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null,
    hobby varchar2(300) null
);

insert into tblTest (name, age, address, hobby) values ('홍길동', 20, '서울시', '독서');
insert into tblTest (name, age, address, hobby) values ('아무개', 25, '인천시', 'null');
insert into tblTest (name, age, address, hobby) values ('호호호', 27, '부산시', '맛집,여행,운동,낮잠');
insert into tblTest (name, age, address, hobby) values ('후후후', 29, '부산시', '운동유튜브보기');

select * from tblTest;

-- 독서가 취미인 사람?
select * from tbltest where hobby = '독서';

-- 운동이 취미?
select * from tbltest where hobby = '운동';
select * from tbltest where hobby like '%운동%';

-- 운동 > 신체단련
-- 맛집, 여행, 운동, 낮잠 > 맛집, 여행, 신체단련, 낮잠
update tblTest set hobby = '신체단련' where ?;

----------- 2번 문제-----------------------------
drop table tblTest;

create table tbltest (
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(300) not null,
    hobby1 varchar2(300) null,
    hobby2 varchar2(300) null,
    hobby3 varchar2(300) null
    ..
    hobby8 varchar2(300) null
);

-- 홍길동, 20, 서울시, 독서, null, null, null, null, null, null, null
-- 아무개, 25, 인천시, null, null, null, null, null, null, null, null
-- 호호호, 27, 부산시, 운동, 맛집, 낮잠, null, null, null, null, null
-- 후후후, 29, 서울시, 취미 8개를 적음.

-- 취미가 운동?
select * from tblTest where hobby1 = '운동' or hobby2 = '운동' .... -- 지속적으로 계속 or 해줘야하는 문제가 있음..


-- 직원 정보
-- 직원(번호(pk), 이름, 급여, 거주지, 담당프로젝트)
create table tblStaff (
    seq number primary key,         -- 번호(pk)
    name varchar2(30) not null,      -- 이름
    salary number not null,            -- 급여
    address varchar2(300) not null,  -- 거주지
    project varchar2(300) null         -- 담당 프로젝트
);

insert into tblStaff (seq, name, salary, address, project)
        values (1, '홍길동', 300, '서울시', '홍콩 수출');
        
insert into tblStaff (seq, name, salary, address, project)
        values (2, '아무개', 250, '인천시', 'TV 광고');
        
insert into tblStaff (seq, name, salary, address, project)
        values (3, '하하하', 350, '부산시', '매출 분석');
        
select * from tblStaff;

-- 직원 + 담당프로젝트
-- 1명의 직원 > 여러개의 프로젝트 담당 가능

-- 방법 1 : insert로 하나의 레코드를 더 추가
-- '홍길동'에게 담당 프로젝트 1건 추가 > '고객관리'
insert into tblStaff (seq, name, salary, address, project)
        values (4, '홍길동', 300, '서울시', '고객관리' );
        
-- 방법 2 : update로 project 컬럼에 하나의 데이터를 더 추가
-- '아무개' 에게 담당 프로젝트 1건 추가 > '게시판 관리'
update tblStaff set project = project || ', 게시판 관리' where name = '아무개';

drop table tblStaff;

-- 방법 해결안 --------------------------------------------------
create table tblStaff (
    seq number primary key,         -- 번호(pk)
    name varchar2(30) not null,      -- 이름
    salary number not null,            -- 급여
    address varchar2(300) not null  -- 거주지
);

create table tblProject (
    seq number primary key,               -- 번호(pk)
    project varchar2(300) not null,         -- 담당 프로젝트
    staff_seq number not null               -- 직원번호
);

insert into tblStaff (seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff (seq, name, salary, address) values (2, '아무개', 250, '인천시');
insert into tblStaff (seq, name, salary, address) values (3, '하하하', 350, '부산시');

insert into tblProject (seq, project, staff_seq) values (1, '홍콩 수출', 1);            -- 홍길동
insert into tblProject (seq, project, staff_seq) values (2, 'TV 광고', 2);               -- 아무개
insert into tblProject (seq, project, staff_seq) values (3, '매출 분석', 3);            -- 하하하
insert into tblProject (seq, project, staff_seq) values (4, '노조 협상', 1);            -- 홍길동
insert into tblProject (seq, project, staff_seq) values (5, '대리점 분양', 2);         -- 아무개

-- 원자 값 보장 & 중복 발생 X > 정규화
select * from tblStaff;
select * from tblProject;

-- 상황 A. 신입 사원 입사 > 신규 프로젝트 담당
-- A.1 신입 사원 추가(O)
insert into tblStaff (seq, name, salary, address) values (4, '호호호', 250, '일산시');

-- A.2 신규 프로젝트 추가 + 담당 지정
insert into tblProject (seq, project, staff_seq) values (6, '자재 매입', 4);

-- A.3 신규 프로젝트 추가 > 문제 발생 > 존재 하지 않는 직원 번호를 사용!
insert into tblProject (seq, project, staff_seq) values (7, '고객 유치', 5);

-- 사장 > '고객 유치' 담당자를 불러오라고 명령
-- 프로젝트는 진행 중인데, 5번 직원이라는 직원이 없음... 심각한 문제
select * from tblStaff 
    where seq = (select staff_seq from tblProject where project = '고객 유치');

select * from tblStaff;
select * from tblProject;

-- 상황 B. '홍길동' 퇴사
-- B.1 '홍길동' 정보 삭제 > 문제 발생
delete from tblstaff where seq = 1;

-- 사장 > '홍콩 수출' > 담당자 불러오라고 명령
-- 홍길동 퇴사로 인해, 해당 담당 직원이 없음..
select * from tblStaff 
    where seq = (select staff_seq from tblProject where project = '홍콩 수출');

-- B.2 정상 시나리오 : '아무개' 퇴사 > 인수 인계(위임) > '하하하' 
update tblProject set staff_seq = 3 where staff_seq = 2;

update tblProject set staff_seq = (select seq from tblStaff where name = '하하하') where staff_seq = (select seq from tblstaff where name ='아무개');

-- B.3 '아무개' 퇴사
delete from tblStaff where seq = 2;

-- 사장 > ' TV광고'  > 담당자 불러오라고 명령
select * from tblStaff 
    where seq = (select staff_seq from tblProject where project = 'TV 광고');

--- 최종 해결안 ------------------------------------------------------
drop table tblstaff;
drop table tblProject;

-- 부모 테이블(기본 테이블)
create table tblStaff (
    seq number primary key,         -- 번호(pk)
    name varchar2(30) not null,      -- 이름
    salary number not null,            -- 급여
    address varchar2(300) not null  -- 거주지
);

-- 자식 테이블(참조 테이블)
create table tblProject (
    seq number primary key,               -- 번호(pk)
    project varchar2(300) not null,         -- 담당 프로젝트
    staff_seq number not null references tblStaff(seq)   -- 직원번호(참조키(외래키), FK) : tblstaff의 키를 참조한다. 
);

insert into tblStaff (seq, name, salary, address) values (1, '홍길동', 300, '서울시');
insert into tblStaff (seq, name, salary, address) values (2, '아무개', 250, '인천시');
insert into tblStaff (seq, name, salary, address) values (3, '하하하', 350, '부산시');

insert into tblProject (seq, project, staff_seq) values (1, '홍콩 수출', 1);            -- 홍길동
insert into tblProject (seq, project, staff_seq) values (2, 'TV 광고', 2);               -- 아무개
insert into tblProject (seq, project, staff_seq) values (3, '매출 분석', 3);            -- 하하하
insert into tblProject (seq, project, staff_seq) values (4, '노조 협상', 1);            -- 홍길동
insert into tblProject (seq, project, staff_seq) values (5, '대리점 분양', 2);         -- 아무개

select * from tblStaff;
select * from tblProject;

-- 상황 A. 신입 사원 입사 > 신규 프로젝트 담당
-- A.1 신입 사원 추가(O)
insert into tblStaff (seq, name, salary, address) values (4, '호호호', 250, '일산시');

-- A.2 신규 프로젝트 추가 + 담당 지정
insert into tblProject (seq, project, staff_seq) values (6, '자재 매입', 4);

-- A.3 신규 프로젝트 추가 > 문제 발생 > 존재 하지 않는 직원 번호를 사용!
-- ORA-02291: integrity constraint (HR.SYS_C007148) violated - parent key not found
insert into tblProject (seq, project, staff_seq) values (7, '고객 유치', 5);

-- 상황 B. '홍길동' 퇴사
-- B.1 '홍길동' 정보 삭제 > 문제 발생
-- ORA-02292: integrity constraint (HR.SYS_C007148) violated - child record found
delete from tblstaff where seq = 1;

-- B.2 정상 시나리오 : '아무개' 퇴사 > 인수 인계(위임) > '하하하' 
update tblProject set staff_seq = 3 where staff_seq = 2;

update tblProject set staff_seq = (select seq from tblStaff where name = '하하하') where staff_seq = (select seq from tblstaff where name ='아무개');

-- B.3 '아무개' 퇴사
delete from tblStaff where seq = 2;

----------------------------------------------------------------------------------------------------------------------------
-- 두 (테이블) 데이터 비교 > 먼저 존재해야할 성격의 데이터 > 부모 테이블

-- 고객 테이블 > 부모 테이블
create table tblCustomer (
    seq number primary key,     -- 고객번호(PK)
    name varchar2(30) not null,     -- 고객명
    tel varchar2(15) not null,          -- 연락처
    address varchar2(100) not null  -- 주소
);

-- 판매내역 테이블 > 자식 테이블
create table tblSales (
    seq number primary key,                                  -- 판매번호(PK) 
    item varchar2(50) not null,                                 -- 상품명
    qty number not null,                                        -- 수량
    regdate date default sysdate not null,                  -- 판매날짜
    cseq number not null references tblCustomer(seq) -- 고객번호(FK)
);
-------------------------------------비디오 판매 관련 테이블--------------------------------
-- 장르 테이블
create table tblGenre (
    seq number primary key,            -- 장르번호(PK)
    name varchar2(30) not null,         -- 장르명
    price number not null,               -- 대여가격
    period number not null              -- 대여기간(일)
);

-- 비디오 테이블
create table tblVideo (
    seq number primary key,                         --비디오 번호(PK)
    name varchar2(100) not null,                    --비디오 제목
    qty number not null,                            --보유 수량
    company varchar2(50) null,                      --제작사
    director varchar2(50) null,                     --감독
    major varchar2(50) null,                        --주연배우
    genre number not null references tblGenre(seq)  --장르 번호(FK)
);


-- 고객 테이블
create table tblMember (
    seq number primary key,                 -- 고객 번호(PK)
    name varchar2(30) not null,              -- 고객 명
    grade number(1) not null,                -- 고객 등급
    byear number(4) not null,                -- 생년
    tel varchar2(15) not null,                 -- 연락처
    address varchar2(300) null,              -- 주소
    money number not null                   -- 예치금
);

-- 대여 테이블
create table tblRent (
    seq number primary key,                                             -- 대여 번호(PK)
    member number not null references tblMember(seq),         -- 회원 번호(FK)
    video number not null references tblVideo(seq),                -- 비디오 번호(FK)
    rentdate date default sysdate not null,                            -- 대여날짜 
    retdate date null,                                                       -- 반납 날짜 
    remark varchar2(500) null                                            -- 비고
);

------- 데이터 삽입 ---------------

-- 고객 데이터
insert into tblcustomer (seq, name, tel, address)
      values (1, '홍길동', '010-1234-5678', '서울시');
insert into tblcustomer (seq, name, tel, address)
      values (2, '아무게', '010-3333-4444', '인천시');
insert into tblcustomer (seq, name, tel, address)
      values (3, '하하하', '010-5555-6666', '부산시');


-- 판매 데이터
insert into tblsales (seq, item, qty, cseq) values (1, '전화기', 1, 1);
insert into tblsales (seq, item, qty, cseq) values (2, '다이어리', 3, 2);
insert into tblsales (seq, item, qty, cseq) values (3, '노트', 10, 2);
insert into tblsales (seq, item, qty, cseq) values (4, '볼펜', 20, 3);
insert into tblsales (seq, item, qty, cseq) values (5, '지우개', 15, 3);
insert into tblsales (seq, item, qty, cseq) values (6, '마우스', 5, 1);
insert into tblsales (seq, item, qty, cseq) values (7, '키보드', 2, 3);
insert into tblsales (seq, item, qty, cseq) values (8, '모니터', 1, 2);
insert into tblsales (seq, item, qty, cseq) values (9, '선풍기', 2, 1);

commit;






-- 장르 데이터
INSERT INTO tblGenre VALUES (1, '액션',1500,2);
INSERT INTO tblGenre VALUES (2, '에로',1000,1);
INSERT INTO tblGenre VALUES (3, '어린이',1000,3);
INSERT INTO tblGenre VALUES (4, '코미디',2000,2);
INSERT INTO tblGenre VALUES (5, '멜로',2000,1);
INSERT INTO tblGenre VALUES (6, '기타',1800,2);




-- 비디오 데이터
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (1, '영구와 땡칠이',5,'영구필름','심영래','땡칠이',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (2, '어쭈구리',5,'에로 프로덕션','김감독','박에로',2);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (3, '털미네이터',3,'파라마운트','James','John',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (4, '육복성',3,'대만영화사','홍군보','생룡',4);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (5, '뽀뽀할까요',6,'뽀뽀사','박감독','최지후',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (6, '우정과 영혼',2,'파라마운트','James','Mike',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (7, '주라기 유원지',1,NULL,NULL,NULL,1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (8, '타이거 킹',4,'Walt','Kebin','Tiger',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (9, '텔미 에브리 딩',10,'영구필름','강감독','심으나',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (10, '동무',7,'부산필름','박감독','장동근',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (11, '공동경쟁구역',2,'뽀뽀사','박감독','이병흔',1);




-- 회원 데이터
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (1, '김유신',1,1970,'123-4567','12-3번지 301호',10000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (2, '강감찬',1,1978,'111-1111','777-2번지 101호',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (3, '유관순',1,1978,'222-2222','86-9번지',20000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (4, '이율곡',1,1982,'333-3333',NULL,15000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (5, '신숙주',1,1988,'444-4444','조선 APT 1012호',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (6, '안중근',1,1981,'555-5555','대한빌라 102호',1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (7, '윤봉길',1,1981,'666-6666','12-1번지',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (8, '이순신',1,1981,'777-7777',NULL,1500);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (9, '김부식',1,1981,'888-8888','73-6번지',-1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (10, '박지원',1,1981,'999-9999','조선 APT 902호',1200);



-- 대여 데이터

INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (1, 1,1,'2022-01-01',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (2, 2,2,'2022-02-02','2022-02-03');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (3, 3,3,'2022-02-03',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (4, 4,3,'2022-02-04','2022-02-08');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (5, 5,5,'2022-02-05',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (6, 1,2,'2022-02-10',NULL);

commit;

--- 데이터 확인-------------------------------
select * from tblCustomer;  -- 3명
select * from tblSales;  -- 9건

select * from tblGenre; --6개
select * from tblVideo; -- 11개
select * from tblMember; -- 10명
select * from tblRent; -- 6개

/*

    조인, join
    - (서로 관계를 맺은) 2개(1개) 이상의 테이블을 사용해서, 1개의 결과셋을 만드는 연산
    - 테이블 A + 테이블 B = 테이블 C 
    
    조인의 종류
    1. 단순 조인, Cross Join
    2. 내부 조인, Inner Join
    3. 외부 조인, Outer Join
    4. 셀프 조인, Self Join
    5. 전체 외부 조인, Full Outer Join
 */
 
 /*
    1. 단순 조인, Cross Join
        - 카티션곱, 데카르트곱
        - A 테이블 레코드 갯수 * B 테이블 레코드 갯수 = 결과셋 레코드 갯수
        - A 테이블 컬럼 갯수 + B 테이블 컬럼 갯수 = 결과셋 컬럼 갯수
        - 쓸모없다. > 가치 있는 행과 가치 없는 행이 뒤섞여 있어서...
        - 개발용, 테스트용 > 유효성과 상관없이 다량의 데이터를 만들 때...
    
        -  select 컬럼리스트 from 테이블 A cross join 테이블 B
*/

select * from tblCustomer; -- 3명
select * from tblSales; -- 9건

select * from tblCustomer cross join tblSales; -- ANSI-SQL 표준 표기 > 권장
select * from tblCustomer, tblSales;             -- Oracle 전용 표기

/*

    2. 내부 조인, Inner Join
    - 단순 조인에서 유효한 레코드만 추출하는 조인
    
    - select 컬럼리스트 from 테이블 A inner join 테이블 B on 테이블A.컬럼 = 테이블B.컬럼;     -- ANSI-SQL 표기법
    - select 컬럼리스트 from 테이블A, 테이블B where 테이블A.컬럼 = 테이블B.컬럼;      -- Oracle 표기법
    
    select
        컬럼리스트
    from 테이블 A
        inner join 테이블 B
            on 테이블A.pk컬럼 = 테이블B.pk컬럼;
    
*/
-- ex1) 고객 테이블과 주문 테이블의 inner 조인
select 
    name, item, tblCustomer.seq, tblSales.seq
from tblCustomer
    inner join tblSales 
        on tblCustomer.SEQ = tblSales.CSEQ;
        
select 
    name, item, c.seq, s.seq
from tblCustomer c
    inner join tblSales s 
        on c.SEQ = s.CSEQ;

-- ex2) 원래 아래 2개의 테이블은 1개의 테이블이었다.
select * from tblStaff;
select * from tblProject;

-- 원래 1개의 테이블 정보를 2개로 나눴다. > 가끔은 2개의 정보를 다시 1개로 합쳐서 봐야할 업무가 생긴다.
--> 조인
select 
    *
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;
        
-- 1. 직원 명단을 가져오시오.
select * from tblStaff;

--2. 진행중인 프로젝트 목록을 가져오시오.
select * from tblProject;

--3. 진행중인 프로젝트명(tblProject)와 해당 담당직원의 이름(tblStaff)을 가져오시오.
select 
    s.name, p.project
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;
        
-- 비디오 제목(tblVideo), 대여 가격(tblGenre)을 가져오시오.
select * from tblGenre;
select * from tblVideo;

select
    v.name,
    g.price
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre;
        
-- tblCustomer + tblSales
-- : 조인 or 서브쿼리

-- 고객명 + 상품명

-- 1. join
select
    c.name as "고객명",
    s.item as "상품명"
from tblCustomer c
    inner join tblSales s
        on c.seq = s.cseq;

-- 2. subquery
select
    item as "상품명",
    (select name from tblCustomer where seq = tblSales.cseq ) as "고객명"
from tblSales;

select * from tblGenre;
select * from tblVideo;
select * from tblRent;
    
select
    v.name as "비디오",
    r.rentdate as "언제",
    g.period as "대여기간",
    r.rentdate + g.period as "반납날짜"
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre              -- tblGenre <-> tblVideo
            inner join tblRent r
                on v.seq = r.video;       -- tblVideo <-> tblRent
        
select * from tblGenre;
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select 
    m.name as "누가?",
    v.name as "비디오",
    r.rentdate as "언제",
    g.price as "가격"
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on v.seq = r.video
                    inner join tblMember m
                        on m.seq = r.member;

-- 전혀 관계가 없는 테이블 두가지의 조인
select * from tblStaff; --직원 <-> tblProject
select * from tblSales; --판매 <-> tblCustomer

select
    *
from tblStaff s1
    inner join tblSales s2
        on s1.seq = s2.cseq;
    
-- hr > 7개
select * from employees;
select * from departments;
select * from locations;
select * from countries;
select * from regions;

select * from jobs;

-- 6개의 테이블을 Join
select 
    e.first_name || ' ' || e.last_name as "이름",
    d.department_name as "부서",
    l.city as "도시",
    c.country_name as "국가",
    r.region_name as "대륙",
    j.job_title as "직업"
from employees e
    inner join departments d
        on d.department_id = e.department_id
            inner join locations l
                on l.location_id = d.location_id
                    inner join countries c
                        on c.country_id = l.country_id
                            inner join regions r
                                on r.region_id = c.region_id
                                    inner join jobs j 
                                        on j.job_id = e.job_id;

-------------------------------------------------------------------------------
/*

     3. 외부 조인, Outer Join
    - 내부 조인 결과 + 결과셋에 포함되지 못한 부모 테이블의 나머지 레코드
    
    -- inner join 사용방법
    select
        컬럼리스트
    from 테이블 A
        inner join 테이블 A
            on 테이블A.컬럼 = 테이블B.컬럼;
    
    --outer join 사용방법
    select
        컬럼리스트
    from 테이블 A
        (left|right) outer  join 테이블 A
            on 테이블A.컬럼 = 테이블B.컬럼;

*/
select * from tblCustomer; --3명 > 4명
select * from tblSales; --9건

-- 신규 회원
insert into tblCustomer values (4, '호호호', '010-1234-4321', '서울시');

-- 한번이라도 구매한 이력이 있는 고객들의 정보와 구매 이력을 가져오시오.
select
    *
from tblCustomer c 
    inner join tblSales s
        on c.seq = s.cseq;

-- 구매이력과 상관없이 모든 고객들의 정보를 가져오되, 단 구매 이력이 있으면 그것도 같이 가져와라.
select
    *
from tblCustomer c 
    left outer join tblSales s
        on c.seq = s.cseq;

---------------------------------
select * from tblStaff;
select * from tblProject;

-- 직원 명단 + 담당 프로젝트
-- 1. inner join
-- : '아무개' 제외 > 담당 프로젝트가 없어서.. > 부모 레코드중 일부가 자식 테이블에 참조되지 않았기 때문에
select 
    *
from tblStaff s
    inner join tblProject p
        on s.seq = p.staff_seq;

-- 2. outer join
-- : 담당 프로젝트가 없는 직원들까지.. > 참조가 없는 부모레코드까지 가져오시오.
select 
    *
from tblStaff s
    left outer join tblProject p
        on s.seq = p.staff_seq;

-- tblVideo, tblRent
-- 대여가 한번이라도 된 비디오와 그 대여 내역을 가져오시오.
select
    *
from tblVideo v
    inner join tblRent r
        on v.seq = r.video;
        
-- 대여가 많았던 비디오 목록
select
    name, count(*)
from tblVideo v
    inner join tblRent r
        on v.seq = r.video
            group by name
                order by count(*) desc ; --대출 순위

-- outer join 사용 
select
    name, count(rentdate)
from tblVideo v
    left outer join tblRent r
        on v.seq = r.video
            group by name
                order by count(rentdate) desc ; --대출 순위
                
        
-- 대여와 상관없이 모든 비디오와 그 대여 내역을 가져오시오.
select
    *
from tblVideo v
    left outer join tblRent r
        on v.seq = r.video;

-- 한번도 대여되지 않은 목록
select
    *
from tblVideo v
    left outer join tblRent r
        on v.seq = r.video
            where rentdate is null; --악성 재고 : 아무도 한번도 안빌려간 비디오

-- tblMember, tblRent
-- 대여를 1회 이상 > 고객 정보 + 대여 정보
select
    *
from tblMember m
    inner join tblRent r
        on m.seq = r.member;

-- 악성고객 : 대여를 한번도 하지 않은 고객들
select
    *
from tblMember m
    left outer join tblRent r
        on m.seq = r.member
            where rentdate is null;

-- 요구사항 문제 모음 

-- tblStaff, tblProject. 현재 재직중인 모든 직원의 이름, 주소, 월급, 담당프로젝트명을 가져오시오.
select * from tblstaff;
select * from tblProject;
select 
    s.name, s.address, s.salary, p.project
from tblStaff s
    inner join tblProject p
        on s.seq = p.Staff_seq;
       
-- tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select
    m.name
from tblVideo v
    inner join tblRent r
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member
                    where v.name = '뽀뽀할까요';
    
    
-- tblStaff, tblProejct. 'TV 광고'을 담당한 직원의 월급은 얼마인가?
select * from tblStaff;
select * from tblProject;

select
    s.name,
    s.salary
from tblStaff s
    inner join tblProject p
        on s.seq = p.Staff_seq
            where p.project = 'TV 광고';
    
    
-- tblVideo, tblRent, tblMember. '털미네이터' 비디오를 한번이라도 빌려갔던 회원들의 이름은?
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select
    m.name
from tblVideo v
    inner join tblRent r
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member
                    where v.name = '털미네이터';               
-- tblStaff, tblProject. 서울시에 사는 직원을 제외한 나머지 직원들의 이름, 월급, 담당프로젝트명을 가져오시오.
select * from tblStaff;
select * from tblProject;

select
    s.name,
    s.salary,
    p.project
from tblStaff s
    inner join tblProject p
        on s.seq = p.Staff_seq
            where s.address <> '서울시';
        
-- tblCustomer, tblSales. 상품을 2개(단일상품) 이상 구매한 회원의 연락처, 이름, 구매상품명, 수량을 가져오시오.
select * from tblCustomer;
select * from tblSales;

select
    c.name,
    c.tel,
    s.item,
    s.qty
from tblCustomer c
    inner join tblSales s 
        on c.seq = s.cseq
            where s.qty >= 2;
                                
-- tblVideo, tblRent, tblGenre. 모든 비디오 제목, 보유수량, 대여가격을 가져오시오.
select * from tblVideo;
select * from tblRent;
select * from tblGenre;

select 
    v.name, v.qty, g.price
from tblVideo v
    inner join tblRent r
     on v.seq = r.video
        inner join tblGenre g
            on v.genre = g.seq;
                
-- tblVideo, tblRent, tblMember, tblGenre. 2022년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
select * from tblVideo;
select * from tblRent;
select * from tblGenre;
select * from tblMember;

select 
    m.name, v.name, r.rentdate, g.price
from tblVideo v
    inner join tblRent r
     on v.seq = r.video
        inner join tblGenre g
            on v.genre = g.seq
                inner join tblMember m
                    on m.seq = r.member
                    where rentdate like '22/02/%';
            
-- tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
select * from tblVideo;
select * from tblRent;
select * from tblMember;

select 
    m.name, v.name, r.rentdate
from tblVideo v
    inner join tblRent r
     on v.seq = r.video
        inner join tblMember m
            on m.seq = r.member
                where Retdate is null;
    
    
-- employees, departments. 사원들의 이름, 부서번호, 부서명을 가져오시오.
select * from employees;
select * from departments;

select 
    e.First_name || ' ' || e.last_name,
    e.department_id,
    d.department_name
from employees e
    inner join departments d
        on e.department_id = d.department_id;
        
        
-- employees, jobs. 사원들의 정보와 직업명을 가져오시오.
select * from employees;
select * from jobs;

select
    e.First_name || ' ' || e.last_name,
    j.job_title
from employees e
    inner join jobs j
        on e.JoB_id = j.job_id;
        
-- employees, jobs. 직무(job_id)별 최고급여(max_salary) 받는 사원 정보를 가져오시오.
select * from employees;
select * from jobs;

select 
    *
from employees
    where salary in ( select
                            max(salary)
                        from employees e
                            inner join jobs j
                                on e.JoB_id = j.job_id
                                    group by j.job_id);
                                        
select
    max(salary)
from employees e
    inner join jobs j
        on e.JoB_id = j.job_id
            group by j.job_id;
      

-- departments, locations. 모든 부서와 각 부서가 위치하고 있는 도시의 이름을 가져오시오.
select * from departments;
select * from locations;

select 
    d.department_name, l.city
from departments d
    inner join locations l
        on d.location_id = l.location_id;
        
        
-- locations, countries. location_id 가 2900인 도시가 속한 국가 이름을 가져오시오.
select * from locations;
select * from Countries;

select 
    c.country_name
from locations l
    inner join countries c
        on l.country_id = c.country_id
            where l.location_id = 2900;
            
            
-- employees. 급여를 12000 이상 받는 사원과 같은 부서에서 근무하는 사원들의 이름, 급여, 부서번호를 가져오시오.
select * from employees;
select * from departments;

select
    e.First_name || ' ' || e.last_name, e.salary, e.department_id 
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.department_id in ( select
                                                d.department_id--e.department_id
                                            from employees e
                                                inner join departments d
                                                    on e.department_id = d.department_id
                                                        where e.salary >= 12000
                                                            group by d.department_id);
    
select
    d.department_id--e.department_id
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.salary >= 12000
                group by d.department_id;
        
        
-- employees, departments. locations.  'Seattle'에서(LOC) 근무하는 사원의 이름, job id, 부서번호, 부서이름을 가져오시오.
select * from employees;
select * from departments;
select * from locations;

select 
    e.First_name || ' ' || e.last_name, e.job_id, e.department_id, d.department_name
from employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on d.location_id = l.location_id
                    where l.city = 'Seattle';
    
    
-- employees, departments. first_name이 'Jonathon'인 직원과 같은 부서에 근무하는 직원들 정보를 가져오시오.
select * from employees;
select * from departments;

select 
    *
from employees
    where department_id = (select
                                        d.department_id
                                    from employees e
                                        inner join departments d
                                            on e.department_id = d.department_id
                                                where e.first_name = 'Jonathon' );
select
    d.department_id
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.first_name = 'Jonathon';
    
-- employees, departments. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을 출력하는데 월급이 3000이상인 사원을 가져오시오.

select
     e.First_name || ' ' || e.last_name, d.department_name, e.salary
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where e.salary >= 3000;           
            
-- employees, departments. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름, 월급을 가져오시오.
select
     d.department_id, d.department_name, e.First_name || ' ' || e.last_name, e.salary
from employees e
    inner join departments d
        on e.department_id = d.department_id
            where d.department_id = 10;           
            
            
            
-- departments, job_history. 퇴사한 사원의 입사일, 퇴사일, 근무했던 부서 이름을 가져오시오.
select * from departments;
select * from job_history;

select
    j.start_date, j.end_date, d.department_name
from departments d
    inner join job_history j
        on d.department_id = j.department_id;
        
        
-- employees. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호', '사원이름', '관리자번호', '관리자이름'으로 하여 가져오시오.
select * from employees;

select
    e1.employee_id as "사원번호",
    e1.first_name || e1.last_name as "사원이름",
    e2.manager_id as "관리자번호",
    e2.first_name || e2.last_name as "관리자이름"
from employees e1
    inner join employees e2
        on e1.employee_id = e2.manager_id;
       
-- employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 년도를 기준으로 오름차순 정렬.
select * from employees;
select * from jobs;

select 
    e.hire_date as "입사년도",
    avg(salary) as "입사년도별 평균급여"
from employees e
    inner join  jobs j
        on e.job_id = j.job_id
            where job_title = 'Sales Manager'
                group by e.hire_Date
                    order by e.hire_date asc;


-- employees, departments. locations. 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 사원수를 가져오시오. 단, 도시에 근 무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.
select * from employees;
select * from departments;
select * from locations;

select
    l.city as "도시명",
    max(salary) as "평균연봉",
    count(*) as "사원수"
from employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on d.location_id = l.location_id
                    group by city
                        having count(*) > 10
                            order by max(salary) asc;

            
            
-- employees, jobs, job_history. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 가져오시오. 현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 말것.
select * from employees;
select * from jobs;
select * from job_history;

select
    job_id
from jobs
    where job_title = 'Public Accountant';
    
select
    *
from employees e
    inner join jobs j
        on e.job_id = j.job_id
            inner join job_history j2
                on e.employee_id = j2.employee_id
                    where j2.job_id = ( select
                                                job_id
                                            from jobs
                                                where job_title = 'Public Accountant');
    
    
-- employees, departments, locations. 커미션을 받는 모든 사람들의 first_name, last_name, 부서명, 지역 id, 도시명을 가져오시오.
select * from employees;
select * from departments;
select * from locations;

select
    e.first_name,
    e.last_name,
    d.department_name,
    l.location_id,
    l.city
from employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on d.location_id = l.location_id
                    where e.commission_PCT is not null;
    
    
-- employees. 자신의 매니저보다 먼저 고용된 사원들의 first_name, last_name, 고용일을 가져오시오.
select * from employees;

select
    e1.first_name,
    e1.last_name,
    e2.first_name,
    e2.last_name,
    e2.hire_date
from employees e1
    inner join employees e2
        on e1.employee_id = e2.manager_id
            where e2.hire_Date < e1.hire_date;


/*

    4. 셀프 조인, Self Join
    - 1개의 테이블을 사용하는 조인
    - 테이블이 스스로 자신과 관계를 맺는 경우

*/
-- 직원 테이블
create table tblSelf (
    seq number primary key,             -- 직원번호(PK)
    name varchar2(30) not null,          -- 직원명
    department varchar2(50) null,       -- 부서명
    super number null references tblSelf(seq) --상사번호(FK)
);

insert into tblSelf values (1, '홍사장', null, null);
insert into tblSelf values (2, '김부장', '영업부', 1);
insert into tblSelf values (3, '이과장', '영업부', 2);
insert into tblSelf values (4, '정대리', '영업부', 3);
insert into tblSelf values (5, '최사원', '영업부', 4);
insert into tblSelf values (6, '박부장', '개발부', 1);
insert into tblSelf values (7, '하과장', '개발부', 6);

select * from tblSelf;

-- 직원 명단을 가져오시오. 상사명도 같이 가져오시오.
select
    b.name as "직원명",
    a.name as "상사명"
from tblSelf a  -- 상사
    inner join tblSelf b --직원
        on a.seq = b.super;

select
    b.name as "직원명",
    a.name as "상사명"
from tblSelf a  -- 상사
    right outer join tblSelf b --직원
        on a.seq = b.super;

select
    a.*,
    (select name from tblSelf where seq = a.super) as "상사명"
from tblSelf a; -- 직원

/*

    5. 전체 외부 조인, Full Outer Join
    - 서로 참조하고 있는 관계에서 사용 

*/

select * from tblMen;
select * from tblWomen;

-- 커플(남자명 + 여자명)
select 
    w.name as "여자",
    m.name as "남자"
from tblMen m
    inner join tblWomen w
        on m.name = w.couple;
        
-- 커플(남자명+여자명) + 솔로(남자)
select
    m.name as "남자",
    w.name as "여자"
from tblMen m
    left outer join tblWomen w
        on m.couple = w.name;

-- 커플(남자명+여자명) + 솔로(여자)
select
    w.name as "여자",
    m.name as "남자"
from tblMen m
    right outer join tblWomen w
        on m.couple = w.name;

-- 커플(남자명+여자명) + 솔로(여자) + 솔로(남자) 
select
    w.name as "여자",
    m.name as "남자"
from tblMen m
    full outer join tblWomen w
        on m.couple = w.name;





