/*

    ex23_pseudo.sql
    
    의사컬럼, Pseudo Column
    - 실제 컬럼이 아닌데 컬럼처럼 행동하는 요소
    
    rownum
    - 오라클 전용
    - row num > 행번호 > 레코드의 일련번호
    - from 절이 실행될 때 각 레코드에 일련번호를 할당한다. (******)
    - where 절의 영향을 받으면 일련번호를 다시 정비한다. (reindexing) (*****)
    - rownum을 사용 > 서브 쿼리를 자주 사용한다.

*/
select 
    name, buseo, -- 컬럼(속성) > output > 객체의 특성에 따라 다른 값을 가진다. (개인 데이터)
    sysdate,        -- 함수        > output > 모든 레코드가 동일한 값을 가진다. (정적 데이터)
    substr(name,2), -- 함수       > input + output > 객체마다 다른 값을 가진다.
    '상수',             -- 상수      > output > 모든 레코드가 동일한 값을 가진다. (정적 데이터)
    rownum          -- 의사 컬럼 > output > 객체의 특성에 따라 다른 값을 가진다. (개인 데이터)
from tblInsa;

-- 게시판 > 페이징
-- 1페이지 > rownum between 1 and 20
-- 2페이지 > rownum between 21 and 40
-- 3페이지 > rownum between 41 and 60

select name, buseo, rownum from tblInsa;
select name, buseo, rownum from tblInsa where rownum = 1; -- 위치로 검색
select name, buseo, rownum from tblInsa where rownum <= 5;

-- 안됌...
select name, buseo, rownum from tblInsa where rownum = 10; -- 김종서 영업부 10
select name, buseo, rownum from tblInsa where rownum > 5; -- 위치로 검색

select
    name, buseo, rownum
from tblInsa; --1. 이 시점의 데이터를 가지고 rownum이 이미 할당되어 있다.

select
    name, buseo, rownum       -- 3. 소비
from tblInsa                        -- 1. 생성(+rownum)
    where rownum = 1;          -- 2. 조건

select
    name, buseo, rownum       -- 3. 소비
from tblInsa                        -- 1. 생성(+rownum)
    where rownum = 3;          -- 2. 조건 : rownum을 조건으로 사용 > 반드시 1~조건 범위 > 조건에 포함!!(1부터 시작해야함)
    
    
-------------------
select
    name, buseo, basicpay, rownum
from tblInsa
    order by basicpay desc;
    
select name, buseo, basicpay, rownum, rnum -- 바깥쪽의 rownum이 안쪽 rownum을 덮어쓰기
from (select
            name, buseo, basicpay, rownum as rnum
        from tblInsa
            order by basicpay desc)
                where rownum <=5;
                
-- 인구수가 가장 많은 나라 1~3등
select * from tblCountry;

-- 1. 원하는 정렬
select * from tblCountry where population is not null order by population desc;
select rownum from tblCountry where population is not null order by population desc;

-- 2. 위의 결과셋을 가지고 한번 더 rownum을 만들기 > from 절 실행
select * from (select * from tblCountry where population is not null order by population desc)
    where rownum <=3;
    
-- tblInsa 급여가 3등

-- 1. 급여 순으로 정렬
select * from tblInsa order by basicpay desc;

-- 2. 원하는 순서대로 정렬 결과셋 > from 절 적용 > rownum을 다시 매긴다.
select * from (select * from tblInsa order by basicpay desc)
    where rownum <=3;
    
-- 3등인 사람을 찾는다.
-- 아래와 같이 사용하면, null값이 나온다.
select a.*, rownum from (select * from tblInsa order by basicpay desc) a where rownum = 3;

--3. 한번 더 서브쿼리 > rownum 고정 > 자유롭게 조건 사용!
select * from (select a.*, rownum as rnum from (select * from tblInsa order by basicpay desc) a)
    where rnum = 3;
    
--------------------------------
-- tblComedian. 5번째 뚱뚱한 사람?

-- 1. 정렬
select * from tblComedian order by weight desc;

-- 2. 서브쿼리 > rownum 별칭
select a.*, rownum as rnum from (select * from tblComedian order by weight desc) a;

-- 3. 서브쿼리 >rownum 고정시키기 위해서
select * from (select a.*, rownum as rnum from (select * from tblComedian order by weight desc) a)
    where rnum = 5;

------------- 요구사항 모음 ----------------------
-- 1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-1%' order by (basicpay+sudang) asc;

