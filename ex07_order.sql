/*

    ex07_order
    
     [WITH <Sub Query>]                                  - WITH 절
    SELECT column_list                                     - SELECT 절 
    FROM table_name                                     - FROM 절
    [WHERE search_condition]                            - WHERE 절
    [GROUP BY group_by_expression]                  - GROUP BY 절
    [HAVING search_condition]                          - HAVING 절
    [ORDER BY order_expresstion [ASC|DESC]];      - ORDER BY 절
    
    select 컬럼리스트    -- 3. 원하는 컬럼들을
    from 테이블           -- 1. 테이블로부터
    where 조건;           -- 2. 원하는 행들을
    order by 정렬기준;  -- 4. 순서대로
    
    order by 절
    - 결과셋의 정렬(O)
    - 원본 테이블의 정렬(사용자가 관여 불가능 > 오라클 스스로)
    - oredr by 정렬 컬럼 (asc : 오름차순 | desc : 내림차순)

*/

select * 
    from tblCountry
    order by name asc;
    
select * 
    from tblCountry
    order by name desc; --null 컬럼을 대상으로 정렬

select * 
    from tblCountry
    where population is not null
    order by population desc;

select * 
    from tblInsa 
    order by name asc; -- 문자열 + 오름차순
    
select *
    from tblInsa 
    order by basicpay; --숫자 + 오름차순 

select *
    from tblInsa
    order by ibsadate; --날짜 + 오름차순

-- 다중 정렬 
select *
    from tblInsa
    order by buseo asc, city asc, name asc;
    
select 
    name, buseo, jikwi
from tblInsa
    order by buseo, jikwi, name;

select 
    name, buseo, jikwi
from tblInsa
    order by 2, 3, 1; --비권장 > 가독성 낮음, 유지보수에 취약
    
-- 가공된 값 > where 절
-- 가공된 값 > order by 절

select * from tblInsa order by basicpay desc; 
select * from tblInsa order by basicpay+sudang desc;

-- 직위 순으로 정렬 : 부장 > 과장 > 대리 > 사원
select 
    name,  jikwi,
    case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        else 4
    end as jikwiSeq
from tblInsa
    order by jikwiSeq;
    
select 
    name,  jikwi,
    case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        else 4
    end 
from tblInsa
    order by 3;
    
select 
    name,  jikwi
from tblInsa
    order by  case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
    end asc;
    
select 
    name,  jikwi
from tblInsa
   where  case
        when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
        end = 1
    order by case
         when jikwi = '부장' then 1
        when jikwi = '과장' then 2
        when jikwi = '대리' then 3
        when jikwi = '사원' then 4
        end asc;
        
-- 성별순으로 정렬 : 남자 > 여자
-- 771212-1022432

select *
    from tblInsa;

select *
    from tblInsa
    order by case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'
    end asc;
    
select
    case
        when ssn like '%-1%' then '남자'
        when ssn like '%-2%' then '여자'
    end
from tblInsa;














