-- ex04_operator.sql

/*

    연산자, Operator
    
    1. 산술 연산자
    - +, -, *, /
    - %(없음) > 함수로 제공(mod())
    
    2. 문자열 연산자
    - +(X) > ||(O)
    
    3. 비교 연산자
    - >, >=, <, <=
    - =(==), <>(!=)
    - 논리값 반환 > 명시적으로 표현 불가능한 자료형 > 조건이 필요한 상황에서만 사용
    - 컬럼 리스트에서 사용 불가능
    - 조건절에서 사용 가능
    
    4. 논리 연산자
    - and(&&), or(||), not(!)
    - 컬럼 리스트에서 사용 불가능
    - 조건절에서 사용 가능
    
    5. 대입 연산자
    - =
    - 컬럼 = 값
    - update문
    
    6. 3항 연산자
    - 없음.
    - 제어문 없음
    
    7. 증감 연산자
    - 없음
    
    8. SQL 연산자
    - 자바 : instanceof, typeof 등 같은 연산자
    - in, between, like, is 등.. (00구, 00절)

    

*/
--테이블 구조(char형인지 num형인지 구분)
desc tblCountry;
select * from tblCountry;

-- 산술 연산자 사용 법
select population, area, population + area 
    from tblCountry;

-- 문자 연산자 사용 법
-- ORA-01722: invalid number : +연산자는 산술연산자로만 쓰임.
select name + capital
    from tblCountry;
    
-- 올바른 더하기 방법
select name, capital, name || capital
    from tblCountry;

drop table tblType;

create table tblType (
    num1 number,
    num2 varchar2(50)
);

insert into tblType (num1, num2) values (123, '123');

-- number형은 오른쪽 정렬, char형은 왼쪽 정렬임 즉, 콘솔에서 사이를 벌려보면 무슨 형인지 알 수 있음.
select * from tblType;

-- 오류 발생
select population > area from tblCountry;

select * from tblCountry where population > area;

-- 컬럼명 > 가공된 컬럼명 > 올바른 이름으로 수정 > 컬럼명 바꾸기 > 별칭(Alias)
-- 식별자 > "name || '님''"
select name, name || '님' 
    from tblInsa;

select name as name1 , name || '님' as name2 
    from tblInsa;
    
select name as 이름 
    from tblInsa;

select name as "직원 이름" -- 사용 금지
    from tblInsa;

select name as "select"     -- 사용 금지
    from tblInsa;
























