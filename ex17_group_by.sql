/*

    ex17_group_by.sql
    
    [WITH <Sub Query>]                                  - WITH 절
    SELECT column_list                                     - SELECT 절 
    FROM table_name                                     - FROM 절
    [WHERE search_condition]                            - WHERE 절
    [GROUP BY group_by_expression]                  - GROUP BY 절
    [HAVING search_condition]                          - HAVING 절
    [ORDER BY order_expresstion [ASC|DESC]];      - ORDER BY 절
    
    select 컬럼리스트  -- 4. 컬럼을 선택
    from 테이블         -- 1. 테이블로부터
    where 조건          -- 2. 원하는 레코드를
    group by 기준      -- 3. 그룹을 나눠서
    order by 정렬조건 -- 5. 정렬한다.
    
    group by절
    - 레코드를 대상으로 그룹을 나누는 역할
    - 특정 컬럼을 대상으로 같은 값을 가지는 레코드들끼리 그룹을 묶는 역할
    - 그룹을 왜 나누는지? > 각각의 나눠진 그룹을 대상 > 집계 함수를 적용하기 위해서!! (****************)
    
*/

select *
from tblComedian;

-- tblInsa. 부서별 평균 급여?
select * from tblInsa;

select avg(basicpay) from tblInsa; -- 155만원, 60명

select distinct buseo from tblInsa; -- 7개

select round(avg(basicpay)) from tblInsa where buseo = '총무부'; --171
select round(avg(basicpay)) from tblInsa where buseo = '개발부'; --138
select round(avg(basicpay)) from tblInsa where buseo = '영업부'; --160
select round(avg(basicpay)) from tblInsa where buseo = '기획부'; --185
select round(avg(basicpay)) from tblInsa where buseo = '인사부'; --153
select round(avg(basicpay)) from tblInsa where buseo = '자재부'; --141
select round(avg(basicpay)) from tblInsa where buseo = '홍보부'; --145

-- group by를 사용할 때 컬럼리스트 
-- 1. 집계 함수
-- 2. group by 기준이 된 컬럼
select 
    round(avg(basicpay)),
    buseo
from tblInsa
    group by buseo;

-- 남자 몇명? 여자 몇명? > 남녀별 각각 몇명인지?
select
    count(*),
    gender
from tblComedian
    group by gender;

-- 대륙별 국가수?
select 
    count(*),
    continent
from tblCountry
    group by continent;
    
select 
    buseo,
    count(*) as "부서별 인원수",
    sum(basicpay) as "부서별 급여 합",
    round(avg(basicpay)) as "부서별 평균 급여",
    max(ibsadate) as "부서별 막내의 입사일",
    min(ibsadate) as "부서별 고참의 입사일"
from tblInsa
    group by buseo;
    
select 
    gender,
    round(avg(height)) as "남녀별 평균 키",
    round(avg(weight), 1) as "남녀별 평균 몸무계",
    max(height) as "키가 가장 큰사람",
    min(height) as "키가 가장 작은사람"
from tblComedian
    group by gender;
    
-- 직업별 인원수? 많은 > 적게
select 
    job,
    count(*)
from tblAddressBook
    group by job
        --order by count(*) desc;
        order by job asc;

-- 오 류 발 생
select  
    round(avg(basicpay)), -- 집합값(집계함수)
    name                    -- 개인값(일반컬럼)
from tblInsa;

-- 오 류 발 생2
select
    round(avg(basicpay)),   -- 평균급 > 집합값
    buseo,                     -- 부서명 > 표현(개인값) > 실제(그룹역할) > 집합값
    name                      -- 직원명 > 개인값
from tblInsa
    group by buseo;

-- 다중 그룹
-- 1차 그룹(부서) > 2차 그룹(직위)
select 
    buseo as "부서명",
    jikwi as "직위명",
    count(*) as "인원수"
from tblInsa
    group by buseo, jikwi
        order by buseo, jikwi;

-- 성별 인원수?
select  
    count(*),
    substr(ssn, 8, 1) as "성별"
from tblInsa
    group by substr(ssn, 8, 1);

-- 지역별 인원수
select 
    substr(address, 1, instr(address, ' ') -1), -- -- 공백을 기준으로 공백만큼 짤라옴
    count(*)
from tblAddressBook
    group by substr(address, 1, instr(address, ' ') -1);

