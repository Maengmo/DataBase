/*

    ex05_where
    
     [WITH <Sub Query>]                                  - WITH 절
    SELECT column_list                                     - SELECT 절 
    FROM table_name                                     - FROM 절
    [WHERE search_condition]                            - WHERE 절
    [GROUP BY group_by_expression]                  - GROUP BY 절
    [HAVING search_condition]                          - HAVING 절
    [ORDER BY order_expresstion [ASC|DESC]];      - ORDER BY 절
    
    select 컬럼리스트    -- 3. 컬럼 지정
    from 테이블           -- 1. 테이블 지정
    where 조건;           -- 2. 조건 지정
    
    where절
    - 레코드를 검색한다.
    - 원하는 행만 추출하는 역할 > 결과셋 반환
*/
-- 컬럼(5), 레코드(14)
select *
    from tblCountry
        where Name = '대한민국';
    
select *
    from tblCountry
        where Continent = 'AS';

select *
    from tblInsa
        where basicpay > 2000000; -- 19명
        
select *
    from tblInsa
        where basicpay < 2000000; -- 41명
    
select *
    from tblInsa
        where buseo = '개발부';
    
select *
    from tblInsa
        where buseo <> '개발부';

select *
    from tblInsa
        where buseo = '개발부' and jikwi = '부장';


select *
    from tblInsa
        where city = '서울' and city = '경기';


select *
    from tblInsa
        where not buseo = '개발부';
        
        
        
--------------------------------------------------------------------
--tblComedian
-- 1. 몸무게가 60kg 이상이고, 키가 170cm 미만인 사람을 가져오시오. 3명
select *
    from tblComedian
        where weight > 60 and height <170;
-- 2. 몸무게가 70kg 이하인 여자만 가져오시오. 1명
select *
    from tblComedian
        where weight <70 and  gender = 'f';
-- tblInsa
-- 3. 부서가 '개발부'이고, 급여(basicpay)를 150만원 이상 받는 직원을 가져오시오. 4명
select *
    from tblInsa
        where buseo = '개발부' and basicpay >= 1500000;
-- 4. 급여(basicpay) + 수당(sudang)을 합한 금액이 200만원 이상 받는 직원을 가져오시오. 26명
select *
    from tblInsa
        where (basicpay + sudang) >= 2000000;
        
/*

    between
    - where 절에서 사용 > 조건으로 사용
    - 컬럼명 between 최솟값 and 최댓값
    - 범위 조건
    - 가독성(***)
    - 최솟값, 최댓값 > 포함
    
*/   
select *
    from tblcomedian
        where height >=170 and height <=180;

select *
    from tblcomedian
        where height between 172 and 178;        

-- 비교 연산
-- 1. 숫자형
select * 
    from tblInsa 
        where basicpay >= 1500000 and basicpay <=2000000;

select *
    from tblInsa
        where basicpay between 1500000 and 2000000;

-- 2. 문자형
select * 
    from tblInsa
        where name >= '박';
        
select *
    from tblInsa
        where name >= '박' and name <= '유';
    
select *
    from tblInsa
        where name between '박' and '유';
        
--3. 날짜 시간형
select *
    from tblInsa
        where ibsadate >= '2000-01-01'; --2000년 이후에 입사한 직원들
        
select *
    from tblInsa
        where ibsadate >= '2000-01-01' and ibsadate <= '2000-12-31'; --2000년 이후에 입사한 직원들
        
select *
    from tblInsa
        where ibsadate between '2000-01-01' and '2000-12-31';
    

/*

    in
    - where 절에서 사용 > 조건으로 사용
    - 열거형 조건
    - 컬럼명 in (값, 값, 값..)
    - 가독성

*/

-- 홍보부 or 개발부
select *
    from tblInsa
        where buseo = '홍보부' or buseo = '개발부' or buseo = '총무부';

select *
    from tblInsa
        where buseo in('홍보부', '개발부', '총무부');
        
select *
    from tblInsa
        where jikwi in('과장', '부장') and city in ('서울', '인천') and basicpay between 2500000 and 3000000;

-- between, in > 부정적 평가

