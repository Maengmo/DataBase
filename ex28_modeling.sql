/*

    ex28_modeling.sql
    
    데이터베이스 설계  
    1. 요구사항 수집 및 분석
    2. 개념 데이터 모델링
    3. 논리 데이터 모델링
    4. 물리 데이터 모델링
    5. 데이터베이스 구축
    
    데이터 모델링
    - 요구 분석 기반 > 수집한 데이터 > 분석 > 저장 구조 생성 > 도식화 > ERD(산출물)
    - 데이터 저장하기 위한 데이터 구조를 설계하는 작업
    - DBMS 종류를 결정하지 않는다.
    - 개념 데이터 모델링 > 간단하게 표현한 설계도 > 테이블 + 컬럼 + 관계
    - 논리 데이터 모델링 > 관계형 데이터베이스 성질 반영 > 속성 + 도메인 + 키 > 제대로된 설계도
    - 물리 데이터 모델링 > 특정 DBMS 결정 > 오라클 선정 + 반영 > 물리적 설정..
    
    1. ERD, Entity Relationship Diagram
    - 엔티티간의 관계를 표현한 그림
    - 관계형 데이터베이스 모델링 기법 중 하나
    - 손, 오피스, 전문툴(exERD, ER-Win 등)
    
    2. Entity, 엔티티
    - 다른 Entity와 분류될 수 있고, 다른 Entity에 대해 정해진 관계를 맺을 수 있는 데이터 단위
    - 릴레이션 = 객체 = 레코드 = 엔티티 = 테이블(행)
        a. 학생 정보 관리
            - 정보 수집 : 아이디, 학생명, 나이, 주소, 연락처 ...
            - 학생(_아이디_, 학생명, 나이, 주소, 연락처)
            - 이때의 학생을 엔티티라고 부름.
            
        b. 강의실 정보 관리
            - 정보 수집 : 강의실 호수, 크기, 인원수, 용도, 면적 ...
            - 강의실(강의실 호수, 크기, 인원수)
            - 이때의 강의실을 엔티티라고 부름.
            
    3. Attribute, 속성
    - 엔티티를 구성하는 정보
    - 컬럼
    
    4. Entity relationship, 엔티티 관계
    - 학생(이름, 나이 ...)
    - 교사(이름, 담당과목..)
    - 학급(학년, 반..)
    - 학생 <-> 학급 <-> 교사
    
    
    ERD 그리는 방법 > Entity, Attribute, Relationship 등을 표현하는 방법
    
    1. Entity
    - 사각형 
    - 이름을 작성
    - ERD 내에 동일한 엔티티명 사용 금지
    
    2. Attribute
    - 동그라미
    - 엔티티에 연결
    - 추가 표기사항(속성에 대한 성질 기술)
        a. NN, Notnull
            - 해당 속성은 반드시 작성해야 한다.
            - 필수 값
            
        b. ND, NotDuplicate
            - 해당 속성은 중복될 수 없다.
            - 유일값(Unique)
            
        1. 중복되면 안되고, 생략되면 안된다.(NN(*), ND(#))
            - #*속성명
        2. 생략되면 안된다. (NN)
            - *속성명
        3. 중복되면 안된다. (ND)
            - #속성명
        4. 중복되고 되고, 생략되고 된다.
            - 속성명
            - o속성명
            - optional
    
    3. Relationship
    - 마름모
    - 엔티티와 엔티티의 관계
    - 가장 중요한 표현(****)
    - 관계의 패턴
    
        A엔티티 : B엔티티
        a. 1:1
            - 일대일 관계
        b. 1:N
            - 일대다 관계
        c. N:M
            - 다대다 관계
        
    ex) 비디오 대여점
        
        1. 엔티티 정의
            - 장르
            - 비디오
            - 회원
            
        2. 속성 정의
            
        3. 식별자 선언
            - 기본키
        ------------------------ 개념적 모델링
        
        4. 논리 모델링 > 논리 ERD
            - 1~3을 반복 > 전문적으로 그리기
        
        ------------------------ 논리 모델링
        
        5. 물리 데이터 모델링 > 오라클 맞게 구체적
            - 물리명(식별자) 생성 > name 
            - 자료형 > varchar2
            - 길이 > 30
            - 도메인 > 2자~5자 이내의 한글
            - 제약사항 생성
            
        --------------------------- 물리 모델링 
        
        모델링 작업 > ERD(논리,물리) > [정규화] > 안정성 높고, 효율적 구조로 변경 > ERD
        
        정규화, Normalization
        - 자료의 손실이나, 불필요한 정보를 없애고, 데이터의 일관성을 유지하며, 데이터 종속성을 최소화하기 위해 ERD를 수정하는 작업
        - 우리가 만든 테이블(ERD) > 비정형, 비정규화 상태 > 정규화 > 정규화된 구조 ERD
        - 제 1 정규화 > 제 2 정규화 > 제 3 정규화 ..
        - 제 1~3 정규화 
        
        관계형 데이터베이스 시스템이 지향하는 데이터베이스 상태
        1. 원자값을 가진다.
        2. 최대한 null을 가지지 않는다.
        3. 중복값을 가지지 않는다.
        
        이상 현상
        1. 삽입 이상, Insertion Anomaly
            - 테이블에 데이터를 삽일 할 때, 원하지 않는 데이터까지 같이 넣어야 하는 상황
        2. 갱신 이상, Update Anomaly
            - 동일한 데이터가 2개 이상의 테이블에 동시 존재 > 둘 중 1개만 수정 발생
                > 둘 중 어느 것이 올바른?
        3. 삭제 이상, Deletion Anomaly 
            - 테이블의 데이터를 삭제할 때, 원하지 않는 데이터까지 같이 지워야 하는 상황 
            
        함수 종속, Functional Dependency
        - 1개의 테이블 내 컬럼끼리의 관계 표현
        - *** 정규화란 '부분 함수 종속' 이나 '이행 함수 종속'을 모두 없애고, 모든 컬럼 관계를 '완전 함수 종속'으로 만드는 작업이다.
        
        1. 완전 함수 종속, Full Functional Dependency
        2. 부분 함수 종속, Partial Functional Dependency
        3. 이행 함수 종속, Transitive Functional Dependency
        
        정규화
        - 비정규화 > 정규화
        - 1NF > 2NF > 3NF (Normal Form)
        
        제 1 정규화, 1NF
        - 모든 컬럼(속성)은 원자값을 가진다.
        - 다중값(여러개로 분리 가능한 값)을 1개의 컬럼안에 넣지 않는다.
        - 다중값을 가지는 컬럼 찾기 > 없애는 작업 
        
        제 2 정규화, 2NF
        - 기본키(PK)가 아닌 모든 나머지 컬럼은 기본키에 완전 함수 종속이어야 한다.
        - 부분 함수 종속 검색!! > 부분 함수 종속 제거!!
        - 주로 복합키를 가지는 테이블에서 발견된다.
            - 일부 컬럼이 복합키 일부에만 종속되는 현상을 제거하는 정규화
            
        제 3 정규화, 3NF
        - 기본키(PK)가 아닌 모든 나머지 컬럼은 기본키에 완전 함수 종속이어야 한다.
        - 이행 함수 종속 검색!! > 이행 함수 종속 제거!!
        - 컬럼이 기본키가 아닌 다른 키에 종속되는 현상을 제거하는 정규화 
        - PK는 수정될 가능성이 있는 도메인을 사용하면 안된다.
        
        역정규화
        - 정규화된 결과를 다시 원래대로 되돌리는 작업
        - 2개 이상의 테이블 > 1개 테이블
        - 수업 중 사용 금지!!
        
        다중값 : 똑같은 값이 여러개의 값
        복합값 : 여러개의 값들이 하나의 값 
*/

