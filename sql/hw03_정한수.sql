use shoppingmall;
drop table user_table;
drop table buy_table;


create table user_table
(
userID CHAR(8) not null, # 사용자 ID
userName VARCHAR(10) not null, # 이름
birthYear int not null, # 출생년도
addr CHAR(2) not null, # 지역(경기,서울, 경남, 2 글자)
mobile1 CHAR(3), # 휴대폰 국번
mobile2 CHAR(8), # 휴대폰 나머지 전화번호 (하이픈 제외)
height smallint, # 키
mDate DATE, # 회원 가입일
constraint pk_user_table primary key (userID)
);


create table buy_table
(num INT auto_increment not null,  # 순번
userID CHAR(8) not null, # 아이디 (FK)
prodName CHAR(6) not null, # 물품명
groupName CHAR(4), # 분류
price INT not null, # 단가
amount SMALLINT not null, # 수량
constraint pk_buy_table primary key (num),
constraint fk_buy_table foreign key (userID)
references user_table(userID)
);


# 2. 1) call number
select u.userName, b.prodName, u.addr, concat(u.mobile1, u.mobile2) as 연락처
from user_table as u
inner join buy_table as b
on u.userID = b.userID;

#  2) userID가 KYM인 사람이 구매한 물건과 회원 정보 출력
select u.userID, u.userName, b.prodName, u.addr,  concat(u.mobile1, u.mobile2) as 연락처
from user_table as u
inner join buy_table as b
on u.userID = b.userID
where u.userID = 'KYM';

#  3) 전체 회원이 구매한 목록을 회원 아이디 순으로 정렬
select u.userID, u.userName, b.prodName, u.addr,  concat(u.mobile1, u.mobile2) as 연락처
from user_table as u
inner join buy_table as b
on u.userID = b.userID
order by u.userID;

#  4) 쇼핑몰에서 한 번이라도 구매한 기록이 있는 회원 정보를 회원 아이디 순으로 출력 (distinct 사용)
select distinct u.userID, u.userName, u.addr
from user_table as u
inner join buy_table as b
on u.userID = b.userID
order by u.userID;

#  5) 쇼핑몰 회원 중에서 주소가 경북과 경남인 회원 정보를 회원 아이디 순으로 출력
select u.userID , u.userName , u.addr ,concat(u.mobile1, u.mobile2) as 연락처
from user_table u
where u.addr in ('경북', '경남')
order by u.userID;
