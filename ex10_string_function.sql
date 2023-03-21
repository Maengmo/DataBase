/*

    ex10_string_function.sql 

    문자열 함수

    upper(), lower(), initcap()
    - varchar2 upper(컬럼)
    - varchar2 lower(컬럼)
    - varchar2 initcap(컬럼)
    
    upper() : 대문자로 바꿔주는 함수
    lower() : 소문자로 바꿔주는 함수 
    initcap() : 첫 문자만 대문자 나머지는 소문자로 바꿔주는 함수
    
*/

select 
    first_name,
    upper(first_name),
    lower(first_name)
from employees;

select
    'abc', initcap('abc'), initcap('aBC') --Abc
from dual;

-- 이름에 'an' 포함된 직원 > 대소문자 구분없이
select first_name
    from employees
        where first_name like '%an%' or  first_name like '%An%' or  first_name like '%aN%' or  first_name like '%AN%';

select first_name
    from employees
        where lower(first_name) like '%an%';
        
/*

    substr()
    - 문자열 추출 함수
    - varchar2 substr(컬럼, 시작위치, 끝위치, 가져올 문자 개수)
    - varchar2 substr(컬럼, 시작위치)
    - *** SQL 인덱스 > 1부터 시작
*/

select
    title,
    substr(title, 3, 4),
    substr(title,3)
from tblTodo;

select
    name,
    substr(name, 1, 1) as "성",
    substr(name, 2) as "이름",
    ssn,
    substr(ssn, 1, 2) as "생년",
    substr(ssn, 3, 2) as "생월",
    substr(ssn, 5, 2) as "생일",
    substr(ssn, 8, 1) as "성별"
from tblInsa;

-- 김,  이, 박, 최, 정 > 몇명?
select
    count(case
        when substr(name, 1, 1) = '김' then 1
    end) as "김씨",
     count(case
        when substr(name, 1, 1) = '이' then 1
    end) as "이씨",
     count(case
        when substr(name, 1, 1) = '박' then 1
    end) as "박씨",
     count(case
        when substr(name, 1, 1) = '최' then 1
    end) as "최씨",
     count(case
        when substr(name, 1, 1) = '정' then 1
    end) as "정씨",
    count(case
        when substr(name, 1, 1)  not in ('김', '이', '박', '최', '정') then 1
    end) as "나머지 성씨"
from tblInsa;

select * from tblInsa
    where substr(ssn, 8, 1) = '2';

-- 남자 > 여자
select 
    name,
    ssn
from tblInsa
    order by case
        when ssn like '%-1%' then 1
        when ssn like '%-2%' then 2
    end;

select
*
from tblInsa
    order by substr(ssn, 8, 1);
    
/*

    length()
    - 문자열 길이
    - number length(컬럼)

*/

-- 컬럼 리스트에서 사용 
select name, length(name) from tblCountry;

-- 조건절에서 사용
select name, length(name) from tblCountry where length(name) > 3;
select name, length(name) from tblCountry where length(name) between 4 and 6;

-- 정렬에서 사용
select name, length(name) from tblCountry order by length(name) desc;

-- 게시판 제목 > 길면 > 잘라서 > 밑줄임표(..)
select
    title,
    case
        when length(title) >=8 then substr(title, 1, 8) || '..'
        else title
    end
from tblTodo;

/*

    instr()
    - 검색함수(indexOf)
    - 검색어의 위치를 반환
    - number instr(컬럼, 검색어)
    - number instr(컬럼, 검색어, 시작위치)
    - number instr(컬럼, 검색어, -1)
    - 못찾으면 0을 반환

*/

select 
    '안녕하세요. 홍길동님',
    instr('안녕하세요. 홍길동님', '홍길동') as r1, 
    instr('안녕하세요. 홍길동님', '아무개') as r2,
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동') as r3,
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동', 11) as r4,
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동',
        instr('안녕하세요. 홍길동님. 홍길동님', '홍길동') + length('홍길동')) as r5,
    instr('안녕하세요. 홍길동님. 홍길동님', '홍길동',-1) as r6
from dual; 

/*

    lpad(), rpad()
    - left padding, right padding
    - varchar2 lpad(컬럼, 개수, 문자)
    - varchar2 rpad(컬럼, 개수, 문자)
    -- 컬럼에 개수 만큼 자리를 확보하고 그 자리를 문자로 채움

*/

select
    'a',
    lpad('a', 5, 'b'),
    '1',
    lpad('1','3','0'),
    lpad('12','3','0'),
    lpad('123','3','0'),
    lpad('1234','3','0'),
    rpad('1','3','0')
from dual;

/*

    trim(), ltrim(), rtrim()
    - varchar2 trim(컬럼) : 양쪽 공백 제거
    - varchar2 ltrim(컬럼) : 왼쪽 공백 제거
    - varchar2 rtrim(컬럼) : 오른쪽 공백 제거

*/

select
    '       하나      둘       셋       ',
    trim('       하나      둘       셋       '),
    ltrim('       하나      둘       셋       '),
    rtrim('       하나      둘       셋       ')
from dual;

/*


    replace()
    - 문자열 치환
    - varchar2 replace(컬럼, 찾을 문자열, 바꿀 문자열)


*/
select
    replace('홍길동', '홍', '김'),
    replace('홍길동', '이', '김'),
    replace('홍길홍', '홍', '김')
from dual;

select
    name,
    continent,
    case
        when continent = 'AS' then '아시아'
        when continent = 'EU' then '유럽'
        when continent = 'AF' then '아프리카'
    end as c1,
    replace(replace(replace(continent, 'AS', '아시아'), 'EU', '유럽'),'AF','아프리카') as c2
from tblCountry;


/*

    decode()
    - 문자열 치환
    - replace와 비슷
    - varchar2 decode(컬럼, 찾을 문자열, 바꿀 문자열 [, 찾을 문자열, 바꿀 문자열] x N)
    - 문자열 조작 > case의 간단한 버전
    - 못찾으면 null을 반환함.(** = case와 비슷함)
    
*/

select 
    gender,
    case
        when gender = 'm' then '남자'
        when gender = 'f' then '여자'
    end as g1, 
    replace(replace(gender, 'm', '남자'), 'f', '여자') as g2,
    decode(gender, 'm', '남자','f','여자') as g3    
from tblComedian;

-- 남자 몇명? 여자 몇명?
select
    -- A. case 사용 
    count(case
        when gender = 'm' then 1
    end) as "남자인원",
    count(case
        when gender = 'f' then 1
    end) as "여자인원",
    -- B. decode 사용
    count(decode(gender, 'm', 1)) as "남자인원2",
    count(decode(gender, 'f' , 1)) as "여자인원2"
from tblComedian;









