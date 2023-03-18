/*
    
    ex06_column
    
    select 컬럼리스트
    
    
*/

-- 컬럼 명시
select name, buseo
    from tblInsa;

-- 연산
select name, basicpay, basicpay *2 as basicpay2
    from tblInsa;
    
-- 상수
select name, '홍길동'
    from tblInsa;
    
/*

    distinct 
    - 컬럼 리스트에서 사용
    - 중복값 제거
    - distinct 컬럼명 > distinct 컬럼리스트

*/
    
select * 
    from tblCountry;

-- 14개 국가가 각각 속한 대륙을 가져오시오.
select continent 
    from tblCountry;

-- tblCountry에는 어떤 어떤 대륙이 있나요? > 종류?
select distinct continent 
    from tblCountry;
    
-- tblInsa. > 이 회사에는 어떤 부서들이?
select distinct buseo 
    from tblInsa;
    
-- tblInsa. > 이 회사는 직위가 어떤것들?
select distinct jikwi 
    from tblInsa;

--************* DB의 테이블에는 셀 병합 기능이 없음.  중복값 제거 안됨.
select distinct continent, name 
    from tblCountry;

-- 레코드 전체값을 비교해서 중복값을 제거 함.
select distinct age, height
    from tblAddressBook
        where age = 36;

/*

    case
    - 대부분 절에서 사용
    - 조건문 역할 > 컬럼값 조작
    
*/
    
select 
    last || first as name,
    gender,
    case 
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as gendername
        from tblComedian;
    
select 
    name,
    continent,
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
        when continent = 'SA' then '남미'
         -- else '기타'
         else continent
         -- else capital -- 사용 금지
    end as continentName
from tblCountry;

select
    name,
    continent,
    case continent
        when 'AS' then '아시아'
        when 'EU' then '유럽'
        when 'AF' then '아프리카'
        else '기타'
    end as continentName
from tblCountry;

select 
    last || first as name,
    weight,
    case
        when weight > 90 then '과체중'
        when weight > 50 then '정상체중'
        else '저체중'
    end as state,
    case
        when weight >50 and weight <=90 then '정상체중'
        else '이상체중'
    end as state2,
    case
        when weight between 50 and 90 then '정상체중'
        else '이상체중'
    end as state3
from tblComedian;

select
    name, jikwi,
    case
        when jikwi = '부장' or jikwi = '과장' then '간부급'
        else '평사원급'
    end state,
    case 
        when jikwi in ('부장', '과장') then '간부급'
        else '평사원급'
    end state2
from tblInsa;

select 
    name,
    case
        when name like '김%' then 100
        when name like '이%' then 100
        when name like '박%' then 100
        else 50
    end as 가산점
from tblInsa;

select 
    title,
    case
        when completedate is null then '미완료'
        when completedate is not null then '완료'
    end as state
from tblTodo;


-------------------문제--------------------------------
--요구사항.001.employees
--직업이 어떤것들이 있는지 가져오시오. > job_id
select distinct job_id
from employees
--요구사항.002.employees
--고용일이 2002~2004년 사이인 직원들은 어느 부서에 근무합니까? > hire_date + department_id
select distinct department_id
    from employees
        where hire_date between '2002-01-01' and '2004-12-31'
--요구사항.003.employees
--급여가 5000불 이상인 직원들은 담당 매니저가 누구? > manager_id
select distinct manager_id 
    from employees
        where salary >= 5000;
--요구사항.004.tblInsa
--남자 직원 + 80년대생들의 직급은 뭡니까? > ssn + jikwi
select distinct jikwi
    from tblInsa
        where ssn like '8%-%'
--요구사항.005.tblInsa
--수당 20만원 넘는 직원들은 어디 삽니까? > sudang + city   
select distinct city
    from tblInsa
        where sudang >20;
--요구사항.006.tblInsa
--연락처가 아직 없는 직원은 어느 부서입니까? > null + buseo
select distinct buseo
    from tblInsa
        where tel is null;








    
    
    
    