

-- 단일 라인 주석

/*

    다중라인 주석

*/

select * from tabs;

/*

        system 접속
        
        일반 계정 접속
        1. 관리자가 생성
        2. 이미 생성되어 있는 일반 계정 > 교육용(테스트용) > scott, hr
        
        hr 계정
        - 일반 계정
        - 테스트용 샘플 데이터 제공
        - 설치 직후 > 잠겨있는 상태 > 잠금 해제
        - 설치 직후 > 암호 변경
        
*/

alter user hr account unlock;  --계정 풀기 
alter user hr account lock;     --계정 잠그기

alter user hr identified by java1234; --암호 변경하기

-- 현재 계정이 보유하고 있는 테이블 목록 가져오기
select * from tabs;

-- 현재 작성중인 스크립트 파일(*.sql)
-- *** 스크립트 파일은 계정에 비종속적이다.
-- 스크립트 파일은 계정에 독립적이다.
-- *** 스크립트의 내용을 실행할 당시의 접속 상태가 누구인지 중요하다.

select * from REGIONS;           -- 부서 지역 국가 대륙 정보
select * from COUNTRIES;        -- 부서 지역 국가 정보
select * from LOCATIONS;        -- 부서 지역 정보
select * from DEPARTMENTS;    -- 부서 정보
select * from JOBS;                 -- 직원 직업 정보
select * from EMPLOYEES;        -- 직원 정보
select * from JOB_HISTORY;      -- 직원 이직 이력 정보

/*

    오라클
    - 데이터베이스 + 데이터베이스 관리시스템
    
    SQL
    - Structured Query Language
    - 구조화된 질의 언어
    - 대화형 언어
    - 오라클 데이터베이스 <-> (SQL) <-> 클라이언트(개발자)
 
    오라클(SQL + 많은 기능) 누가 공부 ?
    
    1. 데이터베이스 관리자
        - DBA 
        - 모든 기능 관리/조작
        
    2. 데이터베이스 개발자
        - DB 팀
        - 거의 대다수 기능 관리/조작
        
    3. 응용프로그램 개발자
        - 전부 or 일부 사용
        
    관계형 데이터베이스 종류
    1. Oracle
    2. MS-SQL
    3. MySQL
    4. MariaDB
    5. PostreSQL
    6. DB2
    7. SQLite
    
    클라이언트 프로그램
    1. SQL Developer > 따로 설치
    2. SQL Plus > 오라클과 같이 설치(콘솔)
    3. DataGrip > 학교이메일 있으면 무료
    4. DBeaver
    5. SQLGate
    6. Toad
    
    관계형 데이터베이스
    - 데이터를 표형식으로 저장/관리한다.
    - SQL을 사용한다.
    
    SQL
    1. DBMS 제작사와 독립적이다.
        - 모든 관계형 데이터베이스에서 공통적으로 적용하기 위해 만들어진 언어
        - DBMS 제작사에서 SQL이란 언어를 자신의 제품에 적용
        
    2. 표준 SQL, ANSI-SQL
        - 모든 DBMS에 적용 가능한 SQL
        
    3. 각 제작사별 SQL
        - Oracle vs MS-SQL
        - 자기네 제품에서만 동작하는 추가 SQL 
        - Oracle > PL/SQL
        - MS-SQL > T-SQL
        
    오라클 수업 = ANSI-SQL(50~60%) + PL/SQL(20~30%) + 설계, 기타(10%)
    
    ANSI-SQL 종류
    1. DDL
        - Data Definition Language
        - 데이터 정의어
        - 테이블, 뷰, 사용자, 인덱스, 트리거 등의 데이터베이스 오브젝트
        - 생성/수정/삭제하는 명령어
        - 구조 생성/관리하는 명령어
        - EX) 건물 > 기초공사(벽, 바닥..) 
        a. create : 생성
        b. drop : 삭제
        c. alter : 수정
        - 데이터베이스 관리자
        - 데이터베이스 담당자
        - 프로그래머(일부)
        
    2. DML
        - Date Manipulation Language
        - 데이터 조작어
        - 데이터베이스에 데이터를 추가하거나, 수정, 삭제, 조회 하는 명령어(CRUD)
        - 사용 빈도가 가장 높음
        a. selecet : 조회(읽기)   > R *************제일 자주 사용*******************
        b. insert   : 추가(생성)   > C
        c. update  : 수정         > U
        d. delete  : 삭제          > D
        - 데이터베이스 관리자
        - 데이터베이스 담당자
        - 프로그래머(*****)
        
    3. DCL
        - Data Control Language
        - 데이터 제어어
        - 계정 권한 관리, 보안 제어, 트랜잭션 처리 등..
        a. commit
        b. rollback
        c. grant
        d. revoke
        - 데이터베이스 관리자
        - 데이터베이스 담당자
        - 프로그래머(일부)
        
    4. DQL
        - Data Query Language
        - DML 중에 Select 만 따로 호칭
        
    5. TCL
        - Tracnsaction Control Language
        - DCL 중에 commit, rollback 만 따로 호칭
        
    오라클 인코딩
    - 1.0 ~ 8i : EUR-KR
    - 9i, 10g, 11g, 12c, 18c, 19c, 21c ... : UTF-8
    
    오라클 제품군
    - Oracle Enterprise
    - Oracle Express Edition
    
    Oracle Express Edition
    - 무료
    - 개인용 or 소규모 회사
    - 사용 메모리 최대 1GB
    - 11g
    - 18c
    
    
    


*/
-- hr 계정으로 수업 진행

-- 대소문자
-- 1. SQL 명령어는 대소문자를 구분하지 않는다.
-- 파란색 > 키워드
-- 하얀색 > 식별자
-- ctrl + F7 하면 자동으로 대문자, 정렬
select * from tabs; -- 수업

SELECT * FROM TABS;

select * from TABS;

SELECT * FROM tabs; -- FM 

-- 모든 구문을 대문자로 작성하는것을 권장한다.

-- 코드 컨벤션

-- 식별자 > 30바이트 이내(30글자 이내)
create table aaa (
    num number
);

create table aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (
    num number
);

-- 31글자라 불가능
create table aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa (
    num number
);

select * from tabs;

-- ORA-00972 : identifier is too long
-- > identifier longer than 30 bytes was specified.



 
 





























