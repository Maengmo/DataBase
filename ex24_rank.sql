/*

    ex24_rank.sql
    
    순위 함수
    - rownum의 사용을 여러가지 용도로 구현해 놓은 함수
    
    1. rank() over()
        - ranck() over(order by 컬럼명 [asc|desc])
        - 순위 부여시, 중복값이 발생하면 동일한 순위를 부여하고, 중복값의 개수만큼 건너뛰기 한다.
        
    2. dense_rank() over()
        - dense_ranck() over(order by 컬럼명 [asc|desc])
        - 순위 부여시, 중복값이 발생하면 동일한 순위를 부여하고, 그 뒤의 순위는 건너뛰기 없이 순차적으로 부여한다.
        
    3. row_number() over()
        - row_number() over(order by 컬럼명 [asc|desc])
        - 순위 부여시, 중복값과 상관없이 순차적으로 부여
        - 직접 rownum을 사용한 결과와 동일하다
*/

-- 급여순으로 가져오시오. + 순위

--1. rownum 사용
select a.*, rownum from (SELECT
                        name, buseo, basicpay
                    from tblInsa
                        order by basicpay desc) a;
--2. rank 함수 사용
select
    name, buseo, basicpay,
    rank() over(order by basicpay desc) as rnum
from tblInsa;

--3. dense_rank() 함수 사용                    
select
    name, buseo, basicpay,
    dense_rank() over(order by basicpay desc) as rnum
from tblInsa;

-- 4. row_number() 사용
select
    name, buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;

---------------------- 급여 5위
-- 1. row_number() 사용 
select
    name, buseo, basicpay,
    row_number() over(order by basicpay desc) as rnum
from tblInsa;

select * 
from (select
            name, buseo, basicpay,
            row_number() over(order by basicpay desc) as rnum
        from tblInsa) where rnum = 5;

-- dense_rank() 사용
select * 
from (select
            name, buseo, basicpay,
            dense_rank() over(order by basicpay desc) as rnum
        from tblInsa) where rnum = 5;

-- rank over() 사용
select * 
from (select
            name, buseo, basicpay,
            rank() over(order by basicpay desc) as rnum
        from tblInsa) where rnum = 8;


select
    name, buseo, basicpay, sudang,
    rank() over(order by basicpay desc, sudang desc) as rnum
from tblInsa;

--------------------------------------------------------------------------
/*

    그룹별 순위 구하기
    - 순위 함수 + group by
    - partition by 사용 > 그룹으로 나누고, 그룹별로 순위를 매김

*/

-- 급여 + 순위
select
    name, buseo, basicpay
from tblInsa;

select
    name, buseo, basicpay,
    dense_rank() over (order by basicpay desc) as rnum
from tblInsa;

-- 부서별(급여 + 순위)
select
    name, buseo, basicpay,
    dense_rank() over (partition by buseo order by basicpay desc) as rnum
from tblInsa;

select
    name, buseo, basicpay,
    rank() over (partition by buseo order by basicpay desc) as rnum
from tblInsa;

select
    name, buseo, basicpay,
    row_number() over (partition by buseo order by basicpay desc) as rnum
from tblInsa;















