/*

    SQL > 시퀄(sequel)

    ex18_subquery.sql

    Main Query
    - 여태까지의 SQL
    - 일반적인 SQL
    - 하나의 문장안에 하나의 select(insert, update, delete)로 구성된 쿼리
    
    Sub Query, 서브 쿼리, 부속 질의
    - 하나의 문장(select, insert, update, delete)안에 또 다른 문장(select)이 들어있는 쿼리
    - 하나의 select문 안에 들어있는 또 다른 select 문
    - 삽입 위치 > 거의 대다수의 절(select 절, from 절, where 절  < 자주 사용 :: 자주사용 안함 > group by 절, having 절, order by 절)
    
*/

-- tblCountry.  인구수가 가장 많은 나라의 이름?
select *
from tblCountry;

update tblCountry set population = 120060 where name = '중국';

select max(population) -- 인구수가 가장 많은 > 120660 
from tblCountry;
select name from tblCountry where population = 120660; --중국

-- 합치면
-- 장점
-- 1. 2개의 SQL > 1개의 SQL
-- 2. 변화에 강하다. (인구수 변동) > 개발자 편의성 향상
select name from tblCountry 
    where population = (select max(population) from tblCountry);

-- tblComedian. 체중이 가장 많이 나가는 사람의 이름?
select max(weight) from tblComedian;

select * from tblComedian
    where weight = (select max(weight) from tblComedian);
    
-- tblInsa. 급여 1등?
select max(basicpay) from tblInsa; -- 2650000

select * from tblInsa
    where basicpay = (select max(basicpay) from tblInsa);
    
-- tblInsa. 막내 직원? 이정석 05/09/26
select * from tblInsa where ibsadate = (select max(ibsadate) from tblInsa);

-- tblIsa. 왕고참? 김인수 95/02/23
select * from tblInsa where ibsadate = (select min(ibsadate) from tblInsa);

-- tblInsa. 평균 급여보다 더 많이 받는 직원?
select avg(basicpay) from tblInsa;

select * from tblInsa where basicpay >= (select avg(basicpay) from tblInsa);

-- tblInsa. '홍길동'보다 급여가 많은 직원?
select basicpay from tblInsa where name = '홍길동';

select * from tblInsa 
    where basicpay >= (select basicpay from tblInsa where name = '홍길동') and name <> '홍길동';
    
-- 서브 쿼리 삽입 위치
-- 1. 조건절

-- 2. 컬럼리스트

-- 3. from 절

-- 1. 조건절
-- : 비교 대상(비교값) 역할 > 값 
-- : where 절, having 절, case문

-- a. 반환값이 1행 1열 > 단일 값 반환 > 값 1개로 취급
-- b. 반환값이 N행 1열 > 다중 값 (같은 성질의 여러개의 데이터) 반환 > 값 N개로 취급
-- c. 반환값이 1행 N열 > 다중 값(서로 다른 성질의 여러개의 데이터) 반환 >
-- d. 반환값이 N행 N열 > 다중값 반환

-- a. 반환값이 1행 1열 > 단일 값 반환 > 값 1개로 취급
select * from tblInsa
    where basicpay >= (select avg(basicpay) from tblInsa);
    
-- b. 반환값이 N행 1열 > 다중값(같은 성질의 여러개의 데이터) 반환 > 값 N개로 취급

-- 급여가 260만원 이상 받는 직원이 근무하는 부서 직원 명단을 가져오시오. > 기획부 + 총무부
-- 01427. 00000 -  "single-row subquery returns more than one row"

select * from tblInsa
    -- where buseo(비교대상 1개) = 기획부, 총무부(비교대상 2개)
    -- where buseo = '기획부' or buseo = '총무부';
    -- where buseo in ('기획부', '총무부');  같은 성질의 N개의 데이터 > 열거형
    where buseo in (select buseo from tblInsa where basicpay >= 2600000);
    
    