/*
    
    ▶_◀ ⊙＠⊙ ☞♨☜ ◑↔◐
    like
    - where절에서 사용 > 조건으로 사용
    - 패턴 비교
    - 컬럼명 like '패턴 문자열'
    - 정규 표현식 초간단 버전
    
    패턴 문자열 구성요소
    1. _ : 임의의 문자 1개 ( . )
    2. % : 임의의 문자 N개 0~무한대 ( .* )
    

*/

select name from tblInsa;

-- 김OO
select name 
    from tblInsa
        where name like '김__';
        
select name 
    from tblInsa
        where name like '__수'; --OO수

select name 
    from tblInsa
        where name like '_길_'; --O길O
        
select name 
    from tblInsa
        where name like '김%'; --김~
        
select *
    from tblAddressBook;
    
select *
    from tblAddressBook
        where address like '서울특별시%';
        
select *
    from tblAddressBook
        where address like '%동대문구%';
        
select *
    from tblAddressBook
        where name like '이%';
        
select *
    from tblAddressBook
        where name like '%이';
        
select *
    from tblAddressBook
        where name like '%이%';

-- 주민등록번호
-- 여직원만
select *
    from tblInsa;

select *
    from tblInsa
        where ssn like '%-2%';
        
/*
    
    RDBMS 에서의 null
    - 자바의 null 유사
    - 컬럼 값(셀)이 비어있는 상태
    - null 상수 제공
    - 대부분의 언어는 null은 연산의 대상이 될 수 없다. (********************)
    
    null 조건
    - where절에서 사용
    
*/

-- 인구수가 미기재된 나라? 
select *
    from tblCountry
        where population is null;

-- 인구수가 기재된 나라?
select *
    from tblCountry
        where not population is null;
        
select *
    from tblCountry
        where population is not null; --선호도 높음(가독성)

select *
    from tblInsa
        where tel is not null;

-- 아직 완료하지 않은 일
select *
    from tblTodo
        where CompleteDate is null;
        
-- 완료한 일
select *
    from tblTodo
        where CompleteDate is not null;
        
-- 도서관 > 대여 테이블(속성 : 대여 날짜, 반납 날짜)

-- 아직 반납을 안한 사람은?
select *
    from 도서대여
        where 반납날짜 is null;
        
-- 반납이 완료된 사람은?
select *
    from 도서대여
        where 반납날짜 is not null;

select * from tblTodo;

-- 요구사항.001.tblCountry
-- 모든 행과 모든 컬럼을 가져오시오.
select *
    from tblCountry
-- 요구사항.002.tblCountry
-- 국가명과 수도명을 가져오시오.
select name, capital
    from tblCountry;
-- 요구사항.003.tblCountry
-- 아래와 같이 가져오시오
-- [국가명]    [수도명]   [인구수]   [면적]    [대륙] <- 컬럼명
-- 대한민국   서울        4403       101       AS     <- 데이터
select name as 국가명, capital as 수도명, population as 인구수 , continent as 면적 , Area as 대륙 
    from tblCountry
--요구사항.004.tblCountry
--아래와 같이 가져오시오
-- [국가정보] <- 컬럼명
-- 국가명: 대한민국, 수도명: 서울, 인구수: 4403   <- 데이터
select '국가명 : ' || name || ', 수도명 : ' || capital || ', 인구수 : '|| population as 국가정보
    from tblCountry
        where name = '대한민국';

--요구사항.005
--아래와 같이 가져오시오.employees
-- [이름]                 [이메일]                 [연락처]            [급여]
-- Steven King           SKING@gmail.com   515.123.4567      $24000
select first_name||Last_name as 이름, email as 이메일, phone_number as 연락처, salary as 급여
    from employees
        where phone_number = '515.123.4567'

--요구사항.006.tblCountry
--면적(area)이 100이하인 국가의 이름과 면적을 가져오시오.
select name, Area
    from tblCountry
        where area <=100;

--요구사항.007.tblCountry
--아시아와 유럽 대륙에 속한 나라를 가져오시오.
select *
    from tblCountry
    where continent = 'AS' or continent = 'US';

