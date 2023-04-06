/*

    ex32_account.sql
    
    사용자 관련 > DCL
    - 계정 생성, 삭제, 잠금 제어
    - 리소스 접근 권한 제어  
    
    현재 사용 계정
    - system(x)
    - hr(O)
    
    프로젝트 계정 생성

    계정 생성하기
    - 권한을 가지고 있는 계정만 가능하다. > 관리자급(sys, system)
    
    - create user 계정명 identified by 암호 > 계정 생성
    - alter user 계정명 indentified by 암호 > 암호 변경
    - drop user 계정명 > 계정 삭제
    
    *** 새로 생성된 계정은 아무 권한이 없다 > 접속할 권한도 없다.
    
    사용자에게 권한 부여하기
    - grant 권한명 to 유저명;
    
    사용자에게 권한 제거하기
    - revoke 권한명 from 유저명;
    
    권한 종류
    - create user
    - create session
    - create table
    - create view
    - create sequence
    - create procedure
    ..
    - drop user
    - drop any table
    
    권한의 집합 > Role
    1. connect
        - 사용자가 DB 접속 + 기본적 행동
    2. resource
        - 사용자가 객체 조작
    3. dba
        - 준관리자급 권한
    
*/

create user hong identified by java1234;
alter user hong identified by 1111;
drop user hong;

create user team1 identified by java1234;
alter user 

-- connect
-- ALTER SESSION, CREATE CLUSTER, CREATE DATABASE LINK, CREATE SEQUENCE, CREATE SESSION,
-- CREATE SYNONYM, CREATE TABLE

-- resource
-- CREATE CLUSTER, CREATE PROCEDURE, CREATE SEQUENCE, CREATE TABLE, CREATE TRIGGER


show user;

-- grant 권한 to 계정;
grant create session to hong;
grant create table to hong;

-- 프로젝트 진행 > 프로젝트용 계정 생성
create user team identified by java1234;
grant connect, resource, create view to team; -- 일반 계정
grant connect, resource, dba to team; --학습용

-- java + Oracle = 연동 > JDBC 
create user team1 identified by java1234;
grant connect, resource, create view to team1; -- 일반 계정
grant connect, resource, dba to team1; --학습용


select * from tblAddress;

insert into tblAddress (seq, name, age, gender, tel, address, regdate) values (seqAddress.nextVal, '하하하', '22', 'm', '010-1234-5678', '서울시 동대문구 이문동 쌍용''s 8층', default)