-- b. 반환값이 N행 1열 > 다중 값 (같은 성질의 여러개의 데이터) 반환 > 값 N개로 취급  
-- '홍길동'과 같은 지역 + 같은 직위 > 소속 부서 직원 명단
select *from tblInsa where name = '홍길동';
select * from tblInsa where city='서울' and jikwi = '부장' ;

select city from tblInsa where name = '홍길동'; -- 서울
select jikwi from tblInsa where name = '홍길동'; --부장

select buseo from tblInsa
    where city = (select city from tblInsa where name = '홍길동')
        and jikwi = (select jikwi from tblInsa where name = '홍길동')
            and name <> '홍길동';

select * from tblInsa
    where buseo in (select buseo from tblInsa
    where city = (select city from tblInsa where name = '홍길동')
        and jikwi = (select jikwi from tblInsa where name = '홍길동')
            and name <> '홍길동');


-- c. 반환값이 1행 N열 > 다중 값(서로 다른 성질의 여러개의 데이터) 반환 >
-- '홍길동'과 같은 지역 + 같은 직위 > 어떤 직원들?
select city from tblInsa where name ='홍길동';
select jikwi from tblInsa where name = '홍길동';

select * from tblInsa where city = '서울' and jikwi = '부장';

select * from tblInsa
    where city = (select city from tblInsa where name ='홍길동')
        and jikwi = (select jikwi from tblInsa where name = '홍길동');
        
select * from tblInsa
    where (city, jikwi) = (select city, jikwi from tblInsa where name = '홍길동');
    
    
select * from tblAddressBook; 

select * from tblAddressBook
    where (gender, age, job) = (select gender, age, job
                                                                    from tblAddressBook where name = '기예주');
                                                                    
-- d. 반환값이 N행 N열 > 다중값 반환
-- 급여가 260만원 이상 받는 직원과 같은 부서 + 같은 지역에 있는 모든 직원?
select * from tblInsa where basicpay >= 2600000;

-- 서울 + 기획부 && 경남 + 총무부
select city, buseo from tblInsa where basicpay >= 2600000;

select * from tblInsa
    where (city, buseo) in (select city, buseo from tblInsa where basicpay >= 2600000);
    
select
    buseo,
    avg(basicpay)
from tblInsa
    group by buseo
        having avg(basicpay) >= (select avg(basicpay) from tblInsa where buseo = '개발부');
        

-- 2. 컬럼 리스트
-- : 단일 데이터(값) > 원자 값 > 관계형 데이터베이스 > 표 > 속성(컬럼)의 값은 원자값이어야한다.
-- a. 컬럼명
-- b. 상수
-- c. 연산
-- d. 함수

-- 컬럼리스트에서 서브쿼리를 사용하기
-- - 서브쿼리의 결과값이 반드시 1행 1열이어야 한다. > 스칼라 쿼리
-- - 정적 쿼리 > 모든 행에 동일한 값을 반환 > 사용 빈도 적음
-- - 상관 서브 쿼리 > ?? > 사용 빈도 높음
select 
    name as "컬럼",
    100 as "상수",
    basicpay + 100 as "연산",
    length(name) as "함수"
from tblInsa;

select 
    name,
    (select sysdate from dual) as "시간"
from tblInsa;

select
    name,
    (select basicpay from tblInsa where name = '홍길동')
from tblInsa;

select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa) as "평균 급여"
from tblInsa;


select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa b where b.buseo = a.buseo ) as "소속 부서 평균 급여"
from tblInsa a
    order by buseo asc, basicpay asc;

-- 식별자 정리
select * from tblInsa;

-- 현재 접속중인 계정명은 생략 가능하다.
select * from hr.tblInsa; -- 계정명(스키마).테이블명

select name, buseo, jikwi from hr.tblInsa;

select hr.tblInsa.name, hr.tblInsa.buseo, hr.tblInsa.jikwi from hr.tblInsa; -- FULL 

select *, sysdate from tblInsa;

-- 와일드카드(*)와 다른 컬럼을 동시에 가져오는 방법 > 테이블명.*
select tblInsa.*, sysdate from tblInsa;