--요구사항.008.employees
--직업(job_id)이 프로그래머(it_prog)인 직원의 이름(풀네임)과 연락처 가져오시오.
select first_name||last_name as 이름, phone_number
    from employees 
        where job_id = 'IT_PROG';

--요구사항.009.employees
--last_name이 'Grant'인 직원의 이름, 연락처, 고용날짜를 가져오시오.
select first_name||last_name as 이름, phone_number, hire_date
    from employees
    where last_name = 'Grant';

--요구사항.010.employees
--특정 매니저(manager_id: 120)이 관리하는 직원의 이름, 급여, 연락처를 가져오시오.
select first_name||last_name as 이름, salary, phone_number
    from employees
        where manager_id = 120

--요구사항.011.employees
--특정 부서(60, 80, 100)에 속한 직원들의 이름, 연락처, 이메일, 부서ID 가져오시오.
select first_name||last_name as 이름, phone_number, email, department_id
    from employees
        where department_id in(60, 80, 100);

--요구사항.012.tblInsa
--기획부 직원들 가져오시오.
select *
    from tblInsa
        where buseo = '기획부';

--요구사항.013.tblInsa
--서울에 있는 직원들 중 직위가 부장인 사람의 이름, 직위, 전화번호 가져오시오.
select name, jikwi, tel
    from tblInsa
        where jikwi = '부장'

--요구사항.014.tblInsa
--기본급여 + 수당 합쳐서 150만원 이상인 직원 중 서울에 직원만 가져오시오.
select *
    from tblInsa
        where (Basicpay+sudang) >= 1500000 and city = '서울'


--요구사항.015.tblInsa
--수당이 15만원 이하인 직원 중 직위가 사원, 대리만 가져오시오.
select *
    from tblInsa
        where sudang <= 150000 and jikwi in ('사원', '대리');

--요구사항.016.tblInsa
--수당을 제외한 기본 연봉이 2천만원 이상, 서울, 직위 과장(부장)만 가져오시오.
select *
    from tblInsa
        where (basicpay*12) >= 20000000 and city = '서울' and jikwi in ('과장', '부장');

--요구사항.017.tblCountry
--국가명 'O국'인 나라를 가져오시오.
select *
    from tblCountry
        where name like '_국';

--요구사항.018.employees
--연락처가 515로 시작하는 직원들 가져오시오.
select *
    from employees
        where phone_number like '515.%.%';

--요구사항.019.employees
--직업 ID가 SA로 시작하는 직원들 가져오시오.
select *
    from employees
        where job_id like 'SA_%';

--요구사항.020.employees
--first_name에 'de'가 들어간 직원들 가져오시오.
select *
    from employees
        where first_name like '%de%';

--요구사항.021.tblInsa
--남자 직원만 가져오시오.
select *
    from tblInsa
        where ssn like '%-1%';

-- 요구사항.022.tblInsa
--여자 직원만 가져오시오.   
select *
    from tblInsa
        where ssn like '%-2%';
        
--요구사항.023.tblInsa
--여름에(7,8,9월) 태어난 직원들 가져오시오.
select *
    from tblInsa
    where ssn like '__07%' or  ssn like '__08%' or  ssn like '__09%'
--요구사항.024.tblInsa
--서울, 인천에 사는 김씨만 가져오시오.    
select *
    from tblInsa
        where city in ('서울', '인천') and name like '김%';

--요구사항.025.tblInsa
--영업부/총무부/개발부 직원 중 사원급(사원/대리) 중에 010을 사용하는 직원들을 가져오시오.
select *
    from tblInsa
        where Buseo in ('영업부', '총무부', '개발부') and tel like '010-%-%';

--요구사항.026.tblInsa
--서울/인천/경기에 살고 입사일이 1998~2000년 사이인 직원들을 가져오시오.
select *
    from tblInsa
        where city in('서울','인천','경기') and ibsadate between '1998-01-01' and '2000-12-31';

--요구사항.027.employees
--부서가 아직 배정 안된 직원들을 가져오시오. (department_id가 없는 직원)
select *
    from employees
        where department_id is null;

        
        
        
        
        
        
        
        
        
        
        
        
        