-- 복합키 생성하기 + 사용하기 

-- 학생
create table tblStudent (
    seq number primary key,         -- 번호(PK)
    name varchar2(30) not null      -- 학생명
);

-- 과목
create table tblSubject (
    seq number primary key,         -- 번호(PK)
    name varchar2(30) not null       -- 과목명
);

-- 수강 신청
-- ORA-02260 : table can have only one primary key
create table tblRegister (

    -- 컬럼 수준에서는 복합키를 지정할 수 없다.
--    student_seq number primary key ,
--    subject_seq number primary key,
--    regdate date default sysdate

    student_seq number references tblStudent(seq),
    subject_seq number references tblSubject(seq),
    regdate date default sysdate,
    
    constraint register_pk primary key(student_seq, subject_seq) -- 복합키 선언

);

drop table tblRegister;

-- 성적
create table tblScore (
    seq number primary key,
    score number not null,
  
    -- 복합키를 참조하는 외래키는 컬럼 수준으로 선언할 수 없다.
    student_seq number,
    subject_seq number,
    
    constraint score_fk foreign key(student_seq, subject_seq) 
                references tblRegister(student_seq, subject_seq)
);

insert into tblStudent values (1, '홍길동');
insert into tblStudent values (2, '아무개');
insert into tblStudent values (3, '하하하');