-- 컬럼 별칭 > 유효한 이름을 만들기 위해서 + 의미있게
-- 테이블 별칭 > 최대한 줄여서 > 보통 알파벳 1글자로 적는다.

-- SQL의 별칭(Alias) > 별명(X), 개명(O) > 별칭 선언 이후의 단계에서는 원래 이름을 접근 불가능!!!!
select 
    i.*, sysdate as "시간"            -- 2. 이 단계에서는 tblInsa 인식 못함 > 대신 i로 접근
from tblInsa i;                         -- 1. 테이블 별칭

select
    name, buseo, basicpay,
    (select round(avg(basicpay)) from tblInsa where buseo = i.buseo) as "소속 부서 평균 급여"
from tblInsa i;

drop table tblMen;
drop table tblWomen;

CREATE TABLE tblmen
(
   name varchar2(30) primary key,
   age number not null,
   height number null,
   weight number null,
   couple varchar2(30) null
);

CREATE TABLE tblwomen
(
   name varchar2(30) primary key,
   age number not null,
   height number null,
   weight number null,
   couple varchar2(30) null
);


INSERT INTO tblmen VALUES ('홍길동', 25, 180, 70, '장도연');
INSERT INTO tblmen VALUES ('아무개', 22, 175, NULL, '이세영');
INSERT INTO tblmen VALUES ('하하하', 27, NULL, 80, NULL);
INSERT INTO tblmen VALUES ('무명씨', 21, 177, 72, NULL);
INSERT INTO tblmen VALUES ('유재석', 29, NULL, NULL, '김숙');
INSERT INTO tblmen VALUES ('박명수', 30, 170, NULL, '김지민');
INSERT INTO tblmen VALUES ('정준하', 31, 183, NULL, '신보라');
INSERT INTO tblmen VALUES ('정형돈', 28, NULL, 92, NULL);
INSERT INTO tblmen VALUES ('양세형', 22, 166, 55, '김민경');
INSERT INTO tblmen VALUES ('조세호', 24, 165, 58, '오나미');

INSERT INTO tblwomen VALUES ('박나래', 23, 150, 55, NULL);
INSERT INTO tblwomen VALUES ('장도연', 28, 177, 65, '홍길동');
INSERT INTO tblwomen VALUES ('김지민', 30, 160, NULL, '박명수');
INSERT INTO tblwomen VALUES ('김숙', 34, 158, NULL, '유재석');
INSERT INTO tblwomen VALUES ('오나미', 27, NULL, NULL, '조세호');
INSERT INTO tblwomen VALUES ('김민경', 22, 169, 88, '양세형');
INSERT INTO tblwomen VALUES ('홍현희', 20, 158, 75, NULL);
INSERT INTO tblwomen VALUES ('신보라', 26, 170, 60, '정준하');
INSERT INTO tblwomen VALUES ('이세영', 28, 163, NULL, '아무개');
INSERT INTO tblwomen VALUES ('신봉선', 27, 162, NULL, NULL);


COMMIT;

-- tblMen <-- (연인관계) --> tblWomen 
select * from tblMen;
select * from tblWomen;

-- 남자 명단(이름, 나이) 출력 > 여자친구가 있으면 여자친구(이름,나이)를 같이 출력하시오. 여자친구가 없으면 아무것도 출력하지마시오.
select
    name, age, couple,
    (select age from tblWomen where name = m.couple) as "여자친구 나이",
    (select name from tblWomen where name = m.couple) as "여자친구 이름"
from tblMen m;


-- 3. from 절
-- : 서브쿼리의 결과셋을 하나의 테이블이라고 생각하고, 또 다른 select를 실행
-- : 구문을 단순화하기 위해서 사용
select 
    * 
from (select * from tblInsa); --1. 

select 
    * --메인 쿼리의 모든 컬럼(name, buseo, jikwi)
from (select name, buseo, jikwi from tblInsa); 

