/*

    ex08_aggregation_function 
    
    함수, Function
    1. 내장형 함수(Built-in Function)
    2. 사용자 정의 함수(User Function) > ANSI-SQL(X), PL/SQL(O)
    
    집계함수, Aggregation Function
    1. count()
    2. sum()
    3. avg()
    4. max()
    5. min() 
    
    1. count()
    - 결과 테이블의 레코드 수를 반환한다.
    - number count(컬럼명)
    - null 레코드는 제외된다(**********)
    
*/

select name
    from tblCountry; 
    
-- 테이블의 레코드 개수
select count(name)
    from tblCountry; 

-- 'AS' 에 속한 나라 갯수? 
select count(name)
    from tblCountry
        where continent = 'AS';
        
select capital 
    from tblCountry

select count(capital)
    from tblCountry

--population 에는 null값이 있기 떄문에 null 값이 반환되지 않아 값이 다르게 나옴
select count(population)
    from tblCountry;

-- tblCountry에 나라가 총 몇개? 14
select count(name) from tblCountry;
select count(capital) from tblCountry;
select count(population) from tblCountry;

---- 해결책
select count(*) from tblCountry; --null과 상관없이 테이블의 행 갯수를 정확하게 파악

--모든 직원수
select count(*) from tblInsa;
--연락처가 있는 직원수?
select count(tel) from tblInsa;
--연락처가 없는 직원수?
select count(*) - count(tel) from tblInsa;
-- 연락처가 있는 직원수? 방법2
select count(*) 
    from tblInsa
    where tel is not null
-- 연락처가 없는 직원수? 방법2
select count(*) 
    from tblInsa
    where tel is null
    
-- tblInsa. 어떤 부서들 있나요?
select distinct buseo from tblInsa;

-- tblInsa. 부서가 몇개 있나요?
select count( distinct buseo) from tblInsa;

-- tblComedian. 남자수? 여자수?
select count(*) from tblComedian where gender ='m'; --남자수 --8
select count(*) from tblComedian where gender ='f'; --여자수 --2

-- *** 자주 사용되는 패턴
select 
    count(*) as 전체인원수,
    count(case
        when gender = 'm' then 'A'
    end) as 남자인원수,
    count(case
        when gender = 'f' then 'B' 
    end) as 여자인원수
    from tblComedian;

-- tblInsa. 기획부 몇명? 총무부 몇명? 개발부 몇명?
select
    count(*) as 전체인원수,
    count(case
        when buseo = '기획부' then 'A'
    end) as 기획부인원수,
    count(case
        when buseo = '총무부' then 'B'
    end) as 총무부인원수,
    count(case
        when buseo = '개발부' then 'C'
    end) as 개발부인원수
from tblInsa;

-- 단일컬럼 or * : 이렇게 하면 불가능함. 에러 발생
select
    count(name, buseo)
from tblInsa;

/*

    2. sum()
    - 해당 컬럼의 합을 구한다.
    - number sum(컬럼명)
    - 숫자형만 적용 가능

*/

select *
    from tblComedian;
select sum(height),  sum(weight)
    from tblComedian;
-- 에러 발생 : 숫자가 아닌 컬럼을 sum하여서 에러.
select sum(first) 
    from tblComedian;

select 
    sum(basicpay) as "지출 급여 합",
    sum(sudang) as "지출 수당 합",
    sum(basicpay) + sum(sudang) as "총 지출",
    sum(basicpay+sudang) as "총 지출"
from tblInsa;

/*

    3. avg()
    - 해당 컬럼의 평균값을 구한다.
    - number avg(컬럼명)
    - 숫자형만 적용 가능
    - null 값은 버림(***********)
    
*/

-- tblInsa. 평균 급여?
select sum(basicpay) / 60 
    from tblInsa;
select sum(basicpay) / count(*)
    from tblInsa;
select avg(basicpay) 
    from tblInsa;

-- 평균 인구수?
select
    avg(population),    
    sum(population) / count(*),
    sum(population) / count(population)
from tblCountry;

select
    count(*), -- 인구수가 null 값이 케냐가 포함
    count(population) -- 인구수가 null값인 케냐가 비포함
from tblCountry;

-- 회사 > 성과급 지급 > 성과급 출처 > 1팀 공로~
-- 1. 균등 지급 : 총지급액 / 모든 직원수 = sum() / count(*)
-- 2. 차등 지급 : 총지급액 / 참여 직원수 = sum()/ count(참여한인원수) = avg()