-- 이메일 사이트별 인원수? 
select
    substr(email, instr(email, '@')+1) as "사이트",
    count(*) as "회원 수"
from tblAddressBook
    group by  substr(email, instr(email, '@')+1)
        order by count(*) desc;

-- 급여별 그룹 > 인원수?
-- 100만원 이하
-- 100만원 ~ 200만원
-- 200만원 이상
select
    basicpay,
    floor(basicpay / 1000000)
from tblInsa;
     
select
   (floor(basicpay / 1000000) +1) * 100 || '만원 이하' as "급여대",
    count(*) as "인원수"
from tblInsa
    group by floor(basicpay/1000000)
        order by floor(basicpay / 1000000) asc;
    
-- 한일? 안한일? 각각 몇개?
select 
    completedate,
    count(*)
from tblTodo
    group by completedate;

select
    count(*) as "개수",
     case
        when completedate is null then '안한일'
        when completedate is not null then '한일'
    end as "완료/미완료"
from tblTodo
    group by  case
            when completedate is null then '안한일'
            when completedate is not null then '한일'
                end;
            
-- Group by 문제 모음

-- tblZoo. 종류(family)별 평균 다리의 갯수를 가져오시오.
select *
from tblzoo;
select 
    family as "종류",
    round(avg(leg),1)
from tblzoo
    group by Family;
    
-- tblZoo. 사이즈와 종류별로 그룹을 나누고 각 그룹의 갯수를 가져오시오.
select 
    count(*) as "개수",
    sizeof as "크기", family as "어종"
from tblzoo
    group by sizeof, family
        order By family asc, sizeof desc;
        
-- tblAddressBook. 이메일이 스네이크 명명법으로 만들어진 사람들 중에서 여자이며, 20대이며, 키가 150~160cm 사이며, 고향이 서울 또는 인천인 사람들만 가져오시오.
select *
from tblAddressBook
    where instr(email,'_') <>0 and 
        Gender = 'f' and 
        height between 150 and 160 
        and hometown in ('서울', '인천');


/*

    [WITH <Sub Query>]                                  - WITH 절
    SELECT column_list                                     - SELECT 절 
    FROM table_name                                     - FROM 절
    [WHERE search_condition]                            - WHERE 절
    [GROUP BY group_by_expression]                  - GROUP BY 절
    [HAVING search_condition]                          - HAVING 절
    [ORDER BY order_expresstion [ASC|DESC]];      - ORDER BY 절
    
    select 컬럼리스트  -- 5. 컬럼을 선택
    from 테이블         -- 1. 테이블로부터
    where 조건          -- 2. 원하는 레코드를
    group by 기준      -- 3. 그룹을 나눠서
    having 절            -- 4. 그룹에 대한 조건
    order by 정렬조건 -- 6. 정렬한다.
    
    group by절
    - 레코드를 대상으로 그룹을 나누는 역할
    - 특정 컬럼을 대상으로 같은 값을 가지는 레코드들끼리 그룹을 묶는 역할
    - 그룹을 왜 나누는지? > 각각의 나눠진 그룹을 대상 > 집계 함수를 적용하기 위해서!! (****************)
    
    **** where 절 vs having 절
    
    having 절
    - 조건절
    - group by 로 부터 나온 셋에 대한 조건(실행 순서 : group by > having)
    - 집합에 대한 질문 > 집계 함수값을 조건으로 사용
    
    
    where 절
    - 조건절
    - from으로부터 나온 셋에 대한 조건(실행 순서 : from > where)
    - 개인에 대한 질문(행) > 컬럼값을 조건으로 사용
    
    select 문(********)
    1. 각절의 역할
    2. 각절의 실행 순서
    
*/

-- 그룹(buseo) > 인원수 (count)
select 
    count(*), buseo        -- 3
from tblInsa                -- 1
    group by buseo;       -- 2

-- 서울 사는 직원 > 부서별 인원수?
select
    count(*), buseo            -- 4.
from tblInsa                    -- 1.
    where city = '서울'       -- 2. where : 개인(행)에 대한 조건 필터
        group by buseo;      -- 3. 부서별로 Group

-- 기본 급여가 250만원 이상 > 부서별 인원수?
select
    count(*), buseo                       -- 4.
from tblInsa                                -- 1.
    where basicpay >= 2500000      -- 2. where : 개인(행)에 대한 조건 필터
        group by buseo;                  -- 3. 부서별로 Group


-------------------------------------------------------------------------