select 
    -- name, ssn :  ssn은 불가능, 가져오질 않아서
    -- name : name -> 이름이라고 개명됐기 때문에 불가능
    이름
from (select name as 이름, buseo, jikwi from tblInsa);

select 
    name, len
from (select name, length(name) as len from tblInsa);

-- ORA-00918: column ambiguously defined > 동일한 컬럼명이 2개 이상 발견
select
    *
from (select name, age, couple, (select age from tblWomen where name = tblMen.couple) as age2 from tblMen);


-- employees. 'Munich'에 위치한 부서에 소속된 직원 명단?
select * from employees; --department_id 소속 부서
select * from departments; -- location_id 위치 정보
select * from locations;

select location_id from locations
    where city = 'Munich';
select department_id from departments
    where location_id = (select location_id from locations
    where city = 'Munich');

select * from employees
    where department_id in (select department_id from departments
        where location_id = (select location_id from locations
            where city = 'Seattle'));
            
--------------------------------------------------------문제 모음---------------
-- tblMen. tblWomen. 서로 짝이 있는 사람 중 남자와 여자의 정보를 모두 가져오시오. > select절
--    [남자]        [남자키]   [남자몸무게]     [여자]    [여자키]   [여자몸무게]
--    홍길동         180       70              장도연     177        65
--    아무개         175       null            이세영     163        null
--    ..
select * from tblMen;
select * from tblWomen;

select
    name, height, weight,
    (select height from tblWomen where name = m.couple) as "여자친구 키",
    (select name from tblWomen where name = m.couple) as "여자친구 이름",
    (select weight from tblWomen where name = m.couple) as "여자 몸무게"
from tblMen m;

-- tblAddressBook. 가장 많은 사람들이 가지고 있는 직업은 주로 어느 지역 태생(hometown)인가? > where절
select * from tblAddressBook;

select max(count(*)) from tblAddressBook group by job;

select job from tblAddressBook
    group by job
        having count(*) = (select max(count(*)) from tblAddressBook group by job);
        
select distinct hometown from tblAddressBook
    where job = (select job from tblAddressBook
    group by job
        having count(*) = (select max(count(*)) from tblAddressBook group by job));

-- tblAddressBook. 이메일 도메인들 중 평균 아이디 길이가 가장 긴 이메일 사이트의 도메인은 무엇인가? > group by + having
select 
    substr(email, instr(email, '@') +1) as "도메인",
    avg(length(substr(email, 1, instr(email, '@') -1))) as "평균 아이디 길이"
from tblAddressBook
    group by substr(email, instr(email, '@') +1)
        having avg(length(substr(email, 1, instr(email, '@') -1))) = 
        (select 
            max(avg(length(substr(email, 1, instr(email, '@') -1))))
        from tblAddressBook
            group by substr(email, instr(email, '@') +1));
    
select 
    max(avg(length(substr(email, 1, instr(email, '@') -1))))
from tblAddressBook
    group by substr(email, instr(email, '@') +1);




-- tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은? > where + group by + having
select * from tblAddressBook;

select 
    max(avg(age))
from tblAddressBook
    group by hometown;
    
select
    hometown
from tblAddressBook
    group by hometown
        having avg(age) = 
        (select 
            max(avg(age))
        from tblAddressBook
        group by hometown);
    

select 
    hometown,
    round(avg(age))
from tblAddressBook
    group by hometown
        having max(avg(age));

select 
        max(count(*))
from tblAddressBook
    where hometown = '광주'
        group by job;

select
    max(avg(age))
from tblAddressBook
    group by hometown; -- 38.6875

select
    hometown
from tblAddressBook
    group by hometown
        having avg(age) = (select
                                max(avg(age))
                            from tblAddressBook
                                group by hometown);

select
    max(count(*))
from tblAddressBook
    where hometown = '광주'
        group by job;

select
    job
