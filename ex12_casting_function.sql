/*

    ex12_casting_function.sql
    
    형변환 함수
    - (int)num
    
    1. to_char(숫자) : 숫자 > 문자
    2. to_char(날짜) : 날짜 > 문자 *****
    3. to_number(문자) : 문자 > 숫자
    4. to_date(문자) : 문자 > 날짜 ********

*/

/*

    1. to_char(숫자, 형식문자열)
    
    형식문자열 구성요소
    a. 9 : 숫자 1개를 문자 1개로 바꾸는 역할. ex) '@' || to_char(weight, '99999') || '@', 5자리를 확보하는데 부족한 자리는 스페이스로 채움 > 빈자리를 스페이스로 치환 >%5d
    b. 0 : 숫자 1개를 문자 1개로 바꾸는 역할. ex) '@' || to_char(weight, '00000') || '@' 5자리를 확보하는데 부족한 자리는 0으로 채움 > 빈자리를 0으로 치환 > %05d
    c. $ : 통화 기호 표현
    d. L : 통화 기호 표현
    e. . : 소수점
    f. , : 천단위

*/

-- **** JAVA는 엄격한 언어 > 문법을 칼같이 준수 > 자료형
-- **** SQL은 유연한 언어 > 문법을 적당히 준수 > 자료형 > 암시적 형변환 잦음

select
    weight,                 -- 우측정렬(숫자)
    to_char(weight) ,      -- 좌측정렬(문자)
    
    length(weight),         -- length() 문자열 함수 > weight 숫자
    length(to_char(weight))
    
from tblComedian;

select 
    weight,
    '@' || to_char(weight) || '@',
    '@' || to_char(weight, '99999') || '@',
    '@' || to_char(weight,'00000') || '@'
from tblComedian;

select
    100,
    to_char(100, '$999'),
    to_char(100, 'L999'),
    to_char(100, '999') || '달러' ,
    to_char(100, '999') || '원'
from dual;

select
    1234567.89,
    to_char(1234567.89, '9,999,999.9') --%,d
from dual;

/*

    2. to_char(날짜)
    - 날짜 > 문자
    - char to_char(컬럼, 형식문자열)

    형식문자열 구성요소
    a. yyyy
    b. yy
    c. month
    d. mon
    e. mm
    f. day
    g. dy
    h. ddd
    i. dd
    j. d
    k. hh
    l. hh24
    m. mi
    n. ss
    o. am(pm)
*/

select sysdate from dual;
select to_char(sysdate) from dual;
select to_char(sysdate, 'yyyy') from dual;      -- 년 (4자리)      *****************
select to_char(sysdate, 'yy') from dual;         -- 년 (2자리)
select to_char(sysdate, 'month') from dual;    -- 월(풀네임)
select to_char(sysdate, 'mon') from dual;       --월(약어)
select to_char(sysdate, 'mm') from dual;        --월(2자리)      *****************
select to_char(sysdate, 'day') from dual;        --요일(풀네임)
select to_char(sysdate, 'dy') from dual;         --요일(약어)
select to_char(sysdate, 'ddd') from dual;       --일(올해의 며칠)
select to_char(sysdate, 'dd') from dual;        --일(이번달의 며칠)      *****************
select to_char(sysdate, 'd') from dual;          --일(이번주의 며칠) == 요일(숫자)
select to_char(sysdate, 'hh') from dual;        --시(12시간)
select to_char(sysdate, 'hh24') from dual;     --시(24시간)      *****************
select to_char(sysdate, 'mi') from dual;        --분      *****************
select to_char(sysdate, 'ss') from dual;        --초      *****************
select to_char(sysdate, 'am') from dual;       --오전/오후
select to_char(sysdate, 'pm') from dual;       --오전/오후

-- 암기@@@
select
    sysdate,
    to_char(sysdate, 'yyyy-mm-dd') as "일자",--2023-03-16
    to_char(sysdate, 'hh24:mi:ss'),
    to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
    to_char(sysdate, 'day am hh:mi:ss')
from dual;

-- 홍길동 98/10/11 1998-10-11 일요일 
select
    name, ibsadate,
    to_char(ibsadate, 'yyyy-mm-dd') as hire_date,
    to_char(ibsadate, 'day') as day,
    case
        when to_char(ibsadate, 'd') in ('1','7') then '휴일입사'
        else '평일입사'
    end
from tblInsa;

-- 날짜 상수
-- 입사날짜 > 2000년 이후
select * from tblInsa
    where ibsadate >= '2000-01-01'; -- '2000-01-01' > 문자열
    
-- 입사 날짜 > 2000년에
select * from tblInsa
    where ibsadate >= '2000-01-01 00:00:00' and ibsadate <= '2000-12-31 23:59:59'; -- 오답
    
-- 날짜 상수 > 자동으로 00:00:00 > 자정으로 세팅된다.

select * from tblInsa
    where to_char(ibsadate, 'yyyy') = '2000';
    
    
-- 3. to_number(문자)
select
    123,
    '123',
    to_number('123')
from dual;

select
    123*2,
    to_number('123') *2,
    '123' *2
from dual;

-- 4. to_date()
-- - 문자 > 날짜
-- - date to_date(컬럼, 형식문자열)

select
    sysdate,            --23/03/16
    '2023-03-16',      --2023-03-16 날짜 형 아님. 문자형임!! > 여기선 형변환 발생 X
    to_date('2023-03-16'), --23/03/16
    to_date('2023-03-16', 'yyyy-mm-dd'),
    to_date('20230316'),
    to_date('20230316', 'yyyymmdd'),
    to_date('2023/03/16'),
    to_date('2023/03/16', 'yyyy/mm/dd'),
    to_date('2023-03-16 15:28:25', 'yyyy-mm-dd hh24:mi:ss') --********************
from dual;

-- 2000년에 입사한 직원
select *
from tblInsa
    where ibsadate >= '2000-01-01' and ibsadate <= '2000-12-31'; -- 시분초가 명시가 안되어 있어서 누락이 있음
    
select * from tblinsa
    where ibsadate >= to_date('2000-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss')
        and ibsadate <= to_date('2000-12-31 23:59:59', 'yyyy-mm-dd hh24:mi:ss'); -- 시분초가 명시가 안되어 있어서 누락이 있음
    









