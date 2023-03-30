/*

    ex25_with.sql
    
    [WITH <Sub Query>]                                  - WITH 절
    SELECT column_list                                     - SELECT 절 
    FROM table_name                                     - FROM 절
    [WHERE search_condition]                            - WHERE 절
    [GROUP BY group_by_expression]                  - GROUP BY 절
    [HAVING search_condition]                          - HAVING 절
    [ORDER BY order_expresstion [ASC|DESC]];      - ORDER BY 절
        
    with절
    - 인라인뷰(from절 서브쿼리)에 이름을 붙이는 기술
    
    with 절 실행 방식
    1. Materialize 방식 > 임시 테이블이 2번 이상 사용되면 내부에 임시 테이블 생성 + 반복 재사용
    2. Inline 방식 > 임시 테이블 생성없이 매번 인라인 쿼리를 반복 실행 
    
    - 양식
    with 임시테이블명 as (
    결과셋 select
    ) select 문
    
*/

-- ex1) 
select * from (select name, buseo, jikwi from tblInsa where city = '서울');

with seoul as (select name, buseo, jikwi from tblInsa where city = '서울')
select * from seoul;

-- ex2)
select * 
from (select name, age, couple from tblMen where weight < 90) a
    inner join ( select name, age, couple from tblWomen where weight > 60) b
        on a.couple = b.name;
            
with a as (select name, age, couple from tblMen where weight < 90),
      b as (select name, age, couple from tblWomen where weight > 60)
select * from a inner join b on a.couple = b.name;

-- 순위 함수 or rownum

-- 급여 5위
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

with insa as (select
                    name, buseo, basicpay,
                    rank() over(order by basicpay desc) as rnum
                from tblInsa)
select * from insa where rnum = 5;
