from tblAddressBook
    where hometown = (select
                            hometown
                        from tblAddressBook
                            group by hometown
                                having avg(age) = (select
                                                        max(avg(age))
                                                    from tblAddressBook
                                                        group by hometown))
        group by job
            having count(*) = (select
                                    max(count(*))
                                from tblAddressBook
                                    where hometown = (select
                                                            hometown
                                                        from tblAddressBook
                                                            group by hometown
                                                                having avg(age) = (select
                                                                                        max(avg(age))
                                                                                    from tblAddressBook
                                                                                        group by hometown))
                                        group by job);



-- tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오. > where절
select * from tblAddressBook;
select 
    avg(age)
from tblAddressBook
    where gender = 'm';
    
select *
from tblAddressBook
    where job is not null;
    
select 
    name, job, hometown
from tblAddressBook
    where age > (select 
                            avg(age)
                        from tblAddressBook
                            where gender = 'm') and hometown = '서울' and job <> '백수';

-- tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오. > where절
select * from tblAddressBook;

select 
    gender, age
from tblAddressBook
    where substr(email, instr(email, '@') +1) = 'gmail.com';
    
select 
    count(case
        when gender = 'm' and age between 10 and 19 then 1 
    end) as "남자 10대",
    count(case
        when gender = 'f' and age between 10 and 19 then 1 
    end) as "여자 10대",
    count(case
        when gender = 'm' and age between 20 and 29 then 1 
    end) as "남자 20대",
    count(case
        when gender = 'f' and age between 20 and 29 then 1 
    end) as "여자 20대",
    count(case
        when gender = 'm' and age between 30 and 39 then 1 
    end) as "남자 30대",
    count(case
        when gender = 'f' and age between 30 and 39 then 1 
    end) as "여자 30대",
    count(case
        when gender = 'm' and age between 40 and 49 then 1 
    end) as "남자 40대",
    count(case
        when gender = 'f' and age between 40 and 49 then 1 
    end) as "여자 40대"
from (select 
            gender, age
        from tblAddressBook
            where substr(email, instr(email, '@') +1) = 'gmail.com');

-- tblAddressBook. 가장 나이가 많으면서 가장 몸무게가 많이 나가는 사람과 같은 직업을 가지는 사람들을 가져오시오. > where절
select * from tblAddressBook;

select 
    max(age)
from tblAddressBook;

select
    max(weight)
from tblAddressBook;

select
    job
from tblAddressBook
    where age = (select 
                            max(age)
                        from tblAddressBook) 
        and weight = (select
                            max(weight)
                        from tblAddressBook);



select *
from tblAddressBook
    where job = (select
                            job
                        from tblAddressBook
                            where age = (select 
                                                    max(age)
                                                from tblAddressBook) 
                                and weight = (select
                                                    max(weight)
                                                from tblAddressBook));
    

-- tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오. > where절
select * from tblAddressBook;

select 
    max(count(*))
from tblAddressBook
    group by name;


    
select 
    name
from tblAddressBook
    group by name
        having count(*) = (select 
                                    max(count(*))
                                from tblAddressBook
                                    group by name);
    
select *
from tblAddressBook
    where name = (select 
                            name
                        from tblAddressBook
                            group by name
                                having count(*) = (select 
                                                            max(count(*))
                                                        from tblAddressBook
                                                            group by name));

-- tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.> where + group by + having
--    [10대]       [20대]       [30대]       [40대]
--    8.7%        30.7%        28.3%        32.2%
SELECT 
    job,
    round(count(CASE
        when age between 10 and 19 then 1
    end)/count(*)*100,2)||'%' as "[10대]",
    round(count(CASE
        when age between 20 and 29 then 1
    end)/count(*)*100,2)||'%' as "[20대]",
    round(count(CASE
        when age between 30 and 39 then 1
    end)/count(*)*100,2)||'%' as "[30대]",
    round(count(CASE
        when age between 40 and 49 then 1
    end)/count(*)*100,2)||'%' as "[40대]"
FROM tbladdressbook group by job having count(job) = (SELECT max(count(job)) FROM tbladdressbook group by job);
    





