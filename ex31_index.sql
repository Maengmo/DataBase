/*

    ex31_index.sql
    
    인덱스, Index
    - 검색을 빠른 속도로 하기 위해서 사용하는 도구
    - 도서의 색인과 동일한 역할 > 수많은 내용 중 원하는 걸 빠르게 찾기 위한 도구
    - SQL 명령 처리 속도를 빠르게 하기 위해서, 특정 컬럼에 대해 생성되는 도구
    
    데이터베이스 상태
    - 테이블내의 레코드 순서는, 개발자가 원하는 정렬 상태가 아니다.
    - 어떤 데이터 검색 > 처음 ~ 끝까지 차례대로 검색 > Table Full Scan
    - 특정 컬럼 선택 > 별도의 테이블에 복사 > 미리 정렬(***) >> 인덱스
    
    인덱스 장단점
    - 장점 : 검색 처리 속도를 향상 시킨다.
    - 단점 : 너무 많은 인덱스 사용은 전체적인 DB 성능을 저하시킨다.
    
    자동으로 인덱스가 걸리는 컬럼
    1. primary key
    2. Unique
    - 테이블에서 PK 컬럼을 검색하는 속도   >>>   테이블에서 일반 컬럼을 검색하는 속도
    
    인덱스를 사용하는 경우
    1. 테이블에 데이터(행)가 많은 경우 
    2. where 절에 사용되는 횟수가 많은 컬럼에 적용(*********)
    3. join에 조건으로 사용되는 컬럼에 적용 > 복합인덱스(PK,FK)
    4. 인덱스의 손익 분기점 > 검색 결과가 10~15% 이하인 경우
    5. null을 포함하는 경우 > null 인덱스에서 제외
    
    인덱스를 사용하지 말아야 하는 경우
    1. 테이블에 데이터(행)가 적은 경우(의미없음)
    2. 인덱스의 손익분기점 > 검색 결과가 15% 이상일 경우
    3. 해당 테이블에 데이터 삽입/수정/삭제가 빈번할 경우(**********)

*/

create table tblIndex
as
select * from tblInsa;

select count(*) from tblIndex; --3,801,088 

insert into tblIndex select * from tblIndex;

-- 시간 확인
set timing on;

-- SQL 실행
-- 1. Ctrl + Enter > 결과 > 테이블 출력
-- 2. F5             > 결과 > 텍스트 출력
select * from tblInsa;

-- 인덱스 없이 검색
select distinct name from tblIndex where name = '홍길동';

-- name > 인덱스 생성 > 경과시간 : 23초 
create index idxName 
    on tblIndex(name);
    
-- 인덱스 검색 > 경과 시간 : 0.02초
select distinct name from tblIndex where name = '홍길동';

/*

    인덱스 종류
    1. 고유 인덱스
    2. 비고유 인덱스
    3. 단일 인덱스
    4. 복합 인덱스
    5. 함수기반 인덱스

*/
-- 고유 인덱스
-- : 색인의 값이 중복이 불가능하다.
-- : PK, Unique > 컬럼을 인덱스로 생성하면 고유 인덱스가 된다.

create unique index idxName on tblIndex(name);

-- 비고유 인덱스
-- : 색인의 값이 중복이 가능하다.
-- : 일반 컬럼

-- 단일 인덱스
-- : 컬럼 1개를 대상
create index idxBuseo on tblIndex(buseo);

select * from tblInsa;

select count(*) from tblIndex where buseo = '기획부';

select count(*) from tblIndex where name = '유관순' and buseo = '영업부';

select count(*) from tblIndex where jikwi = '부장' and name = '홍길동';

-- 복합 인덱스
-- : 검색을 2개 이상의 컬럼을 대상으로 할 때
create index idxNameBuseo on tblIndex(name, buseo); 

select count(*) from tblIndex where name = '유관순' and buseo = '영업부';
select count(*) from tblIndex where buseo = '영업부' and name= '유관순';

-- 함수 기반 인덱스
create index idxSsn on tblIndex(ssn);
create index idxSsn2 on tblIndex(substr(ssn, 8, 1));

select count(*) from tblIndex where substr(ssn, 8, 1) = '1';

















