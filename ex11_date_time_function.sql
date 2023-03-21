/*

    ex11_date_time_function.sql
    
    날짜 시간 함수
    
    1. sysdate
    - 현재 시스템의 시각을 반환
    - 자바로 따지면, Calendar.getInstance()
    - date sysdate
    
    moths_between()
    
    add_months()

*/

select sysdate
from dual; --23/03/16 >2023-03-16

/*

    날짜 연산
    - +, -
    1. 시각 - 시각 = 시간(일)
    2. 시각 + 시간 = 시각
    3. 시각 - 시간 = 시각

*/

-- 1. 시각 - 시각 = 시간(일) 
select
    name,
    ibsadate,
    round(sysdate - ibsadate) as "근무일수",
    round((sysdate-ibsadate) / 365) as "근무년수", -- 사용 금지
    round((sysdate-ibsadate) * 24) as "근무시수",
    round((sysdate-ibsadate) * 24 * 60) as "근무분수",
    round((sysdate-ibsadate) * 24 * 60 * 60) as "근무초수"
from tblInsa;

-- ORA-00972: identifier is too long
select 
    title,
    adddate,
    completedate,
    round((completedate - adddate) *24, 1) as "실행하기까지걸린시간"
from tblTodo
    --where round((complete - adddate) *24, 1) <=1
    order by round((completedate - adddate) * 24, 1) desc;
    
-- 2. 시각 + 시간(일) = 시각
-- 3. 시각 - 시간(일) = 시각

select
    sysdate,
    sysdate + 100 as "100일 뒤",
    sysdate - 100 as "100일 전",
    sysdate + (3/24) as "3시간 후",
    sysdate + (5/24) as "5시간 전",
    sysdate + (30/60/24) as "30분 뒤"
from dual;

/*

    시각 - 시각 = 시간(일)
    
    months_between()
    - number moths_between(date, date)
    - 시각 - 시각 = 시간(월)
    
    add_months()
    - 현재 일 수 에서 한달을 더하는 것
    
*/
select
    name,
    round(sysdate - ibsadate) as "근무 일수",
    round((sysdate - ibsadate) / 365) as "근무년수", -- 신뢰 x
    round(months_between(sysdate, ibsadate)) as "근무월수", -- 신뢰 o
    months_between(sysdate, ibsadate) /12 as "근무년수" -- 신뢰 o
from tblInsa;

select
    sysdate,
    sysdate + 10, -- 10일 뒤
    sysdate + 30,
    add_months(sysdate, 1), -- 한달뒤
    add_months(sysdate, 3), -- 3개월 전
    add_months(sysdate, 36) -- 3년뒤
from dual;

/*

    시각 -시각
    1. 일, 시, 분, 초 > 연산자(-)
    2. 월, 년 > months_between()
    
    시각 +- 시간
    1. 일, 시, 분, 초 > 연산자(+,-)
    2. 월, 년 > add_months()

*/

-- employees

-- 1. 전체 이름(first_name + last_name)이 가장 긴 -> 짧은 사람 순으로 정렬해서 가져오기
--    > 컬럼 리스트 > fullname(first_name + last_name), length(fullname)
select first_name || last_name as "이름"
from employees
order by length(first_name || last_name) desc;
-- 2. 전체 이름(first_name + last_name)이 가장 긴 사람은 몇글자? 가장 짧은 사람은 몇글자? 평균 몇글자?
--    > 컬럼 리스트 > 숫자 3개 컬럼
select 
    length(max(first_name || last_name)) as "가장 긴 사람",
    length(min(first_name || last_name)) as "가장 짧은 사람",
    avg(length(first_name || last_name)) as "평균 글자"    
    
from employees;
-- 3. last_name이 4자인 사람들의 first_name을 가져오기
--    > 컬럼 리스트 > first_name, last_name
--    > 정렬(first_name, 오름차순)
select first_name
from employees
where length(last_name) = 4

-- decode

-- 4. tblInsa. 부장 몇명? 과장 몇명? 대리 몇명? 사원 몇명?
select 
  count(decode(jikwi, '부장', 1)) as "부장",
  count(decode(jikwi, '과장', 1)) as "과장",
  count(decode(jikwi, '대리', 1)) as "대리"
from tblInsa;
-- 5. tblInsa. 간부(부장, 과장) 몇명? 사원(대리, 사원) 몇명?
select 
  count(decode(jikwi, '부장', 1, '과장', 2)) as "간부",
  count(decode(jikwi, '대리', 1, '사원', 2)) as "사원"
from tblInsa;
-- 6. tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?
select 
    avg(case
        when buseo = '기획부' then basicpay
    end),
    avg(case
        when buseo = '영업부' then basicpay
    end),
    avg(case
        when buseo = '총무부' then basicpay
    end),
    avg(case
        when buseo = '개발부' then basicpay
    end)
from tblInsa;

-- 7. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생?
select *
from tblInsa;
select 
    min(case
        when ssn like '%-1%' then substr(ssn, 1, 2)
    end) as "남자나이많은사람",
    min(case
        when ssn like '%-2%' then substr(ssn, 1, 2)
    end) as "여자나이많은사람"
from tblInsa;