select 
    buseo,
    round(avg(basicpay))      -- 3. 나눠진 그룹별로 집계함수를 각각 구한다.
from tblInsa                     -- 1. 60명의 데이터를 가져온다.
    group by buseo;           -- 2. 60명을 대상으로 > 부서로 그룹을 나눈다.


select 
    buseo,
    round(avg(basicpay)) as "평균 급여"         -- 4. 나눠진 그룹별로 집계함수를 각각 구한다.
from tblInsa                                           -- 1. 60명의 데이터를 가져온다.
    where basicpay >= 1500000                 -- 2. 60명을 대상으로 조건에 맞는 직원만 남긴다.
        group by buseo;                             -- 3. where절을 만족한 대상으로 > 부서로 그룹을 나눈다.
        

select
    buseo,
    round(avg(basicpay)) as "평균 급여"      -- 4. 나눠진 그룹별로 집계함수를 각각 구한다.
from tblInsa                                        -- 1. 60명의 데이터를  가져온다.
    group by buseo                               -- 2. 60명을 대상으로 > 부서별 그룹을 나눈다.
        having avg(basicpay) >= 1500000   -- 3. 부서별 150만원 이상인 그룹만 남긴다.(그룹별 집계함수값을 조건으로 필터링)
            order by avg(basicpay) desc;


select
    buseo,
    round(avg(basicpay)) as "평균 급여"              -- 5.
from tblInsa                                                -- 1. from 절 
    where basicpay >= 1500000                      -- 2. where 절
        group by buseo                                   -- 3. 
            having avg(basicpay) >= 2200000        -- 4.
                order by avg(basicpay) desc;           -- 6.
                
-- tblZoo. 체온이 변온인 종류 중 아가미 호흡과 폐 호흡을 하는 종들의 갯수를 가져오시오.
SELECT 
    count(case
        when breath in ('lung') then 1
    end) as "변온,폐 호흡",
    count(case
        when breath in ('gill') then 1
    end) as "변온,아가미 호흡"
FROM tblzoo
    GROUP BY thermo
        HAVING thermo = 'variable';


-- tblAddressBook. 관리자의 실수로 몇몇 사람들의 이메일 주소가 중복되었다. 중복된 이메일 주소만 가져오시오.
select *
from tblAddressBook;
select 
    Email,
    count(email)
from tblAddressBook
    Group by email
    having count(email)>1;
-- tblAddressBook. 성씨별 인원수가 100명 이상 되는 성씨들을 가져오시오.
select 
    substr(name, 1, 1) as "성",
    count(substr(name, 1, 1))
from tblAddressBook
    Group by substr(name, 1, 1)
    having count(substr(name, 1, 1)) >= 100;
-- tblAddressBook. '건물주'와 '건물주자제분'들의 거주지가 서울과 지방의 비율이 어떻게 되느냐?
select
    job,
    count(*) as "총인원수",
    count(case
            when substr(address, 1, 2) = '서울' then 1
    end) as "서울 거주",
    count(case
            when substr(address, 1, 2) <> '서울' then 1
    end) as "서울 비거주",
    
    round(count(case
            when substr(address, 1, 2) = '서울' then 1
    end) / count(*) * 100, 2) as "서울 거주(%)",
    
    round(count(case
            when substr(address, 1, 2) <> '서울' then 1
    end) / count(*) * 100, 2) as "서울 비거주(%)"
    
from tblAddressBook
    group by job
        having job in ('건물주', '건물주자제분');



/*

    group by 함수
    
    1. roll up()
    
    2. cube()
    
    rollup()
    - group by 결과에서 집계 결과를 더 자세하게 반환

*/

select
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by buseo;
    
    
select
    buseo,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo); -- rollup은 총계를 내줌.
    

select
    buseo,
    jikwi,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo, jikwi);
      --  order by buseo asc, jikwi asc;
      

select
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by rollup(buseo, jikwi, city);
    

/* 
    
    cube()
    - group by 결과에서 집계 결과를 더 자세하게 반환
    - rollup() 보다 좀 더 자세하게 표현
    - rollup() 비해 좀 더 다양한 기준으로 중간 집계 추가~
    
*/

select
    buseo,
    jikwi,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo, jikwi);
    
select
    buseo,
    jikwi,
    city,
    count(*),
    round(avg(basicpay))
from tblInsa
    group by cube(buseo, jikwi,city);
