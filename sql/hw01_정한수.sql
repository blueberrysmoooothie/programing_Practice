-- use testdb
-- drop table world; 
create table world
	(
	country VARCHAR(30),
	continent VARCHAR(30),
	area INT,
	population INT,
	capital VARCHAR(30),
	top_level_domain VARCHAR(3)
	);

insert into world 
(country, continent, area, population, capital, top_level_domain)
values('Afghanistan', 'Asia', 652230, 25500100, 'Kabul', '.af'),
('Algeria', 'Africa', 2381741, 38700000, 'Algiers', '.dz'),
('New Zealand', 'Oceania', 270467, 4538520, 'Wellington', '.nz'),
('Australia', 'Oceania', 7692024, 23545500, 'Canberra', '.au'),
('Brazil', 'South America', 8515767, 202794000, 'Brasilia', '.br'),
('China', 'Asia', 9596961, 1365370000, 'Beijing', '.cn'),
('India', 'Asia', 3166414, 1246160000, 'New Delhi', '.in'),
('Russia', 'Eurasia', 17125242, 146000000, 'Moscow', '.ru'),
('France', 'Europe', 640679, 65906000, 'Paris', '.fr'),
('Germany', 'Europe', 357114, 80716000, 'Berlin', '.de'),
('Denmark', 'Europe', 43094, 5634437, 'Copenhagen', '.dk'),
('Norway', 'Europe', 323802, 5124383, 'Oslo', '.no'),
('Sweden', 'Europe', 450295, 9675885, 'Stockholm', '.se'),
('South Korea', 'Asia', 100210, 50423955, 'Seoul', '.kr'),
('Canada', 'North America', 9984670, 35427524, 'Ottawa', '.ca'),
('United States', 'North America', 9826675, 318320000, 'Washington, D.C.', '.us'),
('Armenia', 'Eurasia', 29743, 3017400, 'Yerevan', '.am');

-- 1. 전체 테이블 내용 출력
select * from world;

-- 2. 유럽 국가의 country, capital, top_level_domain 컬럼만 출력
select country, capital, top_level_domain from world
where continent = 'Europe';

-- 3. 아시아 국가들의 인구수 내림 차순으로 country, population 컬럼을 출력
select country, population from world
where continent = 'Asia'
order by population desc;


