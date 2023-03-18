/*

    ex09_numerical_function.sql
    
    숫자 함수(= 수학 함수)
    - Math.random()
    
    round()
    - 반올림 함수
    - number round(컬럼명)
    - number round(컬럼명, 소수이하 자릿수)

*/

select 
    height / weight,
    round(height / weight),
    round(height / weight, 1),
    round(height / weight, 2),
    round(height / weight, 3),
    round(height / weight, 0)
from tblComedian;

-- 평균 급여
select round(avg(basicpay)) from tblInsa;

/*

    floor(), trunc()
    - 절삭 함수(바닥)
    - 무조건 내림 함수
    - number floor(컬럼명) : 무조건 정수 반환
    - number trunc(컬렴명 [, 소수이하 자릿수]) : 정수 or 실수 반환
    

*/

select
    height / weight,
    round(height / weight),
    floor(height / weight),
    trunc(height / weight),
    trunc(height / weight, 1),
    trunc(height / weight, 2)
from tblComedian;

/*

    ceil()
    - 무조건 올림 함수(천장)
    - number ceil(컬럼명)

*/

select 
    height / weight,
    round(height / weight),
    floor(height / weight),
    ceil(height / weight)
from tblComedian;

/*

    mod()
    - 나머지 함수
    - number mod(피제수, 제수)

*/

-- dual 테이블 > 레코드 1개짜리 테이블
select * from dual;

select sysdate from tblCountry;

select sysdate from tblComedian; 

select sysdate from dual;

select 
    10/3,
    mod(10, 3)  as "나머지", --자바 정수%정수 
    floor(10/3) as "몫"        --자바 정수/정수
from dual;

select
    abs(10),
    abs(-10),   -- 절댓값
    power(2,2), -- 제곱 
    power(2,3),
    power(2,4),
    sqrt(4), -- 루트
    sqrt(9),
    sqrt(16)
from dual;