/*

    4. max()
    - object max(컬럼명)
    - 최댓값 반환
    
    5. min()
    - object min(컬럼명)
    - 최솟값 반환
    
    - 숫자형, 문자형, 날짜형 모두 적용 가능함.

*/

-- 1. 숫자형 ex)
select 
    max(height),
    min(height)
from tblComedian;

-- 2. 문자형 ex)
select
    max(name),
    min(name)
from tblInsa;

-- 3. 날짜형 ex)
select 
    max(ibsadate),
    min(ibsadate)
from tblInsa;

select 
    count(*) as "직원수",
    sum(basicpay) as "총급여 합",
    avg(basicpay) as "평균 급여",
    max(basicpay) as "최고 급여",
    min(basicpay) as "최저 급여"
from tblInsa;


select *
from tblCountry;
-- 집계함수 문제 예제 --
-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
select
    count(case
        when Continent = 'AS' then 'A'
   end) as 아시아개수,
    count(case 
        when Continent = 'EU' then 'B'
   end) as 유럽개수
from tblCountry;
-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
select
    count(case
        when population between 7000 and 20000 then 'A'
    end) as 개수
from tblCountry;
-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
select * from employees;
select
    count(case
        when job_id = 'IT_PROG' and salary > 5000 then 'A'
    end) as 인원
from employees;
-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
select * from tblInsa;
select 
    count(case
        when tel not like  '010-%-%' then 'A'
    end) as 인원
from tblInsa;
-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명
select
    count(case
        when city not in ('서울', '경기', '인천') then 'A'
    end) as 인원
from tblInsa;
-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
select
    count(case
        when ssn like '__07%-2%' or  ssn like '__08%-2%' or  ssn like '__09%-2%' then 'A'
    end) as 인원
from tblInsa;
-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
select
    count(case
            when buseo = '개발부' and jikwi = '부장' then 'A'
     end) as 부장,
     count(case
            when buseo = '개발부' and jikwi = '과장' then 'A'
     end) as 과장,  
     count(case
            when buseo = '개발부' and jikwi = '대리' then 'A'
     end) as 대리, 
     count(case
            when buseo = '개발부' and jikwi = '사원' then 'A'
     end) as 사원   
from tblInsa;

--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
select * from tblCountry;
select sum(Population)
    from tblCountry
    where continent in ('EU' , 'AF');
--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
select * from employees
select sum(salary)
    from hr.employees
    where manager_id = 108;
--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
select sum(salary)
    from hr.employees
    where job_id in ('ST_CLERK', 'SH_CLERK');
--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
select * from tblInsa
select sum(basicpay + sudang)
    from tblInsa
    where city = '서울'
--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000
select sum(basicpay)
    from tblInsa
    where jikwi in ('부장', '과장');
    
--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
select avg(population)
    from tblCountry
    where continent = 'AS'
--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
select avg(salary)
    from employees
    where first_name like '%an%';
--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
select avg(basicpay)
    from tblInsa
    where jikwi in ('부장' , '과장');
--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66
select avg(basicpay)
    from tblInsa
    where jikwi in ('대리' , '사원');
--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320
select
    avg(case
        when jikwi in ('부장' , '과장') then basicpay
    end)
    - avg(case
        when jikwi in ('대리' , '사원') then basicpay
    end) as "평균 급여의 차액"
    from tblInsa;
    
--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
select max(Area)
from tblCountry;
--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000
select min(basicpay+sudang)
from tblInsa;

-- 집계 함수 사용 주의점 !!! --

--1. ORA-00937: not a single-group group function 
-- 컬럼 리스트에 집계 함수와 일반 컬럼은 동시에 사용할 수 없다.

select count(*) from tblInsa; -- 직원수
select name from tblInsa; -- 직원명

-- 요구사항] 직원들의 이름과 총 직원수를 가져오시오.
SELECT name, count(*) from tblInsa; --ORA-00937: not a single-group group function

--2. ORA-00934: group function is not allowed here
-- where 절에는 집계함수를 사용할 수 없다.
-- 집계 함수 반환값(집합), 컬럼(개인)
-- where 절은 개인 데이터를 검사하는 영역 > 집합값에 대한 접근이 불가능하다.

-- 요구사항] 평균 급여보다 더 많이 받는 직원을 가져오시오.
select avg(basicpay) from tblInsa; -- 155만원

select * 
    from tblInsa
        where basicpay >= avg(basicpay); --ORA-00934: group function is not allowed here


