select a.*, rownum as "순위"
    from (select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-1%' order by (basicpay+sudang) asc) a;

-- 2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select a.*, rownum as "순위"
    from (select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-2%' order by (basicpay+sudang) desc) a;

-- 3. tblInsa. 여자 인원수가 (가장 많은 부서 및 인원수) 가져오시오.
select * from tblInsa;

select buseo, count(*) as "여자 인원수" from tblInsa where ssn like '%-2%' group by buseo order by count(*) desc;

select a.*, rownum as rank from (select buseo, count(*) as "여자 인원수" from tblInsa where ssn like '%-2%' group by buseo order by count(*) desc) a;

select * from (select a.*, rownum as rank from (select buseo, count(*) as "여자 인원수" from tblInsa where ssn like '%-2%' group by buseo order by count(*) desc) a)
    where rank = 1;


-- 4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)
select * from tblInsa;

select city, count(*) as "지역별 인원수" from tblInsa group by city order by count(*) desc;

select a.*, rownum as "순위" from (select city, count(*) as "지역별 인원수" from tblInsa group by city order by count(*) desc) a;

-- 5. tblInsa. 부서별 인원수가 가장 많은 부서 및원수 출력.
select * from tblInsa;

select buseo, count(*) as "부서별 인원수" from tblInsa group by buseo order by count(*) desc;

select a.*, rownum as rank from (select buseo, count(*) as "부서별 인원수" from tblInsa group by buseo order by count(*) desc) a;

select * from (select a.*, rownum as rank from (select buseo, count(*) as "부서별 인원수" from tblInsa group by buseo order by count(*) desc) a)
    where rank = 1;

-- 6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select * from tblInsa;

select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc;

select a.*, rownum as rank
    from (select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a;
    
select * from (select a.*, rownum as rank
                 from (select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a)
                    where rank between 3 and 5;

-- 7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.
select * from tblInsa;

select * from tblInsa order by ibsadate asc;

select a.*, rownum as rank from (select * from tblInsa order by ibsadate asc) a;

select * from (select a.*, rownum as rank from (select * from tblInsa order by ibsadate asc) a)
    where rank <= 5;

-- 8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.
select * from tblhousekeeping;

select item, (price*qty) as "지출 내역" from tblhousekeeping order by (price*qty) desc;

select a.*, rownum as rank from (select item, (price*qty) as "지출 내역" from tblhousekeeping order by (price*qty) desc) a;

select * from (select a.*, rownum as rank from (select item, (price*qty) as "지출 내역" from tblhousekeeping order by (price*qty) desc) a)
    where rank <= 3;

-- 9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.
select * from tblInsa;

select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc;

select a.*, rownum as rank from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc) a;

select buseo from (select a.*, rownum as rank from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc) a)
    where rank = 2;
    
select * from tblInsa where buseo = (select buseo from (select a.*, rownum as rank from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc) a)
    where rank = 2);

-- 10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.
select * from tbltodo;

select title ,(completedate - adddate) as "완료까지" from tbltodo where completedate is not null order by (completedate - adddate) asc;

select a.*, rownum from (select title ,(completedate - adddate) as "완료까지" from tbltodo where completedate is not null order by (completedate - adddate) asc) a;

select * from (select a.*, rownum as rank from (select title ,(completedate - adddate) as "완료까지" from tbltodo where completedate is not null order by (completedate - adddate) asc) a)
    where rank <=5;

-- 11. tblinsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 급여 차액은 얼마인가?
select * from tblInsa;

select a.*, rownum as rank
    from (select name, buseo, jikwi, (basicpay+sudang) as "급여" from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a;
    
select sum from (select a.*, rownum as rank
                    from (select name, buseo, jikwi, (basicpay+sudang) as sum from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a)
                        where rank in (3);

select * from (select a.*, rownum as rank
                    from (select name, buseo, jikwi, (basicpay+sudang) as sum from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a)
                        where rank in (9);

select name,buseo,jikwi,sum,rank,
(select sum from (select a.*, rownum as rank
                    from (select name, buseo, jikwi, (basicpay+sudang) as sum from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a)
                        where rank in (3) )
-
(select sum from (select a.*, rownum as rank
                    from (select name, buseo, jikwi, (basicpay+sudang) as sum from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a)
                        where rank in (9)) as "3위와 9위의 차"
from (select a.*, rownum as rank
                    from (select name, buseo, jikwi, (basicpay+sudang) as sum from tblInsa where ssn like '%-1%' order by (basicpay+sudang) desc) a)
                        where rank in (3,9);