insert into tblSubject values (1, '자바');
insert into tblSubject values (2, '오라클');
insert into tblSubject values (3, 'JDBC');
insert into tblSubject values (4, 'JSP');
insert into tblSubject values (5, 'Spring');

insert into tblRegister values (1, 1, sysdate);
insert into tblRegister values (1, 2, sysdate);
insert into tblRegister values (1, 3, sysdate);
insert into tblRegister values (2, 2, sysdate);
insert into tblRegister values (2, 4, sysdate);
insert into tblRegister values (2, 5, sysdate);
insert into tblRegister values (2, 1, sysdate);
insert into tblRegister values (3, 2, sysdate);
insert into tblRegister values (3, 5, sysdate);

insert into tblScore values (1, 100, 1, 1);
insert into tblScore values (2, 90,  1, 2);
insert into tblScore values (3, 80,  1, 3);
insert into tblScore values (4, 70,  2, 2);
insert into tblScore values (5, 60,  3, 2);

select * from tblStudent;
select * from tblSubject;
select * from tblRegister;
select * from tblScore;

-- 학생 + 과목 > 수강 신청 > 목록
select
    st.name as "학생명",
    sj.name as "과목명"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq;
                
-- 학생 + 과목 > 수강 신청 > 목록 + 성적
select
    st.name as "학생명",
    sj.name as "과목명",
    sc.score as "성적"
from tblStudent st
    inner join tblRegister r
        on st.seq = r.student_seq
            inner join tblSubject sj
                on sj.seq = r.subject_seq
                    left outer join tblScore sc
                        on r.student_seq = sc.student_seq and r.subject_seq = sc.subject_seq;


/*

    데이터 설계 > 
    
    네이버 영화(https://movie.naver.com) > 영화 랭킹
    
    - 모든 영화에 대한 정보(데이터) > 보고 이해!! + 분석!!
    
    1. 데이터 수집 + 분석
        - 데이터 인식 
        - 데이터베이스 저장할 데이터 선별
        
    2. ERD 작성 (main)
        a. 개념적 모델링 > 산출물(v)
        b. 논리 모델링 > 산출물(v)
        c. 물리 모델링 > 산출물(v)
    
    3. DDL 작성
        - create 문 작성
        a. 테이블
        b. 시퀀스
        c. 뷰
        - 스크립트 sql > 산출물(v)
    
    4. DML 작성
        - 데이터 추가
        - insert문
        - 스크립트 > 산출물(v)
        - 50편 영화
    
    5. select 문 > 검증용
          a. 조회수 순서대로 가져오시오.(순위, 영화명, 변동폭)
          b. '박성웅' 배우가 출연한 영화를 가져오시오.
          c. '김주환' 감독이 제작한 영화를 가져오시오.
          d. 남자들이 선호하는 영화를 가져오시오.
          e. 20대가 선호하는 영화를 가져오시오.
          f. '좋아요'를 20,000개 이상 받은 영화를 가져오시오.
          g. 한줄평 개수가 40,000개 이상 달린 영화를 가져오시오.
          h. 네티즌 관람객 평점이 4.5이상인 영화를 가져오시오.
          i. 영화의 명대사를 영화 제목과 함께 가져오시오.(명대사 배우명도 같이)
          j. 등록된 50개의 영화중 가장 많은 영화에 참여한 배우를 가져오시오.
          k. '드라마'와 '코미디' 2개 장르에 속한 영화를 가져오시오.
          l. 런타임이 120분 미만인 영화를 가져오시오.
          m. 성인 관람가 영화를 가져오시오.
          n. 누적 관객 100,000명이 넘는 영화를 가져오시오.

        

*/
















