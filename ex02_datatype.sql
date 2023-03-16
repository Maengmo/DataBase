/*
    ex02_datatype.sql
    
    JAVA > SQL 
    
    ANSI-SQL 자료형
    - Oracle 자료형(***)
    
    1. 숫자형
        - 정수, 실수 
        a. number
            - (유효자리) 38자리 이하의 숫자를 표현하는 자료형
            - 12345678901234567890123456789012345678
            - 1*10^-130 ~ 9.9999*10^125
            - 5~22byte
            
            1. number
                - 정수, 실수
                - 1*10^-130 ~ 9.9999*10^125
                
            2. number(precision)
                - 정수만 저장(반올림) 
                - precision : 저장 가능한 자릿수
                
            3. number(precision, scale)
                - 정수, 실수
                - precision : 저장 가능한 자릿수
                - scale : 소수 이하 자릿수(%.1f)
            
    2. 문자형
        - 문자, 문자열 구분 X
        - char + String > String 
        - char vs nchar > n의 의미?
        - char vs varchar > var의 의미?
       
        a. char
            - 고정 자릿수 문자열 > 컬럼(공간)의 크기가 불변
            - char(n) : n자리 문자열, n(바이트)
                - n 최소 크기 : 1바이트
                - n 최대 크기 : 2000바이트
            - char(10) : 'ABC' > 'ABC       '
            - 주어진 공간을 데이터가 채우지 못하면 나머지 공간을 스페이스로 채운다.
            
        b. nchar
            -  national > 오라클 인코딩과 상관없이 해당 컬럼을 UTF-16 동작하게 만들어라. > 즉, 영어한글 구분없이 한글자 2BYTE씩 잡아먹음
            - 고정 자릿수 문자열 > 컬럼(공간)의 크기가 불변
            - nchar(n) : n자리 문자열, n(문자수)
                - n 최소 크기 : 1글자
                - n 최대 크기 : 1000글자
                
        c. varchar2
            - 가변 자릿수 문자열 > 컬럼(공간)의 크기가 가변
            - varchar(n) : n자리 문자열, n(바이트)
                - n 최소 크기 : 1바이트
                - n 최대 크기 : 4000바이트
            - varchar2(10) > 'ABC' > 'ABC' 
            - 주어진 공간을 데이터가 채우지 못하면 나머지 공간을 버린다.
            - 즉, 데이터의 크기가 공간의 크기가 된다. 
            - 현재 사용하는 것은 이것만 거의 사용함.
                
        d. nvarchar2
            -  national > 오라클 인코딩과 상관없이 해당 컬럼을 UTF-16 동작하게 만들어라. > 즉, 영어한글 구분없이 한글자 2BYTE씩 잡아먹음
            - 가변 자릿수 문자열 > 컬럼(공간)의 크기가 가변
            - nvarchar(n) : n자리 문자열, n(문자수)
                - n 최소 크기 : 1글자
                - n 최대 크기 : 2000글자
                
        e. clob, nclob
            - 대용량 텍스트
            - 128TB
            - 잘 사용 안함. 참조형
           
    
    3. 날짜시간형
        a. date
            - 년월일시분초
            - 기원전 4712년 1월 1일 ~ 9999년 12월 31일
            
        b. timestamp
            - 년월일시분초 + 밀리초 + 나노초
            
        c. interval 
            - 시간
            - 틱값 저장용
    
    4. 이진 데이터형
        - 비 텍스트 데이터
        - 이미지, 영상, 파일 등..
        - ex) 게시판(첨부파일), 회원가입(사진) > 문자열로 저장(파일명만 저장) > hong.png
        a. blob 
            - 최대 128TB 

오라클
1. 숫자 > number
2. 문자 > varchar2(+char)
3. 날짜 > date
4. 논리형 > X


자바
1. 숫자 > int, long, double
2. 문자열 > String
3. 날짜 > Calendar
4. 논리형 > boolean
    
    테이블 선언
    create table 테이블명 (
    
        컬럼 선언,
        컬럼명 자료형,
        컬럼명 자료형,
        컬럼명 자료형
    
    );
    
    
*/

-- 수업 코드 컨벤션
-- - 객체 생성 > 객체 접두어 사용

-- 테이블을 다시 또 생성하면 ORA-00955 : name is already use by an existing object
create table tblType (

    --num number
    --num number(3) -- -999 ~ 999
    --num number(4,2) -- 총 자릿수 4자리에, 소수점 자리는 2자리 고정
    txt1 char(10), --10byte
    txt2 varchar2(10)
    

);
-- 오라클은 사용자가 만든 모든 식별자를 대문자로 변환해서 저장한다.

-- 테이블 삭제
drop table tblType;

-- 테이블 생성 확인?
-- 1. SQL > 모든 툴이 동일하게 반응
select * from tabs;

-- 2. 툴마다 기능이 다름


-- 데이터 추가하기
--1. num 연습 -----------------------------------------------------------------
insert into tblType (num) values (100); -- 정수 데이터 > 정수형 리터럴
insert into tblType (num) values (200); 
insert into tblType (num) values (300);

insert into tblType (num) values (3.14); -- 실수형 리터럴

insert into tblType (num) values (-100); -- 음수

-- ORA-01438: value larger than specified precision allowed for this column : 자료형의 범위를 넘어갔다 > 오버플로우
insert into tblType (num) values (1000); --오버플로우 발생

insert into tblType (num) values (9.9); -- 반올림

insert into tblType (num) values (999); 
insert into tblType (num) values (-999); 

insert into tblType (num) values (3.14);
insert into tblType (num) values (3.142);
insert into tblType (num) values (3.149);

insert into tblType (num) values (33.14);
insert into tblType (num) values (333.14); -- 총 자릿수 5자리가 되기 때문에 4자리를 넘어서 들어가지 않음.
insert into tblType (num) values (333.1); --소수 이하 2자리를 고정으로 했기때문에 들어가지 않음. 

insert into tblType (num) values (99.99);
insert into tblType (num) values (-99.99);

insert into tblType (num) values (100); -- 들어가지 않음.

--2. 문자형 연습-----------------------------------------------------------------------------------
insert into tblType (txt1) values ('A'); --문자열 리터럴
insert into tblType (txt1) values ("A"); -- X

--10바이트 > 몇 글자? > 오라클 인코딩? > UTF-8 > 영어(1), 한글(3) 
insert into tblType (txt1) values ('ABCDEFGHIJ');

--ORA-12899 : value too large for column "HR"."TBLTYPE"."TXT1" (actual: 11, maxinum:10)
insert into tblType (txt1) values ('ABCDEFGHIJK');

insert into tblType (txt1) values ('가');
insert into tblType (txt1) values ('가나다');
insert into tblType (txt1) values ('가나다라'); -- 에러발생

insert into tblType (txt1, txt2) values ('ABC', 'ABC');


-- 데이터 확인하기
--1. 명령어로 확인하기
select * from tblType;

--2. tool로 확인하기

-- 현재 시간
select sysdate from dual; -- 23/03/14



























