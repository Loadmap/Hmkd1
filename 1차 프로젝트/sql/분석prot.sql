select * from purprod;
select * from prodcl;
select * from channel;
select * from membership;
select * from demo;
select * from compet;

drop table purprod0;
create table purprod0 as
select 제휴사, 영수증번호, 대분류코드, 중분류코드, 소분류코드, 고객번호, 점포코드, 구매일자, 
    substr(구매일자, 1, 4) as year_pur, substr(구매일자, 5, 2) as month_pur, 구매시간, 구매금액
from purprod
order by 제휴사, 고객번호;

select * from purprod0;

select sum(구매금액)
from purprod0;
select sum(계절성)
from purprod0;

--1.060566469	1.02302403	1.099409925	0.854675523
--1.028415938, 1.023806951, 1.092005222, 0.880950461
--0.239504654	0.24427764	0.228185959	0.288031748
--1.043821054	1.023425642	1.095597648	0.867959876
select 
     round((nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 계절성 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 계절성 end), 0))/
     sum(구매금액), 9) as q1,
     round((nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 계절성 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 계절성 end), 0))/
     sum(구매금액), 9) as q2,
     round((nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 계절성 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 계절성 end), 0))/
     sum(구매금액), 9) as q3,
     round((nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 계절성 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 계절성 end), 0))/
     sum(구매금액), 9) as q4     
from purprod0
order by 고객번호;

select 
    (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0)) as q1
from purprod0;

select
    (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0))
     +(sum(구매금액)/4*
     (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0))/
     sum(구매금액))) as q1,
     (nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0))
     +(sum(구매금액)/4*
     (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0))/
     sum(구매금액))) as q2,
     (nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0))
     +(sum(구매금액)/4*
     (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0))/
     sum(구매금액))) as q3,
     (nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0))
     -(sum(구매금액)/4*
     (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0))/
     sum(구매금액))) as q4
     
from purprod0;


select 
     round(0.25 / ((nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0))/
     sum(구매금액)), 9) as q1,
     round(0.25 / ((nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0))/
     sum(구매금액)), 9) as q2,
     round(0.25 / ((nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0))/
     sum(구매금액)), 9) as q3,
     round(0.25 / ((nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0)+
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0))/
     sum(구매금액)), 9) as q4     
from purprod0
order by 고객번호;


create table purprod0 as
select *
from purprod;

alter table purprod0
add(계절성 NUMBER(38));

alter table purprod0
drop column 계절성;

update purprod0 
set 계절성 = case
    when (year_pur = 2014 AND month_pur BETWEEN 01 AND 03) THEN round(구매금액 * 1.01095526348798337298006670657258000073)
    when (year_pur = 2014 AND month_pur BETWEEN 04 AND 06) THEN round(구매금액 * 1.00585641041640893800603876840975143483)
    when (year_pur = 2014 AND month_pur BETWEEN 07 AND 09) THEN round(구매금액 * 1.02389941189179883653144287227632846787)
    when (year_pur = 2014 AND month_pur BETWEEN 10 AND 12) THEN round(구매금액 * 0.9669899689858096086987385523431673501305)
    when (year_pur = 2015 AND month_pur BETWEEN 01 AND 03) THEN round(구매금액 * 1.01095526348798337298006670657258000073)
    when (year_pur = 2015 AND month_pur BETWEEN 04 AND 06) THEN round(구매금액 * 1.00585641041640893800603876840975143483)
    when (year_pur = 2015 AND month_pur BETWEEN 07 AND 09) THEN round(구매금액 * 1.02389941189179883653144287227632846787)
    when (year_pur = 2015 AND month_pur BETWEEN 10 AND 12) THEN round(구매금액 * 0.9669899689858096086987385523431673501305)
end
;

drop table purprod1;
create table purprod1 as
select 제휴사, 영수증번호, 대분류코드, 중분류코드, 소분류코드, 고객번호, 점포코드, 구매일자, 
    year_pur, month_pur, 구매시간, 구매금액,
    case
        when (year_pur = 2014 AND month_pur BETWEEN 01 AND 03) THEN round(구매금액 * 1.01095526348798337298006670657258000073)
        when (year_pur = 2014 AND month_pur BETWEEN 04 AND 06) THEN round(구매금액 * 1.00585641041640893800603876840975143483)
        when (year_pur = 2014 AND month_pur BETWEEN 07 AND 09) THEN round(구매금액 * 1.02389941189179883653144287227632846787)
        when (year_pur = 2014 AND month_pur BETWEEN 10 AND 12) THEN round(구매금액 * 0.9669899689858096086987385523431673501305)
        when (year_pur = 2015 AND month_pur BETWEEN 01 AND 03) THEN round(구매금액 * 1.01095526348798337298006670657258000073)
        when (year_pur = 2015 AND month_pur BETWEEN 04 AND 06) THEN round(구매금액 * 1.00585641041640893800603876840975143483)
        when (year_pur = 2015 AND month_pur BETWEEN 07 AND 09) THEN round(구매금액 * 1.02389941189179883653144287227632846787)
        when (year_pur = 2015 AND month_pur BETWEEN 10 AND 12) THEN round(구매금액 * 0.9669899689858096086987385523431673501305)
    end as 계절성
from purprod0
order by 제휴사, 고객번호;

select
    (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0)) /
    sum(구매금액))) as q1,
    
    (nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0)) /
    sum(구매금액))) as q2,
    
    (nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0)) /
    sum(구매금액))) as q3,
    
    (nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0)) /
    sum(구매금액))) as q4
from purprod0;

--163925626332.3125	166349178499.0625	158178396551.5625	188565955558.0625

--1.01095526348798337298006670657258000073	
--1.00585641041640893800603876840975143483	
--1.02389941189179883653144287227632846787	
--0.9669899689858096086987385523431673501305
select
    ((nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0)) /
    sum(구매금액)))) / 
    (nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0)) as q1,
    
    ((nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0)) /
    sum(구매금액)))) / 
    (nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0)) as q2,
    
    ((nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0)) /
    sum(구매금액)))) / 
    (nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0)) as q3,
    
    ((nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0)) +
    (sum(구매금액) / 4 * 
    (0.25 - (nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0)) /
    sum(구매금액)))) / 
    (nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) +
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0)) as q4 
from purprod0;


select * from purprod0;

--14년도 15년도 총매출
select sum(case when year_pur = 2014 then 구매금액 end) as 총금액14,
    sum(case when year_pur = 2015 then 구매금액 end)as 총금액15
from purprod0;

-- 14년도 에서 15년도 까지의 고객별 분기 매출액--
--14 15 분기별 총금액
with 분기14 as(
select 고객번호,
    nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) as q1,
    nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) as q2,
    nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) as q3,
    nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) as q4
from purprod0
group by 고객번호
order by 고객번호
),
분기15 as(
select 고객번호,
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0) as q5,
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0) as q6,
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0) as q7,
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0) as q8
from purprod0
group by 고객번호
order by 고객번호
)
select q14.고객번호, 
    q14.q1, 
    q14.q2, 
    q14.q3, 
    q14.q4, 
    q15.q5, 
    q15.q6, 
    q15.q7,
    q15.q8
    
from 분기14 q14
join 분기15 q15 on q14.고객번호 = q15.고객번호;

--14년도 에서 15년도 각 고객별 분기 매출액 차이--
--14
drop table cus_q_14;
create table cus_q_14 as
select 고객번호,
    nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 계절성 end), 0) as q1,
    nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 계절성 end), 0) as q2,
    nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 계절성 end), 0) as q3,
    nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 계절성 end), 0) as q4
from purprod0
group by 고객번호
order by 고객번호;

select * from cus_q_14;

--15
drop table cus_q_15;
create table cus_q_15 as
select 고객번호,
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 계절성 end), 0) as q5,
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 계절성 end), 0) as q6,
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 계절성 end), 0) as q7,
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 계절성 end), 0) as q8
from purprod0
group by 고객번호
order by 고객번호;

select * from cus_q_15;

select c14.*, q5, q6, q7, q8 
from cus_q_14 c14
join cus_q_15 c15 on c14.고객번호 = c15.고객번호
where q1 = 0 or q2 = 0 or q3 = 0 or q4= 0 or q5 = 0 or q6 = 0 or q7 = 0 or q8= 0;

--14 15차이
drop table cus_q_diff;
create table cus_q_diff as
select q14.고객번호, 
    q14.q2-q14.q1 AS q2_diff, 
    q14.q3-q14.q2 AS q3_diff, 
    q14.q4-q14.q3 AS q4_diff, 
    q15.q5-q14.q4 AS q5_diff, 
    q15.q6-q15.q5 AS q6_diff, 
    q15.q7-q15.q6 AS q7_diff, 
    q15.q8-q15.q7 AS q8_diff,
    (q14.q2-q14.q1) + (q14.q3-q14.q2) + (q14.q4-q14.q3) + (q15.q5-q14.q4) + 
    (q15.q6-q15.q5) + (q15.q7-q15.q6) + (q15.q8-q15.q7) as 구매차이합,
    (case when((q14.q2-q14.q1) + (q14.q3-q14.q2) + (q14.q4-q14.q3) + (q15.q5-q14.q4) + 
    (q15.q6-q15.q5) + (q15.q7-q15.q6) + (q15.q8-q15.q7)) < 0 then 1 else 0 end) as 구매감소여부
from cus_q_14 q14
join cus_q_15 q15 on q14.고객번호 = q15.고객번호;

with 분기14 as(
select 고객번호,
    nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then 구매금액 end), 0) as q1,
    nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then 구매금액 end), 0) as q2,
    nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then 구매금액 end), 0) as q3,
    nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then 구매금액 end), 0) as q4
from purprod0
group by 고객번호
order by 고객번호
),
분기15 as(
select 고객번호,
     nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then 구매금액 end), 0) as q5,
     nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then 구매금액 end), 0) as q6,
     nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then 구매금액 end), 0) as q7,
     nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then 구매금액 end), 0) as q8
from purprod0
group by 고객번호
order by 고객번호
)
select q14.고객번호, 
    q14.q2-q14.q1 AS q2_diff, 
    q14.q3-q14.q2 AS q3_diff, 
    q14.q4-q14.q3 AS q4_diff, 
    q15.q5-q14.q4 AS q5_diff, 
    q15.q6-q15.q5 AS q6_diff, 
    q15.q7-q15.q6 AS q7_diff, 
    q15.q8-q15.q7 AS q8_diff,
    (q14.q2-q14.q1) + (q14.q3-q14.q2) + (q14.q4-q14.q3) + (q15.q5-q14.q4) + 
    (q15.q6-q15.q5) + (q15.q7-q15.q6) + (q15.q8-q15.q7) as 구매차이합,
    (case when((q14.q2-q14.q1) + (q14.q3-q14.q2) + (q14.q4-q14.q3) + (q15.q5-q14.q4) + 
    (q15.q6-q15.q5) + (q15.q7-q15.q6) + (q15.q8-q15.q7)) < 0 then 1 else 0 end) as 구매감소여부
from 분기14 q14
full join 분기15 q15 on q14.고객번호 = q15.고객번호;

select * from cus_q_14;
select * from cus_q_15;
select * from cus_q_diff;
select * from purprod0;

--구매감소고객과 구매증가고객의 인원수와 금액
drop table updown;
create table updown as
select count(case when 구매감소여부 = 1 then 고객번호 end) as 구매감소고객,
    count(case when 구매감소여부 = 0 then 고객번호 end) as 구매증가고객,
    nvl(sum(case when 구매감소여부 = 1 then -구매차이합 end), 0) as 구매감소금액,
    nvl(sum(case when 구매감소여부 = 0 then 구매차이합 end), 0) as 구매증가금액,
    round(nvl(sum(case when 구매감소여부 = 1 then -구매차이합 end), 0) /
    nvl(sum(case when 구매감소여부 = 0 then 구매차이합 end), 0), 4) * 100 as 퍼센트
from cus_q_diff;

select * from updown;

-- 최대값, 최소값
SELECT
  MAX(CASE WHEN 구매감소여부 = 0 THEN 구매차이합 END) AS 상승_최대값,
  MIN(CASE WHEN 구매감소여부 = 0 THEN 구매차이합 END) AS 상승_최소값,
  MAX(CASE WHEN 구매감소여부 = 1 THEN 구매차이합 END) AS 하락_최대값,
  MIN(CASE WHEN 구매감소여부 = 1 THEN 구매차이합 END) AS 하락_최소값  
FROM cus_q_diff;

관리등급
--drop table lowrank;
--create table lowrank as
--select 고객번호, 
--    nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) as 구매감소금액,
--    CASE
--      WHEN nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <= -(SELECT SUM(구매차이합) FROM cus_q_diff where 구매감소여부 = 1) * (4/5) THEN 1
--      WHEN nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <= -(SELECT SUM(구매차이합) FROM cus_q_diff where 구매감소여부 = 1) * (3/5) THEN 2
--      WHEN nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <= -(SELECT SUM(구매차이합) FROM cus_q_diff where 구매감소여부 = 1) * (2/5) THEN 3
--      WHEN nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <= -(SELECT SUM(구매차이합) FROM cus_q_diff where 구매감소여부 = 1) * (1/5) THEN 4
--      ELSE 5
--    END as 관리등급
--from cus_q_diff
--where nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <> 0
--order by 관리등급;

--drop table lowrank;
--create table lowrank as
--select 고객번호, 
--    nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) as 구매감소금액,
--    ntile(10) over (order by 구매차이합) as 관리등급
--from cus_q_diff
--where nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <> 0
--order by 고객번호;

--drop table uprank;
--create table uprank as
--select 고객번호, 
--    nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) as 구매증가금액,
--    CASE
--      WHEN nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) >= 100000000 THEN 1
--      WHEN nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) >= 50000000 THEN 2
--      WHEN nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) >= 10000000 THEN 3
--      WHEN nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) >= 5000000 THEN 4
--      ELSE 5
--    END as 관리등급
--from cus_q_diff
--where nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) <> 0
--order by 고객번호;

--drop table uprank;
--create table uprank as
--select 고객번호, 
--    nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) as 구매증가금액,
--    ntile(10) over (order by 구매차이합 desc) as 관리등급
--from cus_q_diff
--where nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) <> 0
--order by 고객번호;

--select * 
--from lowrank
--order by 구매감소금액;
--
--select * from uprank;
--
--등급 정보
drop table lowdata;
create table lowdata as
select
    count(case when 관리등급 = 1 then 고객번호 end) as 등급1인원,
    count(case when 관리등급 = 2 then 고객번호 end) as 등급2인원,
    count(case when 관리등급 = 3 then 고객번호 end) as 등급3인원,
    count(case when 관리등급 = 4 then 고객번호 end) as 등급4인원,
    count(case when 관리등급 = 5 then 고객번호 end) as 등급5인원,
    sum(case when 관리등급 = 1 then -구매감소금액 end) as 등급1,
    sum(case when 관리등급 = 2 then -구매감소금액 end) as 등급2,
    sum(case when 관리등급 = 3 then -구매감소금액 end) as 등급3,
    sum(case when 관리등급 = 4 then -구매감소금액 end) as 등급4,
    sum(case when 관리등급 = 5 then -구매감소금액 end) as 등급5,
    round(sum(case when 관리등급 = 1 then 구매감소금액 end) / sum(구매감소금액), 4) * 100 as 퍼센트1등급,
    round(sum(case when 관리등급 = 2 then 구매감소금액 end) / sum(구매감소금액), 4) * 100 as 퍼센트2등급,
    round(sum(case when 관리등급 = 3 then 구매감소금액 end) / sum(구매감소금액), 4) * 100 as 퍼센트3등급,
    round(sum(case when 관리등급 = 4 then 구매감소금액 end) / sum(구매감소금액), 4) * 100 as 퍼센트4등급,
    round(sum(case when 관리등급 = 5 then 구매감소금액 end) / sum(구매감소금액), 4) * 100 as 퍼센트5등급,
    -round(sum(case when 관리등급 = 1 then 구매감소금액 end) / count(case when 관리등급 = 1 then 고객번호 end), 2) as 인당평균1등급,
    -round(sum(case when 관리등급 = 2 then 구매감소금액 end) / count(case when 관리등급 = 2 then 고객번호 end), 2) as 인당평균2등급,
    -round(sum(case when 관리등급 = 3 then 구매감소금액 end) / count(case when 관리등급 = 3 then 고객번호 end), 2) as 인당평균3등급,
    -round(sum(case when 관리등급 = 4 then 구매감소금액 end) / count(case when 관리등급 = 4 then 고객번호 end), 2) as 인당평균4등급,
    -round(sum(case when 관리등급 = 5 then 구매감소금액 end) / count(case when 관리등급 = 5 then 고객번호 end), 2) as 인당평균5등급
from lowrank
;

drop table updata;
create table updata as
select
    count(case when 관리등급 = 1 then 고객번호 end) as 등급1인원,
    count(case when 관리등급 = 2 then 고객번호 end) as 등급2인원,
    count(case when 관리등급 = 3 then 고객번호 end) as 등급3인원,
    count(case when 관리등급 = 4 then 고객번호 end) as 등급4인원,
    count(case when 관리등급 = 5 then 고객번호 end) as 등급5인원,
    sum(case when 관리등급 = 1 then 구매증가금액 end) as 등급1,
    sum(case when 관리등급 = 2 then 구매증가금액 end) as 등급2,
    sum(case when 관리등급 = 3 then 구매증가금액 end) as 등급3,
    sum(case when 관리등급 = 4 then 구매증가금액 end) as 등급4,
    sum(case when 관리등급 = 5 then 구매증가금액 end) as 등급5,
    round(sum(case when 관리등급 = 1 then 구매증가금액 end) / sum(구매증가금액), 4) * 100 as 퍼센트1등급,
    round(sum(case when 관리등급 = 2 then 구매증가금액 end) / sum(구매증가금액), 4) * 100 as 퍼센트2등급,
    round(sum(case when 관리등급 = 3 then 구매증가금액 end) / sum(구매증가금액), 4) * 100 as 퍼센트3등급,
    round(sum(case when 관리등급 = 4 then 구매증가금액 end) / sum(구매증가금액), 4) * 100 as 퍼센트4등급,
    round(sum(case when 관리등급 = 5 then 구매증가금액 end) / sum(구매증가금액), 4) * 100 as 퍼센트5등급,
    round(sum(case when 관리등급 = 1 then 구매증가금액 end) / count(case when 관리등급 = 1 then 고객번호 end), 2) as 인당평균1등급,
    round(sum(case when 관리등급 = 2 then 구매증가금액 end) / count(case when 관리등급 = 2 then 고객번호 end), 2) as 인당평균2등급,
    round(sum(case when 관리등급 = 3 then 구매증가금액 end) / count(case when 관리등급 = 3 then 고객번호 end), 2) as 인당평균3등급,
    round(sum(case when 관리등급 = 4 then 구매증가금액 end) / count(case when 관리등급 = 4 then 고객번호 end), 2) as 인당평균4등급,
    round(sum(case when 관리등급 = 5 then 구매증가금액 end) / count(case when 관리등급 = 5 then 고객번호 end), 2) as 인당평균5등급
from uprank
;

select * from lowdata;
select * from updata;
--
--select 고객번호, 구매감소금액, 관리등급
--from lowrank
--order by 구매감소금액;
--
--select 고객번호, 구매증가금액, 관리등급
--from uprank
--order by 구매증가금액 desc;

--구매감소금액의 매출영향
drop table purprod1;
create table purprod1 as
select 고객번호, sum(계절성) as 총금액
from purprod0
group by 고객번호;

select * from purprod1;

select 
    sum(case when l.관리등급 = 1 then -l.구매감소금액 end) +
    sum(case when l.관리등급 = 2 then -l.구매감소금액 end) as 상위등급감소금액,
    sum(case when u.관리등급 = 1 then u.구매증가금액 end) +
    sum(case when u.관리등급 = 2 then u.구매증가금액 end) as 상위등급증가금액,
    nvl(sum(case when c.구매감소여부 = 1 then -c.구매차이합 end), 0) as 구매감소금액,
    nvl(sum(case when c.구매감소여부 = 0 then c.구매차이합 end), 0) as 구매증가금액,
    sum(pu.총금액) as 총금액,
    round((sum(case when l.관리등급 = 1 then -l.구매감소금액 end) +
    sum(case when l.관리등급 = 2 then -l.구매감소금액 end)) /
    sum(pu.총금액), 4) * 100 as 상위등급매출영향1,
    round((sum(case when u.관리등급 = 1 then u.구매증가금액 end) +
    sum(case when u.관리등급 = 2 then u.구매증가금액 end)) /
    sum(pu.총금액), 4) * 100 as 상위등급매출영향2,
    round(nvl(sum(case when c.구매감소여부 = 1 then -c.구매차이합 end), 0) /
    sum(pu.총금액), 4) * 100  as 매출영향1,
    round(nvl(sum(case when c.구매감소여부 = 0 then c.구매차이합 end), 0) /
    sum(pu.총금액), 4) * 100  as 매출영향2
from cus_q_diff c
full join purprod1 pu on c.고객번호 = pu.고객번호
full join lowrank l on c.고객번호 = l.고객번호
full join uprank u on c.고객번호 = u.고객번호;


--등급
with 
    cus_sale as(
    select 고객번호, 
        nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) as 구매차이합, 
        row_number() over (order by nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0)) as 정렬
    from cus_q_diff
    where nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <> 0
    ),
    
    cum_sale as(
    select 고객번호, 구매차이합,
        sum(구매차이합) over (order by 정렬) as 누적합
    from cus_sale
    ),
    
    total as (
    select
        (sum(nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0)) / 5) as 총합
    from cus_q_diff
    ),
    
    rank0 as (
    select 
        고객번호,
        구매차이합,
        누적합,
        case
         when 누적합 >= 총합 then 1
         else floor((누적합 - 총합) / 총합) + 2
        end as rank0
    from total, cum_sale
)

select
    고객번호, 구매차이합, 누적합, rank0
from rank0;

drop table low_cus_sale;
create table low_cus_sale as
select 고객번호, 
    nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) as 구매감소금액, 
    row_number() over (order by nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0)) as 정렬
from cus_q_diff
where nvl((case when 구매감소여부 = 1 then 구매차이합 end), 0) <> 0;

drop table up_cus_sale;
create table up_cus_sale as
select 고객번호, 
    nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) as 구매증가금액, 
    row_number() over (order by nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) desc) as 정렬
from cus_q_diff
where nvl((case when 구매감소여부 = 0 then 구매차이합 end), 0) <> 0;

select * from low_cus_sale;
select * from up_cus_sale;

drop table lowrank;
create table lowrank as
select 고객번호, 구매감소금액,
    sum(구매감소금액) over (order by 정렬) as 누적합,
    case
        when sum(구매감소금액) over (order by 정렬) >= (select sum(구매감소금액) from low_cus_sale) / 5 then 1
        else floor(((sum(구매감소금액) over (order by 정렬)) - ((select sum(구매감소금액) from low_cus_sale) / 5)) / 
        ((select sum(구매감소금액) from low_cus_sale) / 5)) + 2
    end as 관리등급
from low_cus_sale;

drop table uprank;
create table uprank as
select 고객번호, 구매증가금액,
    sum(구매증가금액) over (order by 정렬) as 누적합,
    case
        when sum(구매증가금액) over (order by 정렬) <= (select sum(구매증가금액) from up_cus_sale) / 5 then 1
        else floor(((sum(구매증가금액) over (order by 정렬)) - ((select sum(구매증가금액) from up_cus_sale) / 5)) / 
        ((select sum(구매증가금액) from up_cus_sale) / 5)) + 2
    end as 관리등급
from up_cus_sale;

select * from lowrank;
select * from uprank;
select * from lowdata;
select * from updata;

--b2b
select pu.*, p.중분류명, p.소분류명
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
;

select *
from purprod0
where 고객번호 = 07957
order by 구매일자;

select 고객번호, year_pur, month_pur, count(고객번호), 구매금액
from purprod0
where 소분류코드 = 'A010101'
group by 고객번호, year_pur, month_pur, 구매금액;

create table com_a as
select pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명, 
    sum(pu.구매금액) as 합계, round(avg(pu.구매금액)) as 평균
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
group by pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명
order by pu.제휴사, pu.중분류코드, pu.소분류코드;

drop table com_a;
create table com_a as
select pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명, 
    sum(pu.구매금액) as 합계, round(avg(pu.구매금액)) as 평균
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
where pu.제휴사 = 'A'
group by pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명
order by pu.제휴사, pu.중분류코드, pu.소분류코드;

drop table com_b;
create table com_b as
select pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명, 
    sum(pu.구매금액) as 합계, round(avg(pu.구매금액)) as 평균
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
where pu.제휴사 = 'B'
group by pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명
order by pu.제휴사, pu.중분류코드, pu.소분류코드;

drop table com_c;
create table com_c as
select pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명, 
    sum(pu.구매금액) as 합계, round(avg(pu.구매금액)) as 평균
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
where pu.제휴사 = 'C'
group by pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명
order by pu.제휴사, pu.중분류코드, pu.소분류코드;

drop table com_d;
create table com_d as
select pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명, 
    sum(pu.구매금액) as 합계, round(avg(pu.구매금액)) as 평균
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
where pu.제휴사 = 'D'
group by pu.제휴사, pu.중분류코드, p.중분류명, pu.소분류코드, p.소분류명
order by pu.제휴사, pu.중분류코드, pu.소분류코드;

select * from com_a;
select * from com_b;
select * from com_c;
select * from com_d;

select 중분류명, count(중분류명)
from com_b
group by 중분류명
order by 중분류명;

drop table total_code;
create table total_code as
select a.제휴사 as 제휴사a, a.중분류코드 as 중분류코드a, a.중분류명 as 중분류명a, a.소분류코드 as 소분류코드a, a.소분류명 as 소분류명a,
    b.제휴사 as 제휴사b, b.중분류코드 as 중분류코드b, b.중분류명 as 중분류명b, b.소분류코드 as 소분류코드b, b.소분류명 as 소분류명b,
    c.제휴사 as 제휴사c, c.중분류코드 as 중분류코드c, c.중분류명 as 중분류명c, c.소분류코드 as 소분류코드c, c.소분류명 as 소분류명c,
    d.제휴사 as 제휴사d, d.중분류코드 as 중분류코드d, d.중분류명 as 중분류명d, d.소분류코드 as 소분류코드d, d.소분류명 as 소분류명d
from com_a a
full outer join com_b b on a.소분류명 = b.소분류명
full outer join com_c c on a.소분류명 = c.소분류명
full outer join com_d d on a.소분류명 = d.소분류명
order by a.제휴사, a.중분류코드;

    
select pu.고객번호, p.중분류코드, p.중분류명, p.소분류코드, p.소분류명,
    count(case when (year_pur = 2014 and month_pur between 01 and 03) then p.소분류코드 end) as q1_14,
    count(case when (year_pur = 2014 and month_pur between 04 and 06) then p.소분류코드 end) as q2_14,
    count(case when (year_pur = 2014 and month_pur between 07 and 09) then p.소분류코드 end) as q3_14,
    count(case when (year_pur = 2014 and month_pur between 10 and 12) then p.소분류코드 end) as q4_14,
    count(case when (year_pur = 2015 and month_pur between 01 and 03) then p.소분류코드 end) as q1_15,
    count(case when (year_pur = 2015 and month_pur between 04 and 06) then p.소분류코드 end) as q2_15,
    count(case when (year_pur = 2015 and month_pur between 07 and 09) then p.소분류코드 end) as q3_15,
    count(case when (year_pur = 2015 and month_pur between 10 and 12) then p.소분류코드 end) as q4_15,
    nvl(sum(pu.구매금액), 0), round(nvl(avg(pu.구매금액), 0), 2)
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
group by pu.고객번호, p.중분류코드, p.중분류명, p.소분류코드, p.소분류명
having 
    count(case when (year_pur = 2014 and month_pur between 01 and 03) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2014 and month_pur between 04 and 06) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2014 and month_pur between 07 and 09) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2014 and month_pur between 10 and 12) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2015 and month_pur between 01 and 03) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2015 and month_pur between 04 and 06) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2015 and month_pur between 07 and 09) then p.소분류코드 end) >= 30 or
    count(case when (year_pur = 2015 and month_pur between 10 and 12) then p.소분류코드 end) >= 30
order by nvl(sum(pu.구매금액), 0) desc, pu.고객번호, p.중분류코드;

--연속구매 
--19383명(677019156941), 18866(668,434,841,645) : 517(8584610682), 
--517 = 141(3258138612):73(1082825324):44(1562024708):14(51392240):14(264667484):8(72482159):3(831759):0 
--> 297(6292362286) : 220(2292248396)
select
    pu.고객번호,
    count(case when (year_pur = 2014 and month_pur between 01 and 03) then p.소분류코드 end) as q1_14,
    count(case when (year_pur = 2014 and month_pur between 04 and 06) then p.소분류코드 end) as q2_14,
    count(case when (year_pur = 2014 and month_pur between 07 and 09) then p.소분류코드 end) as q3_14,
    count(case when (year_pur = 2014 and month_pur between 10 and 12) then p.소분류코드 end) as q4_14,
    count(case when (year_pur = 2015 and month_pur between 01 and 03) then p.소분류코드 end) as q1_15,
    count(case when (year_pur = 2015 and month_pur between 04 and 06) then p.소분류코드 end) as q2_15,
    count(case when (year_pur = 2015 and month_pur between 07 and 09) then p.소분류코드 end) as q3_15,
    count(case when (year_pur = 2015 and month_pur between 10 and 12) then p.소분류코드 end) as q4_15,
    sum(pu.계절성)
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
group by pu.고객번호
having 
    count(case when (year_pur = 2014 and month_pur between 01 and 03) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2014 and month_pur between 04 and 06) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2014 and month_pur between 07 and 09) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2014 and month_pur between 10 and 12) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2015 and month_pur between 01 and 03) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2015 and month_pur between 04 and 06) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2015 and month_pur between 07 and 09) then p.소분류코드 end) = 0 or
    count(case when (year_pur = 2015 and month_pur between 10 and 12) then p.소분류코드 end) = 0 
order by sum(pu.계절성) desc;

--
select 고객번호, min(구매일자), max(구매일자)
from purprod0
group by 고객번호
order by 고객번호;

--
select 고객번호, 중분류코드, 소분류코드, round(avg(계절성)) as p_avg 
from purprod0 
group by 고객번호, 중분류코드, 소분류코드 
order by 고객번호, round(avg(계절성)) desc;

drop table b2b_prot0;
create table b2b_prot0 as
select pu.고객번호, pu.중분류코드, pu.소분류코드, p.소분류명, 
    count(case when (year_pur = 2014 and month_pur between 01 and 03) then pu.고객번호 end) as q14_1,
    count(case when (year_pur = 2014 and month_pur between 04 and 06) then pu.고객번호 end) as q14_2,
    count(case when (year_pur = 2014 and month_pur between 07 and 09) then pu.고객번호 end) as q14_3,
    count(case when (year_pur = 2014 and month_pur between 10 and 12) then pu.고객번호 end) as q14_4,
    count(case when (year_pur = 2015 and month_pur between 01 and 03) then pu.고객번호 end) as q15_1,
    count(case when (year_pur = 2015 and month_pur between 04 and 06) then pu.고객번호 end) as q15_2,
    count(case when (year_pur = 2015 and month_pur between 07 and 09) then pu.고객번호 end) as q15_3,
    count(case when (year_pur = 2015 and month_pur between 10 and 12) then pu.고객번호 end) as q15_4,
    
    nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then pu.계절성 end), 0) as q14_1p,
    nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then pu.계절성 end), 0) as q14_2p,
    nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then pu.계절성 end), 0) as q14_3p,
    nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then pu.계절성 end), 0) as q14_4p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then pu.계절성 end), 0) as q15_1p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then pu.계절성 end), 0) as q15_2p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then pu.계절성 end), 0) as q15_3p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then pu.계절성 end), 0) as q15_4p,
    sum(pu.계절성) as 총구매액,
    round(avg(pu.계절성)) as 평균금액,
    ROW_NUMBER() OVER (PARTITION BY pu.고객번호 ORDER BY sum(pu.계절성) desc) AS row_num
from purprod0 pu
join prodcl p on pu.제휴사 = p.제휴사 and pu.중분류코드 = p.중분류코드 and pu.소분류코드 = p.소분류코드
group by pu.고객번호, p.중분류명, p.소분류명, pu.중분류코드, pu.소분류코드
having round(avg(pu.계절성)) * 2 < sum(pu.계절성)
order by pu.고객번호, sum(pu.계절성) desc;

drop table b2b_prot1;
create table b2b_prot1 as
select pu.고객번호, pu.소분류코드, t.통합코드, t.임의분류명, t.소비재, t.소분류명, 
    count(case when (year_pur = 2014 and month_pur between 01 and 03) then pu.고객번호 end) as q14_1,
    count(case when (year_pur = 2014 and month_pur between 04 and 06) then pu.고객번호 end) as q14_2,
    count(case when (year_pur = 2014 and month_pur between 07 and 09) then pu.고객번호 end) as q14_3,
    count(case when (year_pur = 2014 and month_pur between 10 and 12) then pu.고객번호 end) as q14_4,
    count(case when (year_pur = 2015 and month_pur between 01 and 03) then pu.고객번호 end) as q15_1,
    count(case when (year_pur = 2015 and month_pur between 04 and 06) then pu.고객번호 end) as q15_2,
    count(case when (year_pur = 2015 and month_pur between 07 and 09) then pu.고객번호 end) as q15_3,
    count(case when (year_pur = 2015 and month_pur between 10 and 12) then pu.고객번호 end) as q15_4,
    
    nvl(sum(case when (year_pur = 2014 and month_pur between 01 and 03) then pu.계절성 end), 0) as q14_1p,
    nvl(sum(case when (year_pur = 2014 and month_pur between 04 and 06) then pu.계절성 end), 0) as q14_2p,
    nvl(sum(case when (year_pur = 2014 and month_pur between 07 and 09) then pu.계절성 end), 0) as q14_3p,
    nvl(sum(case when (year_pur = 2014 and month_pur between 10 and 12) then pu.계절성 end), 0) as q14_4p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 01 and 03) then pu.계절성 end), 0) as q15_1p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 04 and 06) then pu.계절성 end), 0) as q15_2p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 07 and 09) then pu.계절성 end), 0) as q15_3p,
    nvl(sum(case when (year_pur = 2015 and month_pur between 10 and 12) then pu.계절성 end), 0) as q15_4p,
    sum(pu.계절성) as 총구매액,
    round(avg(pu.계절성)) as 평균금액,
    ROW_NUMBER() OVER (PARTITION BY pu.고객번호 ORDER BY sum(pu.계절성) desc) AS row_num
from purprod0 pu
join total_code0 t on pu.중분류코드 = t.중분류코드 and pu.소분류코드 = t.소분류코드
group by pu.고객번호, pu.소분류코드, t.통합코드, t.임의분류명, t.소비재, t.소분류명
having round(avg(pu.계절성)) * 2 < sum(pu.계절성)
order by pu.고객번호, sum(pu.계절성) desc;

select * from  b2b_prot1
where 임의분류명 = '가공식품' and 고객번호 = 1 and q14_1p <>0;

select *
from b2b_prot1 
where row_num = 1
;


select pu.중분류코드, pu.소분류코드, t.임의코드, round(avg(pu.계절성))
from purprod0 pu
join total_code0 t on pu.중분류코드 = t.중분류코드 and pu.소분류코드 = t.소분류코드
group by pu.중분류코드, pu.소분류코드, t.임의코드
order by pu.소분류코드;

--통합코드
drop table total_code;
create table total_code as
select 중분류코드, 중분류명, 소분류코드, 소분류명, 임의코드, 임의분류명, 소비재 
from pro_a
union
select 중분류코드, 중분류명, 소분류코드, 소분류명, 임의코드, 임의분류명, 소비재
from pro_b
union
select 중분류코드, 중분류명, 소분류코드, 소분류명, 임의코드, 임의이름, 소비재
from pro_c
union 
select 중분류코드, 중분류명, 소분류코드, 소분류명, 임의코드, 임의분류명, 소비재
from pro_d;

select * from total_code;

drop table total_code0;
create table total_code0 as
select 중분류코드, 중분류명, 소분류코드, 소분류명, 임의코드, 임의분류명, 소비재, substr(임의코드, 2,2) as 통합코드 
from total_code
order by 소분류코드, 통합코드;

select * from total_code0; 

--마스터데이터

drop table pro_pur;
create table pro_pur as
 select pu.고객번호, t.임의분류명,
    case
        when year_pur = 2014 and month_pur between 01 and 03 then 'q14_1' 
        when year_pur = 2014 and month_pur between 04 and 06 then 'q14_2' 
        when year_pur = 2014 and month_pur between 07 and 09 then 'q14_3' 
        when year_pur = 2014 and month_pur between 10 and 12 then 'q14_4' 
        when year_pur = 2015 and month_pur between 01 and 03 then 'q15_1' 
        when year_pur = 2015 and month_pur between 04 and 06 then 'q15_2' 
        when year_pur = 2015 and month_pur between 07 and 09 then 'q15_3'
        when year_pur = 2015 and month_pur between 10 and 12 then 'q15_4' 
    end as 분기,
    sum(계절성) as 구매총액
 from purprod0 pu
 join total_code0 t on pu.소분류코드 = t.소분류코드
 group by pu.고객번호, t.임의분류명,
    case
        when year_pur = 2014 and month_pur between 01 and 03 then 'q14_1' 
        when year_pur = 2014 and month_pur between 04 and 06 then 'q14_2' 
        when year_pur = 2014 and month_pur between 07 and 09 then 'q14_3' 
        when year_pur = 2014 and month_pur between 10 and 12 then 'q14_4' 
        when year_pur = 2015 and month_pur between 01 and 03 then 'q15_1' 
        when year_pur = 2015 and month_pur between 04 and 06 then 'q15_2' 
        when year_pur = 2015 and month_pur between 07 and 09 then 'q15_3'
        when year_pur = 2015 and month_pur between 10 and 12 then 'q15_4' 
    end
 order by pu.고객번호;
 
--excel
select * from pro_pur order by 고객번호;
 
select 고객번호, 구매총액
from pro_pur
where 임의분류명 = '가공식품' and 분기 = 'q14_1'
;

drop table pro_pur;
create table pro_pur as
select pu.고객번호, 
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 가공q14_1,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 가공q14_2,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 가공q14_3,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 가공q14_4,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 가공q15_1,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 가공q15_2,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 가공q15_3,
    nvl(sum(case when t.임의분류명 = '가공식품' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 가공q15_4,
    
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 신선q14_1,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 신선q14_2,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 신선q14_3,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 신선q14_4,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 신선q15_1,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 신선q15_2,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 신선q15_3,
    nvl(sum(case when t.임의분류명 = '신선식품' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 신선q15_4,
    
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 일상q14_1,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 일상q14_2,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 일상q14_3,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 일상q14_4,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 일상q15_1,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 일상q15_2,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 일상q15_3,
    nvl(sum(case when t.임의분류명 = '일상용품' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 일상q15_4,
    
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 의약q14_1,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 의약q14_2,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 의약q14_3,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 의약q14_4,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 의약q15_1,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 의약q15_2,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 의약q15_3,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 의약q15_4,
    
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 교육q14_1,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 교육q14_2,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 교육q14_3,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 교육q14_4,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 교육q15_1,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 교육q15_2,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 교육q15_3,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 교육q15_4,
    
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 디지털q14_1,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 디지털q14_2,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 디지털q14_3,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 디지털q14_4,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 디지털q15_1,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 디지털q15_2,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 디지털q15_3,
    nvl(sum(case when t.임의분류명 = '디지털/가전' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 디지털q15_4,
    
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 가구q14_1,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 가구q14_2,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 가구q14_3,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 가구q14_4,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 가구q15_1,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 가구q15_2,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 가구q15_3,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 가구q15_4,
    
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 의류q14_1,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 의류q14_2,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 의류q14_3,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 의류q14_4,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 의류q15_1,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 의류q15_2,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 의류q15_3,
    nvl(sum(case when t.임의분류명 = '의류' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 의류q15_4,
    
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 전문스포츠q14_1,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 전문스포츠q14_2,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 전문스포츠q14_3,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 전문스포츠q14_4,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 전문스포츠q15_1,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 전문스포츠q15_2,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 전문스포츠q15_3,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 전문스포츠q15_4,
    
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 패션잡화q14_1,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 패션잡화q14_2,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 패션잡화q14_3,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 패션잡화q14_4,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 패션잡화q15_1,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 패션잡화q15_2,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 패션잡화q15_3,
    nvl(sum(case when t.임의분류명 = '패션잡화' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 패션잡화q15_4,
    
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 명품q14_1,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 명품q14_2,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 명품q14_3,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 명품q14_4,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 명품q15_1,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 명품q15_2,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 명품q15_3,
    nvl(sum(case when t.임의분류명 = '명품' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 명품q15_4,
    
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 기타q14_1,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 기타q14_2,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 기타q14_3,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 기타q14_4,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 기타q15_1,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 기타q15_2,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 기타q15_3,
    nvl(sum(case when t.임의분류명 = '기타' and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 기타q15_4
          
from purprod0 pu
join total_code0 t on pu.소분류코드 = t.소분류코드
group by pu.고객번호
order by pu.고객번호;

--
select *
from total_code0;

select pu.고객번호,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2014 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 가공q14_1,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2014 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 가공q14_2,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2014 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 가공q14_3,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2014 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 가공q14_4,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2015 and pu.month_pur between 01 and 03 then pu.계절성 end), 0) as 가공q15_1,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2015 and pu.month_pur between 04 and 06 then pu.계절성 end), 0) as 가공q15_2,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2015 and pu.month_pur between 07 and 09 then pu.계절성 end), 0) as 가공q15_3,
    nvl(sum(case when t.통합코드 = 01 and pu.year_pur = 2015 and pu.month_pur between 10 and 12 then pu.계절성 end), 0) as 가공q15_4
from purprod0 pu
join total_code0 t on pu.중분류코드 = t.중분류코드 and pu.소분류코드 = t.소분류코드
group by pu.고객번호
order by pu.고객번호
;

select pu.고객번호,
    nvl(sum(case when t.통합코드 = 01 then pu.계절성 end), 0) as 가공
from purprod0 pu
join total_code0 t on pu.중분류코드 = t.중분류코드 and pu.소분류코드 = t.소분류코드
group by pu.고객번호
order by pu.고객번호;

select pu.고객번호, t.통합코드, t.임의분류명, pu.year_pur, pu.month_pur, sum(pu.계절성),
    ntile(4) over (order by sum(pu.계절성) desc)
from purprod0 pu
join total_code0 t on pu.중분류코드 = t.중분류코드 and pu.소분류코드 = t.소분류코드
where t.통합코드 = 01
group by pu.고객번호, t.통합코드, t.임의분류명, pu.year_pur, pu.month_pur
order by 고객번호, t.통합코드, pu.year_pur, pu.month_pur;

drop table pro_pur_rank;
create table pro_pur_rank as
select 고객번호,
    case when 가공q14_1 <> 0 then ntile(10) over (order by 가공q14_1 desc) else 10 end as 가공1,
    case when 가공q14_2 <> 0 then ntile(10) over (order by 가공q14_2 desc) else 10 end as 가공2,
    case when 가공q14_3 <> 0 then ntile(10) over (order by 가공q14_3 desc) else 10 end as 가공3,
    case when 가공q14_4 <> 0 then ntile(10) over (order by 가공q14_4 desc) else 10 end as 가공4,
    case when 가공q15_1 <> 0 then ntile(10) over (order by 가공q15_1 desc) else 10 end as 가공5,
    case when 가공q15_2 <> 0 then ntile(10) over (order by 가공q15_2 desc) else 10 end as 가공6,
    case when 가공q15_3 <> 0 then ntile(10) over (order by 가공q15_3 desc) else 10 end as 가공7,
    case when 가공q15_4 <> 0 then ntile(10) over (order by 가공q15_4 desc) else 10 end as 가공8,
    
    case when 신선q14_1 <> 0 then ntile(10) over (order by 신선q14_1 desc) else 10 end as 신선1,
    case when 신선q14_2 <> 0 then ntile(10) over (order by 신선q14_2 desc) else 10 end as 신선2,
    case when 신선q14_3 <> 0 then ntile(10) over (order by 신선q14_3 desc) else 10 end as 신선3,
    case when 신선q14_4 <> 0 then ntile(10) over (order by 신선q14_4 desc) else 10 end as 신선4,
    case when 신선q15_1 <> 0 then ntile(10) over (order by 신선q15_1 desc) else 10 end as 신선5,
    case when 신선q15_2 <> 0 then ntile(10) over (order by 신선q15_2 desc) else 10 end as 신선6,
    case when 신선q15_3 <> 0 then ntile(10) over (order by 신선q15_3 desc) else 10 end as 신선7,
    case when 신선q15_4 <> 0 then ntile(10) over (order by 신선q15_4 desc) else 10 end as 신선8,
    
    case when 일상q14_1 <> 0 then ntile(10) over (order by 일상q14_1 desc) else 10 end as 일상1,
    case when 일상q14_2 <> 0 then ntile(10) over (order by 일상q14_2 desc) else 10 end as 일상2,
    case when 일상q14_3 <> 0 then ntile(10) over (order by 일상q14_3 desc) else 10 end as 일상3,
    case when 일상q14_4 <> 0 then ntile(10) over (order by 일상q14_4 desc) else 10 end as 일상4,
    case when 일상q15_1 <> 0 then ntile(10) over (order by 일상q15_1 desc) else 10 end as 일상5,
    case when 일상q15_2 <> 0 then ntile(10) over (order by 일상q15_2 desc) else 10 end as 일상6,
    case when 일상q15_3 <> 0 then ntile(10) over (order by 일상q15_3 desc) else 10 end as 일상7,
    case when 일상q15_4 <> 0 then ntile(10) over (order by 일상q15_4 desc) else 10 end as 일상8,
    
    case when 의약q14_1 <> 0 then ntile(10) over (order by 의약q14_1 desc) else 10 end as 의약1,
    case when 의약q14_2 <> 0 then ntile(10) over (order by 의약q14_2 desc) else 10 end as 의약2,
    case when 의약q14_3 <> 0 then ntile(10) over (order by 의약q14_3 desc) else 10 end as 의약3,
    case when 의약q14_4 <> 0 then ntile(10) over (order by 의약q14_4 desc) else 10 end as 의약4,
    case when 의약q15_1 <> 0 then ntile(10) over (order by 의약q15_1 desc) else 10 end as 의약5,
    case when 의약q15_2 <> 0 then ntile(10) over (order by 의약q15_2 desc) else 10 end as 의약6,
    case when 의약q15_3 <> 0 then ntile(10) over (order by 의약q15_3 desc) else 10 end as 의약7,
    case when 의약q15_4 <> 0 then ntile(10) over (order by 의약q15_4 desc) else 10 end as 의약8,
    
    case when 교육q14_1 <> 0 then ntile(10) over (order by 교육q14_1 desc) else 10 end as 교육1,
    case when 교육q14_2 <> 0 then ntile(10) over (order by 교육q14_2 desc) else 10 end as 교육2,
    case when 교육q14_3 <> 0 then ntile(10) over (order by 교육q14_3 desc) else 10 end as 교육3,
    case when 교육q14_4 <> 0 then ntile(10) over (order by 교육q14_4 desc) else 10 end as 교육4,
    case when 교육q15_1 <> 0 then ntile(10) over (order by 교육q15_1 desc) else 10 end as 교육5,
    case when 교육q15_2 <> 0 then ntile(10) over (order by 교육q15_2 desc) else 10 end as 교육6,
    case when 교육q15_3 <> 0 then ntile(10) over (order by 교육q15_3 desc) else 10 end as 교육7,
    case when 교육q15_4 <> 0 then ntile(10) over (order by 교육q15_4 desc) else 10 end as 교육8,
    
    case when 디지털q14_1 <> 0 then ntile(10) over (order by 디지털q14_1 desc) else 10 end as 디지털1,
    case when 디지털q14_2 <> 0 then ntile(10) over (order by 디지털q14_2 desc) else 10 end as 디지털2,
    case when 디지털q14_3 <> 0 then ntile(10) over (order by 디지털q14_3 desc) else 10 end as 디지털3,
    case when 디지털q14_4 <> 0 then ntile(10) over (order by 디지털q14_4 desc) else 10 end as 디지털4,
    case when 디지털q15_1 <> 0 then ntile(10) over (order by 디지털q15_1 desc) else 10 end as 디지털5,
    case when 디지털q15_2 <> 0 then ntile(10) over (order by 디지털q15_2 desc) else 10 end as 디지털6,
    case when 디지털q15_3 <> 0 then ntile(10) over (order by 디지털q15_3 desc) else 10 end as 디지털7,
    case when 디지털q15_4 <> 0 then ntile(10) over (order by 디지털q15_4 desc) else 10 end as 디지털8,
    
    case when 가구q14_1 <> 0 then ntile(10) over (order by 가구q14_1 desc) else 10 end as 가구1,
    case when 가구q14_2 <> 0 then ntile(10) over (order by 가구q14_2 desc) else 10 end as 가구2,
    case when 가구q14_3 <> 0 then ntile(10) over (order by 가구q14_3 desc) else 10 end as 가구3,
    case when 가구q14_4 <> 0 then ntile(10) over (order by 가구q14_4 desc) else 10 end as 가구4,
    case when 가구q15_1 <> 0 then ntile(10) over (order by 가구q15_1 desc) else 10 end as 가구5,
    case when 가구q15_2 <> 0 then ntile(10) over (order by 가구q15_2 desc) else 10 end as 가구6,
    case when 가구q15_3 <> 0 then ntile(10) over (order by 가구q15_3 desc) else 10 end as 가구7,
    case when 가구q15_4 <> 0 then ntile(10) over (order by 가구q15_4 desc) else 10 end as 가구8,
    
    case when 의류q14_1 <> 0 then ntile(10) over (order by 의류q14_1 desc) else 10 end as 의류1,
    case when 의류q14_2 <> 0 then ntile(10) over (order by 의류q14_2 desc) else 10 end as 의류2,
    case when 의류q14_3 <> 0 then ntile(10) over (order by 의류q14_3 desc) else 10 end as 의류3,
    case when 의류q14_4 <> 0 then ntile(10) over (order by 의류q14_4 desc) else 10 end as 의류4,
    case when 의류q15_1 <> 0 then ntile(10) over (order by 의류q15_1 desc) else 10 end as 의류5,
    case when 의류q15_2 <> 0 then ntile(10) over (order by 의류q15_2 desc) else 10 end as 의류6,
    case when 의류q15_3 <> 0 then ntile(10) over (order by 의류q15_3 desc) else 10 end as 의류7,
    case when 의류q15_4 <> 0 then ntile(10) over (order by 의류q15_4 desc) else 10 end as 의류8,
    
    case when 전문스포츠q14_1 <> 0 then ntile(10) over (order by 전문스포츠q14_1 desc) else 10 end as 전문스포츠1,
    case when 전문스포츠q14_2 <> 0 then ntile(10) over (order by 전문스포츠q14_2 desc) else 10 end as 전문스포츠2,
    case when 전문스포츠q14_3 <> 0 then ntile(10) over (order by 전문스포츠q14_3 desc) else 10 end as 전문스포츠3,
    case when 전문스포츠q14_4 <> 0 then ntile(10) over (order by 전문스포츠q14_4 desc) else 10 end as 전문스포츠4,
    case when 전문스포츠q15_1 <> 0 then ntile(10) over (order by 전문스포츠q15_1 desc) else 10 end as 전문스포츠5,
    case when 전문스포츠q15_2 <> 0 then ntile(10) over (order by 전문스포츠q15_2 desc) else 10 end as 전문스포츠6,
    case when 전문스포츠q15_3 <> 0 then ntile(10) over (order by 전문스포츠q15_3 desc) else 10 end as 전문스포츠7,
    case when 전문스포츠q15_4 <> 0 then ntile(10) over (order by 전문스포츠q15_4 desc) else 10 end as 전문스포츠8,
    
    case when 패션잡화q14_1 <> 0 then ntile(10) over (order by 패션잡화q14_1 desc) else 10 end as 패션잡화1,
    case when 패션잡화q14_2 <> 0 then ntile(10) over (order by 패션잡화q14_2 desc) else 10 end as 패션잡화2,
    case when 패션잡화q14_3 <> 0 then ntile(10) over (order by 패션잡화q14_3 desc) else 10 end as 패션잡화3,
    case when 패션잡화q14_4 <> 0 then ntile(10) over (order by 패션잡화q14_4 desc) else 10 end as 패션잡화4,
    case when 패션잡화q15_1 <> 0 then ntile(10) over (order by 패션잡화q15_1 desc) else 10 end as 패션잡화5,
    case when 패션잡화q15_2 <> 0 then ntile(10) over (order by 패션잡화q15_2 desc) else 10 end as 패션잡화6,
    case when 패션잡화q15_3 <> 0 then ntile(10) over (order by 패션잡화q15_3 desc) else 10 end as 패션잡화7,
    case when 패션잡화q15_4 <> 0 then ntile(10) over (order by 패션잡화q15_4 desc) else 10 end as 패션잡화8,
    
    case when 명품q14_1 <> 0 then ntile(10) over (order by 명품q14_1 desc) else 10 end as 명품1,
    case when 명품q14_2 <> 0 then ntile(10) over (order by 명품q14_2 desc) else 10 end as 명품2,
    case when 명품q14_3 <> 0 then ntile(10) over (order by 명품q14_3 desc) else 10 end as 명품3,
    case when 명품q14_4 <> 0 then ntile(10) over (order by 명품q14_4 desc) else 10 end as 명품4,
    case when 명품q15_1 <> 0 then ntile(10) over (order by 명품q15_1 desc) else 10 end as 명품5,
    case when 명품q15_2 <> 0 then ntile(10) over (order by 명품q15_2 desc) else 10 end as 명품6,
    case when 명품q15_3 <> 0 then ntile(10) over (order by 명품q15_3 desc) else 10 end as 명품7,
    case when 명품q15_4 <> 0 then ntile(10) over (order by 명품q15_4 desc) else 10 end as 명품8,
    
    case when 기타q14_1 <> 0 then ntile(10) over (order by 기타q14_1 desc) else 10 end as 기타1,
    case when 기타q14_2 <> 0 then ntile(10) over (order by 기타q14_2 desc) else 10 end as 기타2,
    case when 기타q14_3 <> 0 then ntile(10) over (order by 기타q14_3 desc) else 10 end as 기타3,
    case when 기타q14_4 <> 0 then ntile(10) over (order by 기타q14_4 desc) else 10 end as 기타4,
    case when 기타q15_1 <> 0 then ntile(10) over (order by 기타q15_1 desc) else 10 end as 기타5,
    case when 기타q15_2 <> 0 then ntile(10) over (order by 기타q15_2 desc) else 10 end as 기타6,
    case when 기타q15_3 <> 0 then ntile(10) over (order by 기타q15_3 desc) else 10 end as 기타7,
    case when 기타q15_4 <> 0 then ntile(10) over (order by 기타q15_4 desc) else 10 end as 기타8
    
from pro_pur
order by 고객번호;

select 고객번호,
    case when 가공q14_1 <> 0 then ntile(10) over 
    (order by 가공q14_1 desc,가공q14_2 desc,가공q14_3 desc,가공q14_4 desc, 가공q15_1 desc,가공q15_2 desc,가공q15_3 desc,가공q15_4 desc)
    else 10 end as 가공1,
    case when 가공q14_2 <> 0 then ntile(10) over 
    (order by 가공q14_1 desc,가공q14_2 desc,가공q14_3 desc,가공q14_4 desc, 가공q15_1 desc,가공q15_2 desc,가공q15_3 desc,가공q15_4 desc) 
    else 10 end as 가공2,
    case when 가공q14_3 <> 0 then ntile(10) over (order by 가공q14_3 desc) else 10 end as 가공3,
    case when 가공q14_4 <> 0 then ntile(10) over (order by 가공q14_4 desc) else 10 end as 가공4,
    case when 가공q15_1 <> 0 then ntile(10) over (order by 가공q15_1 desc) else 10 end as 가공5,
    case when 가공q15_2 <> 0 then ntile(10) over (order by 가공q15_2 desc) else 10 end as 가공6,
    case when 가공q15_3 <> 0 then ntile(10) over (order by 가공q15_3 desc) else 10 end as 가공7,
    case when 가공q15_4 <> 0 then ntile(10) over (order by 가공q15_4 desc) else 10 end as 가공8,

    
from pro_pur
order by 고객번호;

select * from pro_pur;
select * from pro_pur_rank;

select p1.고객번호,
    가공1 - 가공8,
    신선1 - 신선8,
    일상1 - 일상8,
    의약1 - 의약8,
    교육1 - 교육8,
    디지털1 - 디지털8,
    가구1 - 가구8,
    의류1 - 의류8,
    전문스포츠1 - 전문스포츠8,
    패션잡화1 - 패션잡화8,
    명품1 - 명품8,
    기타1 - 기타8,
    -(가공q14_1 - 가공q15_4),
    -(신선q14_1 - 신선q15_4),
    -(일상q14_1 - 일상q15_4),
    -(의약q14_1 - 의약q15_4),
    -(교육q14_1 - 교육q15_4),
    -(디지털q14_1 - 디지털q15_4),
    -(가구q14_1 - 가구q15_4),
    -(의류q14_1 - 의류q15_4),
    -(전문스포츠q14_1 - 전문스포츠q15_4),
    -(패션잡화q14_1 - 패션잡화q15_4),
    -(명품q14_1 - 명품q15_4),
    -(기타q14_1 - 기타q15_4)
    
from pro_pur_rank p1
join pro_pur p on p1.고객번호 = p.고객번호;

drop table pro_pur1;
create table pro_pur1 as
select pu.고객번호, pu.year_pur, pu.month_pur,
    nvl(sum(case when t.임의분류명 = '가공식품' then pu.계절성 end), 0) as 가공,
    nvl(sum(case when t.임의분류명 = '신선식품' then pu.계절성 end), 0) as 신선,
    nvl(sum(case when t.임의분류명 = '일상용품' then pu.계절성 end), 0) as 일상,
    nvl(sum(case when t.임의분류명 = '의약품/의료기기' then pu.계절성 end), 0) as 의약,
    nvl(sum(case when t.임의분류명 = '교육/문화용품' then pu.계절성 end), 0) as 교육,
    nvl(sum(case when t.임의분류명 = '디지털/가전' then pu.계절성 end), 0) as 디지털,
    nvl(sum(case when t.임의분류명 = '가구/인테리어' then pu.계절성 end), 0) as 가구,
    nvl(sum(case when t.임의분류명 = '의류' then pu.계절성 end), 0) as 의류,
    nvl(sum(case when t.임의분류명 = '전문스포츠/레저' then pu.계절성 end), 0) as 전문스포츠,
    nvl(sum(case when t.임의분류명 = '패션잡화' then pu.계절성 end), 0) as 패션잡화,
    nvl(sum(case when t.임의분류명 = '명품' then pu.계절성 end), 0) as 명품,
    nvl(sum(case when t.임의분류명 = '기타' then pu.계절성 end), 0) as 기타
from purprod0 pu
join total_code0 t on pu.소분류코드 = t.소분류코드
group by pu.고객번호, pu.year_pur, pu.month_pur
order by pu.고객번호;

select * from pro_pur1;


drop table pro_pur2;
create table pro_pur2 as
select 고객번호, 가공, 신선, 일상, 의약, 교육, 디지털, 가구, 의류, 전문스포츠, 패션잡화, 명품, 기타,
    case
        when year_pur = 2014 and month_pur between 01 and 03 then 1 
        when year_pur = 2014 and month_pur between 04 and 06 then 2
        when year_pur = 2014 and month_pur between 07 and 09 then 3
        when year_pur = 2014 and month_pur between 10 and 12 then 4
        when year_pur = 2015 and month_pur between 01 and 03 then 5
        when year_pur = 2015 and month_pur between 04 and 06 then 6
        when year_pur = 2015 and month_pur between 07 and 09 then 7
        when year_pur = 2015 and month_pur between 10 and 12 then 8
    end as q
    
from pro_pur1
order by 고객번호, q; 

select * from pro_pur2;

select 고객번호, q,
    case when nvl(sum(case when q = 1 then 가공 end), 0) <> 0 and q = 1 then ntile(10) over (order by 가공) end
from pro_pur2
group by 고객번호, q, 가공
order by 고객번호, q;

select 고객번호,
    nvl(sum(case when q = 1 then 가공 end), 0) as 가공1,
    nvl(sum(case when q = 2 then 가공 end), 0) as 가공2,
    nvl(sum(case when q = 3 then 가공 end), 0) as 가공3,
    nvl(sum(case when q = 4 then 가공 end), 0) as 가공4,
    nvl(sum(case when q = 5 then 가공 end), 0) as 가공5,
    nvl(sum(case when q = 6 then 가공 end), 0) as 가공6,
    nvl(sum(case when q = 7 then 가공 end), 0) as 가공7,
    nvl(sum(case when q = 8 then 가공 end), 0) as 가공8,

    nvl(sum(case when q = 1 then 신선 end), 0) as 신선1,
    nvl(sum(case when q = 2 then 신선 end), 0) as 신선2,
    nvl(sum(case when q = 3 then 신선 end), 0) as 신선3,
    nvl(sum(case when q = 4 then 신선 end), 0) as 신선4,
    nvl(sum(case when q = 5 then 신선 end), 0) as 신선5,
    nvl(sum(case when q = 6 then 신선 end), 0) as 신선6,
    nvl(sum(case when q = 7 then 신선 end), 0) as 신선7,
    nvl(sum(case when q = 8 then 신선 end), 0) as 신선8,
    
    nvl(sum(case when q = 1 then 일상 end), 0) as 일상1,
    nvl(sum(case when q = 2 then 일상 end), 0) as 일상2,
    nvl(sum(case when q = 3 then 일상 end), 0) as 일상3,
    nvl(sum(case when q = 4 then 일상 end), 0) as 일상4,
    nvl(sum(case when q = 5 then 일상 end), 0) as 일상5,
    nvl(sum(case when q = 6 then 일상 end), 0) as 일상6,
    nvl(sum(case when q = 7 then 일상 end), 0) as 일상7,
    nvl(sum(case when q = 8 then 일상 end), 0) as 일상8,
    
    nvl(sum(case when q = 1 then 의약 end), 0) as 의약1,
    nvl(sum(case when q = 2 then 의약 end), 0) as 의약2,
    nvl(sum(case when q = 3 then 의약 end), 0) as 의약3,
    nvl(sum(case when q = 4 then 의약 end), 0) as 의약4,
    nvl(sum(case when q = 5 then 의약 end), 0) as 의약5,
    nvl(sum(case when q = 6 then 의약 end), 0) as 의약6,
    nvl(sum(case when q = 7 then 의약 end), 0) as 의약7,
    nvl(sum(case when q = 8 then 의약 end), 0) as 의약8,
    
    nvl(sum(case when q = 1 then 교육 end), 0) as 교육1,
    nvl(sum(case when q = 2 then 교육 end), 0) as 교육2,
    nvl(sum(case when q = 3 then 교육 end), 0) as 교육3,
    nvl(sum(case when q = 4 then 교육 end), 0) as 교육4,
    nvl(sum(case when q = 5 then 교육 end), 0) as 교육5,
    nvl(sum(case when q = 6 then 교육 end), 0) as 교육6,
    nvl(sum(case when q = 7 then 교육 end), 0) as 교육7,
    nvl(sum(case when q = 8 then 교육 end), 0) as 교육8,
    
    nvl(sum(case when q = 1 then 디지털 end), 0) as 디지털1,
    nvl(sum(case when q = 2 then 디지털 end), 0) as 디지털2,
    nvl(sum(case when q = 3 then 디지털 end), 0) as 디지털3,
    nvl(sum(case when q = 4 then 디지털 end), 0) as 디지털4,
    nvl(sum(case when q = 5 then 디지털 end), 0) as 디지털5,
    nvl(sum(case when q = 6 then 디지털 end), 0) as 디지털6,
    nvl(sum(case when q = 7 then 디지털 end), 0) as 디지털7,
    nvl(sum(case when q = 8 then 디지털 end), 0) as 디지털8,
    
    nvl(sum(case when q = 1 then 가구 end), 0) as 가구1,
    nvl(sum(case when q = 2 then 가구 end), 0) as 가구2,
    nvl(sum(case when q = 3 then 가구 end), 0) as 가구3,
    nvl(sum(case when q = 4 then 가구 end), 0) as 가구4,
    nvl(sum(case when q = 5 then 가구 end), 0) as 가구5,
    nvl(sum(case when q = 6 then 가구 end), 0) as 가구6,
    nvl(sum(case when q = 7 then 가구 end), 0) as 가구7,
    nvl(sum(case when q = 8 then 가구 end), 0) as 가구8,
    
    nvl(sum(case when q = 1 then 의류 end), 0) as 의류1,
    nvl(sum(case when q = 2 then 의류 end), 0) as 의류2,
    nvl(sum(case when q = 3 then 의류 end), 0) as 의류3,
    nvl(sum(case when q = 4 then 의류 end), 0) as 의류4,
    nvl(sum(case when q = 5 then 의류 end), 0) as 의류5,
    nvl(sum(case when q = 6 then 의류 end), 0) as 의류6,
    nvl(sum(case when q = 7 then 의류 end), 0) as 의류7,
    nvl(sum(case when q = 8 then 의류 end), 0) as 의류8,
    
    nvl(sum(case when q = 1 then 전문스포츠 end), 0) as 전문스포츠1,
    nvl(sum(case when q = 2 then 전문스포츠 end), 0) as 전문스포츠2,
    nvl(sum(case when q = 3 then 전문스포츠 end), 0) as 전문스포츠3,
    nvl(sum(case when q = 4 then 전문스포츠 end), 0) as 전문스포츠4,
    nvl(sum(case when q = 5 then 전문스포츠 end), 0) as 전문스포츠5,
    nvl(sum(case when q = 6 then 전문스포츠 end), 0) as 전문스포츠6,
    nvl(sum(case when q = 7 then 전문스포츠 end), 0) as 전문스포츠7,
    nvl(sum(case when q = 8 then 전문스포츠 end), 0) as 전문스포츠8,
    
    nvl(sum(case when q = 1 then 패션잡화 end), 0) as 패션잡화1,
    nvl(sum(case when q = 2 then 패션잡화 end), 0) as 패션잡화2,
    nvl(sum(case when q = 3 then 패션잡화 end), 0) as 패션잡화3,
    nvl(sum(case when q = 4 then 패션잡화 end), 0) as 패션잡화4,
    nvl(sum(case when q = 5 then 패션잡화 end), 0) as 패션잡화5,
    nvl(sum(case when q = 6 then 패션잡화 end), 0) as 패션잡화6,
    nvl(sum(case when q = 7 then 패션잡화 end), 0) as 패션잡화7,
    nvl(sum(case when q = 8 then 패션잡화 end), 0) as 패션잡화8,
    
    nvl(sum(case when q = 1 then 명품 end), 0) as 명품1,
    nvl(sum(case when q = 2 then 명품 end), 0) as 명품2,
    nvl(sum(case when q = 3 then 명품 end), 0) as 명품3,
    nvl(sum(case when q = 4 then 명품 end), 0) as 명품4,
    nvl(sum(case when q = 5 then 명품 end), 0) as 명품5,
    nvl(sum(case when q = 6 then 명품 end), 0) as 명품6,
    nvl(sum(case when q = 7 then 명품 end), 0) as 명품7,
    nvl(sum(case when q = 8 then 명품 end), 0) as 명품8,
    
    nvl(sum(case when q = 1 then 기타 end), 0) as 기타1,
    nvl(sum(case when q = 2 then 기타 end), 0) as 기타2,
    nvl(sum(case when q = 3 then 기타 end), 0) as 기타3,
    nvl(sum(case when q = 4 then 기타 end), 0) as 기타4,
    nvl(sum(case when q = 5 then 기타 end), 0) as 기타5,
    nvl(sum(case when q = 6 then 기타 end), 0) as 기타6,
    nvl(sum(case when q = 7 then 기타 end), 0) as 기타7,
    nvl(sum(case when q = 8 then 기타 end), 0) as 기타8
from pro_pur2 
group by 고객번호
order by 고객번호;

drop table pro_pur3;
create table pro_pur3 as
select 고객번호, q,
    nvl(SUM(CASE WHEN q = 1 THEN 가공 
        WHEN q = 2 THEN 가공
        when q = 3 then 가공 
        when q = 4 then 가공
        when q = 5 then 가공
        when q = 6 then 가공
        when q = 7 then 가공
        when q = 8 then 가공
        END), 0) as 가공,
        
    nvl(SUM(CASE WHEN q = 1 THEN 신선 
        WHEN q = 2 THEN 신선
        when q = 3 then 신선 
        when q = 4 then 신선
        when q = 5 then 신선
        when q = 6 then 신선
        when q = 7 then 신선
        when q = 8 then 신선
        END), 0) as 신선,
        
    nvl(SUM(CASE WHEN q = 1 THEN 일상 
        WHEN q = 2 THEN 일상
        when q = 3 then 일상
        when q = 4 then 일상
        when q = 5 then 일상
        when q = 6 then 일상
        when q = 7 then 일상
        when q = 8 then 일상
        END), 0) as 일상,
        
    nvl(SUM(CASE WHEN q = 1 THEN 의약 
        WHEN q = 2 THEN 의약
        when q = 3 then 의약 
        when q = 4 then 의약
        when q = 5 then 의약
        when q = 6 then 의약
        when q = 7 then 의약
        when q = 8 then 의약
        END), 0) as 의약,
        
    nvl(SUM(CASE WHEN q = 1 THEN 교육 
        WHEN q = 2 THEN 교육
        when q = 3 then 교육 
        when q = 4 then 교육
        when q = 5 then 교육
        when q = 6 then 교육
        when q = 7 then 교육
        when q = 8 then 교육
        END), 0) as 교육,
        
    nvl(SUM(CASE WHEN q = 1 THEN 디지털
        WHEN q = 2 THEN 디지털
        when q = 3 then 디지털 
        when q = 4 then 디지털
        when q = 5 then 디지털
        when q = 6 then 디지털
        when q = 7 then 디지털
        when q = 8 then 디지털
        END), 0) as 디지털,
        
    nvl(SUM(CASE WHEN q = 1 THEN 가구 
        WHEN q = 2 THEN 가구
        when q = 3 then 가구 
        when q = 4 then 가구
        when q = 5 then 가구
        when q = 6 then 가구
        when q = 7 then 가구
        when q = 8 then 가구
        END), 0) as 가구,
        
    nvl(SUM(CASE WHEN q = 1 THEN 의류
        WHEN q = 2 THEN 의류
        when q = 3 then 의류 
        when q = 4 then 의류
        when q = 5 then 의류
        when q = 6 then 의류
        when q = 7 then 의류
        when q = 8 then 의류
        END), 0) as 의류,
        
    nvl(SUM(CASE WHEN q = 1 THEN 전문스포츠
        WHEN q = 2 THEN 전문스포츠
        when q = 3 then 전문스포츠 
        when q = 4 then 전문스포츠
        when q = 5 then 전문스포츠
        when q = 6 then 전문스포츠
        when q = 7 then 전문스포츠
        when q = 8 then 전문스포츠
        END), 0) as 전문스포츠,
        
    nvl(SUM(CASE WHEN q = 1 THEN 패션잡화
        WHEN q = 2 THEN 패션잡화
        when q = 3 then 패션잡화 
        when q = 4 then 패션잡화
        when q = 5 then 패션잡화
        when q = 6 then 패션잡화
        when q = 7 then 패션잡화
        when q = 8 then 패션잡화
        END), 0) as 패션잡화,
        
    nvl(SUM(CASE WHEN q = 1 THEN 명품
        WHEN q = 2 THEN 명품
        when q = 3 then 명품 
        when q = 4 then 명품
        when q = 5 then 명품
        when q = 6 then 명품
        when q = 7 then 명품
        when q = 8 then 명품
        END), 0) as 명품,
        
    nvl(SUM(CASE WHEN q = 1 THEN 기타 
        WHEN q = 2 THEN 기타
        when q = 3 then 기타 
        when q = 4 then 기타
        when q = 5 then 기타
        when q = 6 then 기타
        when q = 7 then 기타
        when q = 8 then 기타
        END), 0) as 기타
        
from pro_pur2
group by 고객번호, q
order by 고객번호;


select * from pro_pur3;

select 고객번호,
    case when q = 1 then ntile(10) over (order by 가공 desc) end as 가공1
from pro_pur3
order by 고객번호, q;

drop table pro_pur4;
create table pro_pur4 as
select 고객번호, q, 가공, 신선, 일상, 의약, 교육, 디지털, 가구, 의류, 전문스포츠, 패션잡화, 명품, 기타,
    case when 가공 <> 0 then ntile(10) over (order by 가공 desc) else 10 end as 가공_rank,
    case when 신선 <> 0 then ntile(10) over (order by 신선 desc) else 10 end as 신선_rank,
    case when 일상 <> 0 then ntile(10) over (order by 일상 desc) else 10 end as 일상_rank,
    case when 의약 <> 0 then ntile(10) over (order by 의약 desc) else 10 end as 의약_rank,
    case when 교육 <> 0 then ntile(10) over (order by 교육 desc) else 10 end as 교육_rank,
    case when 디지털 <> 0 then ntile(10) over (order by 디지털 desc) else 10 end as 디지털_rank,
    case when 가구 <> 0 then ntile(10) over (order by 가구 desc) else 10 end as 가구_rank,
    case when 의류 <> 0 then ntile(10) over (order by 의류 desc) else 10 end as 의류_rank,
    case when 전문스포츠 <> 0 then ntile(10) over (order by 전문스포츠 desc) else 10 end as 전문스포츠_rank,
    case when 패션잡화 <> 0 then ntile(10) over (order by 패션잡화 desc) else 10 end as 패션잡화_rank,
    case when 명품 <> 0 then ntile(10) over (order by 명품 desc) else 10 end as 명품_rank,
    case when 기타 <> 0 then ntile(10) over (order by 기타 desc) else 10 end as 기타_rank
    
from pro_pur3
order by 고객번호, q;

select * from pro_pur4;

select * from pro_pur;



SELECT p.고객번호,
     case when max(nvl(case when p4.q = 1 then p4.일상_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.일상_rank end, 0)) else 10 end as 가공1,
    case when max(nvl(case when p4.q = 7 then p4.일상_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.일상_rank end, 0)) else 10 end as 가공2
FROM pro_pur4 p4
join pro_pur p on p.고객번호 = p4.고객번호
GROUP BY p.고객번호
order by p.고객번호;

SELECT p.고객번호,
     case when max(nvl(case when p4.q = 1 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.가공_rank end, 0)) else 10 end as 가공1,
    case when max(nvl(case when p4.q = 2 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.가공_rank end, 0)) else 10 end as 가공2,
    case when max(nvl(case when p4.q = 3 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.가공_rank end, 0)) else 10 end as 가공3,
    case when max(nvl(case when p4.q = 4 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.가공_rank end, 0)) else 10 end as 가공4,
    case when max(nvl(case when p4.q = 5 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.가공_rank end, 0)) else 10 end as 가공5,
    case when max(nvl(case when p4.q = 6 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.가공_rank end, 0)) else 10 end as 가공6,
    case when max(nvl(case when p4.q = 7 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.가공_rank end, 0)) else 10 end as 가공7,
    case when max(nvl(case when p4.q = 8 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.가공_rank end, 0)) else 10 end as 가공8
FROM pro_pur4 p4
full join pro_pur p on p.고객번호 = p4.고객번호
where p.고객번호 = 19383
GROUP BY p.고객번호
order by p.고객번호;

drop table pro_pur5;
create table pro_pur5 as
SELECT p.고객번호, 
    p.가공q14_1, p.가공q14_2, p.가공q14_3, p.가공q14_4, p.가공q15_1, p.가공q15_2, p.가공q15_3, p.가공q15_4,
    p.신선q14_1, p.신선q14_2, p.신선q14_3, p.신선q14_4, p.신선q15_1, p.신선q15_2, p.신선q15_3, p.신선q15_4,
    p.일상q14_1, p.일상q14_2, p.일상q14_3, p.일상q14_4, p.일상q15_1, p.일상q15_2, p.일상q15_3, p.일상q15_4,
    p.의약q14_1, p.의약q14_2, p.의약q14_3, p.의약q14_4, p.의약q15_1, p.의약q15_2, p.의약q15_3, p.의약q15_4,
    p.교육q14_1, p.교육q14_2, p.교육q14_3, p.교육q14_4, p.교육q15_1, p.교육q15_2, p.교육q15_3, p.교육q15_4,
    p.디지털q14_1, p.디지털q14_2, p.디지털q14_3, p.디지털q14_4, p.디지털q15_1, p.디지털q15_2, p.디지털q15_3, p.디지털q15_4,
    p.가구q14_1, p.가구q14_2, p.가구q14_3, p.가구q14_4, p.가구q15_1, p.가구q15_2, p.가구q15_3, p.가구q15_4,
    p.의류q14_1, p.의류q14_2, p.의류q14_3, p.의류q14_4, p.의류q15_1, p.의류q15_2, p.의류q15_3, p.의류q15_4,
    p.전문스포츠q14_1, p.전문스포츠q14_2, p.전문스포츠q14_3, p.전문스포츠q14_4, p.전문스포츠q15_1, p.전문스포츠q15_2, p.전문스포츠q15_3, p.전문스포츠q15_4,
    p.패션잡화q14_1, p.패션잡화q14_2, p.패션잡화q14_3, p.패션잡화q14_4, p.패션잡화q15_1, p.패션잡화q15_2, p.패션잡화q15_3, p.패션잡화q15_4,
    p.명품q14_1, p.명품q14_2, p.명품q14_3, p.명품q14_4, p.명품q15_1, p.명품q15_2, p.명품q15_3, p.명품q15_4,
    p.기타q14_1, p.기타q14_2, p.기타q14_3, p.기타q14_4, p.기타q15_1, p.기타q15_2, p.기타q15_3, p.기타q15_4,
    
    case when max(nvl(case when p4.q = 1 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.가공_rank end, 0)) else 10 end as 가공1,
    case when max(nvl(case when p4.q = 2 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.가공_rank end, 0)) else 10 end as 가공2,
    case when max(nvl(case when p4.q = 3 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.가공_rank end, 0)) else 10 end as 가공3,
    case when max(nvl(case when p4.q = 4 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.가공_rank end, 0)) else 10 end as 가공4,
    case when max(nvl(case when p4.q = 5 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.가공_rank end, 0)) else 10 end as 가공5,
    case when max(nvl(case when p4.q = 6 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.가공_rank end, 0)) else 10 end as 가공6,
    case when max(nvl(case when p4.q = 7 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.가공_rank end, 0)) else 10 end as 가공7,
    case when max(nvl(case when p4.q = 8 then p4.가공_rank end, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.가공_rank end, 0)) else 10 end as 가공8,

    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.신선_rank end, 0)) else 10 end AS 신선1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.신선_rank end, 0)) else 10 end AS 신선2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.신선_rank end, 0)) else 10 end AS 신선3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.신선_rank end, 0)) else 10 end AS 신선4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.신선_rank end, 0)) else 10 end AS 신선5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.신선_rank end, 0)) else 10 end AS 신선6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.신선_rank end, 0)) else 10 end AS 신선7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.신선_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.신선_rank end, 0)) else 10 end AS 신선8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.일상_rank end, 0)) else 10 end AS 일상1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.일상_rank end, 0)) else 10 end AS 일상2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.일상_rank end, 0)) else 10 end AS 일상3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.일상_rank end, 0)) else 10 end AS 일상4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.일상_rank end, 0)) else 10 end AS 일상5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.일상_rank end, 0)) else 10 end AS 일상6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.일상_rank end, 0)) else 10 end AS 일상7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.일상_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.일상_rank end, 0)) else 10 end AS 일상8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.의약_rank end, 0)) else 10 end AS 의약1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.의약_rank end, 0)) else 10 end AS 의약2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.의약_rank end, 0)) else 10 end AS 의약3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.의약_rank end, 0)) else 10 end AS 의약4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.의약_rank end, 0)) else 10 end AS 의약5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.의약_rank end, 0)) else 10 end AS 의약6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.의약_rank end, 0)) else 10 end AS 의약7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.의약_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.의약_rank end, 0)) else 10 end AS 의약8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.교육_rank end, 0)) else 10 end AS 교육1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.교육_rank end, 0)) else 10 end AS 교육2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.교육_rank end, 0)) else 10 end AS 교육3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.교육_rank end, 0)) else 10 end AS 교육4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.교육_rank end, 0)) else 10 end AS 교육5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.교육_rank end, 0)) else 10 end AS 교육6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.교육_rank end, 0)) else 10 end AS 교육7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.교육_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.교육_rank end, 0)) else 10 end AS 교육8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.디지털_rank end, 0)) else 10 end AS 디지털1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.디지털_rank end, 0)) else 10 end AS 디지털2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.디지털_rank end, 0)) else 10 end AS 디지털3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.디지털_rank end, 0)) else 10 end AS 디지털4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.디지털_rank end, 0)) else 10 end AS 디지털5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.디지털_rank end, 0)) else 10 end AS 디지털6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.디지털_rank end, 0)) else 10 end AS 디지털7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.디지털_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.디지털_rank end, 0)) else 10 end AS 디지털8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.가구_rank end, 0)) else 10 end AS 가구1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.가구_rank end, 0)) else 10 end AS 가구2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.가구_rank end, 0)) else 10 end AS 가구3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.가구_rank end, 0)) else 10 end AS 가구4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.가구_rank end, 0)) else 10 end AS 가구5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.가구_rank end, 0)) else 10 end AS 가구6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.가구_rank end, 0)) else 10 end AS 가구7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.가구_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.가구_rank end, 0)) else 10 end AS 가구8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.의류_rank end, 0)) else 10 end AS 의류1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.의류_rank end, 0)) else 10 end AS 의류2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.의류_rank end, 0)) else 10 end AS 의류3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.의류_rank end, 0)) else 10 end AS 의류4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.의류_rank end, 0)) else 10 end AS 의류5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.의류_rank end, 0)) else 10 end AS 의류6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.의류_rank end, 0)) else 10 end AS 의류7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.의류_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.의류_rank end, 0)) else 10 end AS 의류8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.전문스포츠_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.전문스포츠_rank end, 0)) else 10 end AS 전문스포츠8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.패션잡화_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.패션잡화_rank end, 0)) else 10 end AS 패션잡화8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.명품_rank end, 0)) else 10 end AS 명품1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.명품_rank end, 0)) else 10 end AS 명품2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.명품_rank end, 0)) else 10 end AS 명품3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.명품_rank end, 0)) else 10 end AS 명품4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.명품_rank end, 0)) else 10 end AS 명품5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.명품_rank end, 0)) else 10 end AS 명품6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.명품_rank end, 0)) else 10 end AS 명품7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.명품_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.명품_rank end, 0)) else 10 end AS 명품8,
    
    case when MAX(nvl(CASE WHEN p4.q = 1 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 1 then p4.기타_rank end, 0)) else 10 end AS 기타1,
    case when MAX(nvl(CASE WHEN p4.q = 2 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 2 then p4.기타_rank end, 0)) else 10 end AS 기타2,
    case when MAX(nvl(CASE WHEN p4.q = 3 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 3 then p4.기타_rank end, 0)) else 10 end AS 기타3,
    case when MAX(nvl(CASE WHEN p4.q = 4 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 4 then p4.기타_rank end, 0)) else 10 end AS 기타4,
    case when MAX(nvl(CASE WHEN p4.q = 5 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 5 then p4.기타_rank end, 0)) else 10 end AS 기타5,
    case when MAX(nvl(CASE WHEN p4.q = 6 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 6 then p4.기타_rank end, 0)) else 10 end AS 기타6,
    case when MAX(nvl(CASE WHEN p4.q = 7 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 7 then p4.기타_rank end, 0)) else 10 end AS 기타7,
    case when MAX(nvl(CASE WHEN p4.q = 8 THEN p4.기타_rank END, 0)) <> 0 then
    max(nvl(case when p4.q = 8 then p4.기타_rank end, 0)) else 10 end AS 기타8
    
FROM pro_pur4 p4
join pro_pur p on p.고객번호 = p4.고객번호
GROUP BY p.고객번호, 
    p.가공q14_1, p.가공q14_2, p.가공q14_3, p.가공q14_4, p.가공q15_1, p.가공q15_2, p.가공q15_3, p.가공q15_4,
    p.신선q14_1, p.신선q14_2, p.신선q14_3, p.신선q14_4, p.신선q15_1, p.신선q15_2, p.신선q15_3, p.신선q15_4,
    p.일상q14_1, p.일상q14_2, p.일상q14_3, p.일상q14_4, p.일상q15_1, p.일상q15_2, p.일상q15_3, p.일상q15_4,
    p.의약q14_1, p.의약q14_2, p.의약q14_3, p.의약q14_4, p.의약q15_1, p.의약q15_2, p.의약q15_3, p.의약q15_4,
    p.교육q14_1, p.교육q14_2, p.교육q14_3, p.교육q14_4, p.교육q15_1, p.교육q15_2, p.교육q15_3, p.교육q15_4,
    p.디지털q14_1, p.디지털q14_2, p.디지털q14_3, p.디지털q14_4, p.디지털q15_1, p.디지털q15_2, p.디지털q15_3, p.디지털q15_4,
    p.가구q14_1, p.가구q14_2, p.가구q14_3, p.가구q14_4, p.가구q15_1, p.가구q15_2, p.가구q15_3, p.가구q15_4,
    p.의류q14_1, p.의류q14_2, p.의류q14_3, p.의류q14_4, p.의류q15_1, p.의류q15_2, p.의류q15_3, p.의류q15_4,
    p.전문스포츠q14_1, p.전문스포츠q14_2, p.전문스포츠q14_3, p.전문스포츠q14_4, p.전문스포츠q15_1, p.전문스포츠q15_2, p.전문스포츠q15_3, p.전문스포츠q15_4,
    p.패션잡화q14_1, p.패션잡화q14_2, p.패션잡화q14_3, p.패션잡화q14_4, p.패션잡화q15_1, p.패션잡화q15_2, p.패션잡화q15_3, p.패션잡화q15_4,
    p.명품q14_1, p.명품q14_2, p.명품q14_3, p.명품q14_4, p.명품q15_1, p.명품q15_2, p.명품q15_3, p.명품q15_4,
    p.기타q14_1, p.기타q14_2, p.기타q14_3, p.기타q14_4, p.기타q15_1, p.기타q15_2, p.기타q15_3, p.기타q15_4
order by p.고객번호;

select * from pro_pur5;

select 고객번호,
    가공1 - 가공8,
    신선1 - 신선8,
    일상1 - 일상8,
    의약1 - 의약8,
    교육1 - 교육8,
    디지털1 - 디지털8,
    가구1 - 가구8,
    의류1 - 의류8,
    전문스포츠1 - 전문스포츠8,
    패션잡화1 - 패션잡화8,
    명품1 - 명품8,
    기타1 - 기타8,
    
    abs(가공1-가공2)+abs(가공2-가공3)+abs(가공3-가공4)+abs(가공4-가공5)+abs(가공5-가공6)+abs(가공6-가공7)+abs(가공7-가공8) as abs가공,
    abs(신선1-신선2)+abs(신선2-신선3)+abs(신선3-신선4)+abs(신선4-신선5)+abs(신선5-신선6)+abs(신선6-신선7)+abs(신선7-신선8) as abs신선,
    abs(일상1-일상2)+abs(일상2-일상3)+abs(일상3-일상4)+abs(일상4-일상5)+abs(일상5-일상6)+abs(일상6-일상7)+abs(일상7-일상8) as abs일상,
    abs(의약1-의약2)+abs(의약2-의약3)+abs(의약3-의약4)+abs(의약4-의약5)+abs(의약5-의약6)+abs(의약6-의약7)+abs(의약7-의약8) as abs의약,
    abs(교육1-교육2)+abs(교육2-교육3)+abs(교육3-교육4)+abs(교육4-교육5)+abs(교육5-교육6)+abs(교육6-교육7)+abs(교육7-교육8) as abs교육,
    abs(디지털1-디지털2)+abs(디지털2-디지털3)+abs(디지털3-디지털4)+abs(디지털4-디지털5)+abs(디지털5-디지털6)+abs(디지털6-디지털7)+abs(디지털7-디지털8) as abs디지털,
    abs(가구1-가구2)+abs(가구2-가구3)+abs(가구3-가구4)+abs(가구4-가구5)+abs(가구5-가구6)+abs(가구6-가구7)+abs(가구7-가구8) as abs가구,
    abs(의류1-의류2)+abs(의류2-의류3)+abs(의류3-의류4)+abs(의류4-의류5)+abs(의류5-의류6)+abs(의류6-의류7)+abs(의류7-의류8) as abs의류,
    abs(전문스포츠1-전문스포츠2)+abs(전문스포츠2-전문스포츠3)+abs(전문스포츠3-전문스포츠4)+abs(전문스포츠4-전문스포츠5)+abs(전문스포츠5-전문스포츠6)+abs(전문스포츠6-전문스포츠7)+abs(전문스포츠7-전문스포츠8) as abs전문스포츠,
    abs(패션잡화1-패션잡화2)+abs(패션잡화2-패션잡화3)+abs(패션잡화3-패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6)+abs(패션잡화6-패션잡화7)+abs(패션잡화7-패션잡화8) as abs패션잡화,
    abs(명품1-명품2)+abs(명품2-명품3)+abs(명품3-명품4)+abs(명품4-명품5)+abs(명품5-명품6)+abs(명품6-명품7)+abs(명품7-명품8) as abs명품,
    abs(기타1-기타2)+abs(기타2-기타3)+abs(기타3-기타4)+abs(기타4-기타5)+abs(기타5-기타6)+abs(기타6-기타7)+abs(기타7-기타8) as abs기타,
    
    -(가공q14_1 - 가공q15_4),
    -(신선q14_1 - 신선q15_4),
    -(일상q14_1 - 일상q15_4),
    -(의약q14_1 - 의약q15_4),
    -(교육q14_1 - 교육q15_4),
    -(디지털q14_1 - 디지털q15_4),
    -(가구q14_1 - 가구q15_4),
    -(의류q14_1 - 의류q15_4),
    -(전문스포츠q14_1 - 전문스포츠q15_4),
    -(패션잡화q14_1 - 패션잡화q15_4),
    -(명품q14_1 - 명품q15_4),
    -(기타q14_1 - 기타q15_4)
            
from pro_pur5;

--master
select *
from demo
order by 고객번호;

drop table company;
create table company as
select 고객번호,
    count(case when 제휴사 = 'A' then 제휴사 end) as useA,
    count(case when 제휴사 = 'B' then 제휴사 end) as useB,
    count(case when 제휴사 = 'C' then 제휴사 end) as useC,
    count(case when 제휴사 = 'D' then 제휴사 end) as useD,
    CASE
        WHEN count(case when 제휴사 = 'A' then 제휴사 end) >
             count(case when 제휴사 = 'B' then 제휴사 end) AND
             count(case when 제휴사 = 'A' then 제휴사 end) >
             count(case when 제휴사 = 'C' then 제휴사 end) AND
             count(case when 제휴사 = 'A' then 제휴사 end) >
             count(case when 제휴사 = 'D' then 제휴사 end)
        THEN 'A'
        
        WHEN count(case when 제휴사 = 'B' then 제휴사 end) >
             count(case when 제휴사 = 'A' then 제휴사 end) AND
             count(case when 제휴사 = 'B' then 제휴사 end) >
             count(case when 제휴사 = 'C' then 제휴사 end) AND
             count(case when 제휴사 = 'B' then 제휴사 end) >
             count(case when 제휴사 = 'D' then 제휴사 end)
        THEN 'b'
    
        WHEN count(case when 제휴사 = 'C' then 제휴사 end) >
             count(case when 제휴사 = 'A' then 제휴사 end) AND
             count(case when 제휴사 = 'C' then 제휴사 end) >
             count(case when 제휴사 = 'B' then 제휴사 end) AND
             count(case when 제휴사 = 'C' then 제휴사 end) >
             count(case when 제휴사 = 'D' then 제휴사 end)
        THEN 'C'
        
        WHEN count(case when 제휴사 = 'D' then 제휴사 end) >
             count(case when 제휴사 = 'A' then 제휴사 end) AND
             count(case when 제휴사 = 'D' then 제휴사 end) >
             count(case when 제휴사 = 'B' then 제휴사 end) AND
             count(case when 제휴사 = 'D' then 제휴사 end) >
             count(case when 제휴사 = 'C' then 제휴사 end)
        THEN 'D'
    end as 선호제휴사
from purprod0
group by 고객번호
order by 고객번호;

select * from company;

select distinct d.거주지역
from demo d
join company c on d.고객번호 = c.고객번호;

select d.고객번호, nvl(d.거주지역, 0), c.선호제휴사
from demo d
join company c on d.고객번호 = c.고객번호
where nvl(d.거주지역, 0) = 0
order by d.거주지역;

select 고객번호, 성별, 연령대, 거주지역,
    case 
        when 연령대 in ('19세이하', '20세~24세', '25세~29세') then '청년층'
        when 연령대 in ('30세~34세', '35세~39세', '40세~44세', '45세~49세') then '중년층'
        when 연령대 in ('50세~54세', '55세~59세', '60세이상') then '노년층'
    end as 연령대분류
from demo;

drop table mastertable;
create table mastertable as
SELECT d.고객번호, d.성별, 
    case 
        when 연령대 in ('19세이하', '20세~24세', '25세~29세') then '청년층'
        when 연령대 in ('30세~34세', '35세~39세', '40세~44세', '45세~49세') then '중년층'
        when 연령대 in ('50세~54세', '55세~59세', '60세이상') then '노년층'
    end as 연령대분류,
    
    p.가공q14_1, p.가공q14_2, p.가공q14_3, p.가공q14_4, p.가공q15_1, p.가공q15_2, p.가공q15_3, p.가공q15_4,
    p.신선q14_1, p.신선q14_2, p.신선q14_3, p.신선q14_4, p.신선q15_1, p.신선q15_2, p.신선q15_3, p.신선q15_4,
    p.일상q14_1, p.일상q14_2, p.일상q14_3, p.일상q14_4, p.일상q15_1, p.일상q15_2, p.일상q15_3, p.일상q15_4,
    p.의약q14_1, p.의약q14_2, p.의약q14_3, p.의약q14_4, p.의약q15_1, p.의약q15_2, p.의약q15_3, p.의약q15_4,
    p.교육q14_1, p.교육q14_2, p.교육q14_3, p.교육q14_4, p.교육q15_1, p.교육q15_2, p.교육q15_3, p.교육q15_4,
    p.디지털q14_1, p.디지털q14_2, p.디지털q14_3, p.디지털q14_4, p.디지털q15_1, p.디지털q15_2, p.디지털q15_3, p.디지털q15_4,
    p.가구q14_1, p.가구q14_2, p.가구q14_3, p.가구q14_4, p.가구q15_1, p.가구q15_2, p.가구q15_3, p.가구q15_4,
    p.의류q14_1, p.의류q14_2, p.의류q14_3, p.의류q14_4, p.의류q15_1, p.의류q15_2, p.의류q15_3, p.의류q15_4,
    p.전문스포츠q14_1, p.전문스포츠q14_2, p.전문스포츠q14_3, p.전문스포츠q14_4, p.전문스포츠q15_1, p.전문스포츠q15_2, p.전문스포츠q15_3, p.전문스포츠q15_4,
    p.패션잡화q14_1, p.패션잡화q14_2, p.패션잡화q14_3, p.패션잡화q14_4, p.패션잡화q15_1, p.패션잡화q15_2, p.패션잡화q15_3, p.패션잡화q15_4,
    p.명품q14_1, p.명품q14_2, p.명품q14_3, p.명품q14_4, p.명품q15_1, p.명품q15_2, p.명품q15_3, p.명품q15_4,
    p.기타q14_1, p.기타q14_2, p.기타q14_3, p.기타q14_4, p.기타q15_1, p.기타q15_2, p.기타q15_3, p.기타q15_4,
    p.가공1, p.가공2, p.가공3, p.가공4, p.가공5, p.가공6, p.가공7, p.가공8,
    p.신선1, p.신선2, p.신선3, p.신선4, p.신선5, p.신선6, p.신선7, p.신선8,
    p.일상1, p.일상2, p.일상3, p.일상4, p.일상5, p.일상6, p.일상7, p.일상8,
    p.의약1, p.의약2, p.의약3, p.의약4, p.의약5, p.의약6, p.의약7, p.의약8,
    p.교육1, p.교육2, p.교육3, p.교육4, p.교육5, p.교육6, p.교육7, p.교육8,
    p.디지털1, p.디지털2, p.디지털3, p.디지털4, p.디지털5, p.디지털6, p.디지털7, p.디지털8,
    p.가구1, p.가구2, p.가구3, p.가구4, p.가구5, p.가구6, p.가구7, p.가구8,
    p.의류1, p.의류2, p.의류3, p.의류4, p.의류5, p.의류6, p.의류7, p.의류8,
    p.전문스포츠1, p.전문스포츠2, p.전문스포츠3, p.전문스포츠4, p.전문스포츠5, p.전문스포츠6, p.전문스포츠7, p.전문스포츠8,
    p.패션잡화1, p.패션잡화2, p.패션잡화3, p.패션잡화4, p.패션잡화5, p.패션잡화6, p.패션잡화7, p.패션잡화8,
    p.명품1, p.명품2, p.명품3, p.명품4, p.명품5, p.명품6, p.명품7, p.명품8,
    p.기타1, p.기타2, p.기타3, p.기타4, p.기타5, p.기타6, p.기타7, p.기타8
    
FROM demo d
JOIN pro_pur5 p ON d.고객번호 = p.고객번호
ORDER BY d.고객번호;

select * from mastertable;

SELECT 고객번호,
     min(to_date('2016-01-01', 'YYYY-MM-DD') - to_date(구매일자 , 'YYYY-MM-DD')) as 최근구매일자
FROM purprod0 
group by 고객번호
order by 고객번호;

drop table mastertable1;
create table mastertable1 as
select m.고객번호, m.성별, m.연령대분류,
    m.가공q14_1, m.가공q14_2, m.가공q14_3, m.가공q14_4, m.가공q15_1, m.가공q15_2, m.가공q15_3, m.가공q15_4,
    m.신선q14_1, m.신선q14_2, m.신선q14_3, m.신선q14_4, m.신선q15_1, m.신선q15_2, m.신선q15_3, m.신선q15_4,
    m.일상q14_1, m.일상q14_2, m.일상q14_3, m.일상q14_4, m.일상q15_1, m.일상q15_2, m.일상q15_3, m.일상q15_4,
    m.의약q14_1, m.의약q14_2, m.의약q14_3, m.의약q14_4, m.의약q15_1, m.의약q15_2, m.의약q15_3, m.의약q15_4,
    m.교육q14_1, m.교육q14_2, m.교육q14_3, m.교육q14_4, m.교육q15_1, m.교육q15_2, m.교육q15_3, m.교육q15_4,
    m.디지털q14_1, m.디지털q14_2, m.디지털q14_3, m.디지털q14_4, m.디지털q15_1, m.디지털q15_2, m.디지털q15_3, m.디지털q15_4,
    m.가구q14_1, m.가구q14_2, m.가구q14_3, m.가구q14_4, m.가구q15_1, m.가구q15_2, m.가구q15_3, m.가구q15_4,
    m.의류q14_1, m.의류q14_2, m.의류q14_3, m.의류q14_4, m.의류q15_1, m.의류q15_2, m.의류q15_3, m.의류q15_4,
    m.전문스포츠q14_1, m.전문스포츠q14_2, m.전문스포츠q14_3, m.전문스포츠q14_4, m.전문스포츠q15_1, m.전문스포츠q15_2, m.전문스포츠q15_3, m.전문스포츠q15_4,
    m.패션잡화q14_1, m.패션잡화q14_2, m.패션잡화q14_3, m.패션잡화q14_4, m.패션잡화q15_1, m.패션잡화q15_2, m.패션잡화q15_3, m.패션잡화q15_4,
    m.명품q14_1, m.명품q14_2, m.명품q14_3, m.명품q14_4, m.명품q15_1, m.명품q15_2, m.명품q15_3, m.명품q15_4,
    m.기타q14_1, m.기타q14_2, m.기타q14_3, m.기타q14_4, m.기타q15_1, m.기타q15_2, m.기타q15_3, m.기타q15_4,
    m.가공1, m.가공2, m.가공3, m.가공4, m.가공5, m.가공6, m.가공7, m.가공8,
    m.신선1, m.신선2, m.신선3, m.신선4, m.신선5, m.신선6, m.신선7, m.신선8,
    m.일상1, m.일상2, m.일상3, m.일상4, m.일상5, m.일상6, m.일상7, m.일상8,
    m.의약1, m.의약2, m.의약3, m.의약4, m.의약5, m.의약6, m.의약7, m.의약8,
    m.교육1, m.교육2, m.교육3, m.교육4, m.교육5, m.교육6, m.교육7, m.교육8,
    m.디지털1, m.디지털2, m.디지털3, m.디지털4, m.디지털5, m.디지털6, m.디지털7, m.디지털8,
    m.가구1, m.가구2, m.가구3, m.가구4, m.가구5, m.가구6, m.가구7, m.가구8,
    m.의류1, m.의류2, m.의류3, m.의류4, m.의류5, m.의류6, m.의류7, m.의류8,
    m.전문스포츠1, m.전문스포츠2, m.전문스포츠3, m.전문스포츠4, m.전문스포츠5, m.전문스포츠6, m.전문스포츠7, m.전문스포츠8,
    m.패션잡화1, m.패션잡화2, m.패션잡화3, m.패션잡화4, m.패션잡화5, m.패션잡화6, m.패션잡화7, m.패션잡화8,
    m.명품1, m.명품2, m.명품3, m.명품4, m.명품5, m.명품6, m.명품7, m.명품8,
    m.기타1, m.기타2, m.기타3, m.기타4, m.기타5, m.기타6, m.기타7, m.기타8,
    
    min(to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD')) as 일자간격
    
from mastertable m
join purprod0 p on m.고객번호 = p.고객번호
group by m.고객번호, m.성별, m.연령대분류,
    m.가공q14_1, m.가공q14_2, m.가공q14_3, m.가공q14_4, m.가공q15_1, m.가공q15_2, m.가공q15_3, m.가공q15_4,
    m.신선q14_1, m.신선q14_2, m.신선q14_3, m.신선q14_4, m.신선q15_1, m.신선q15_2, m.신선q15_3, m.신선q15_4,
    m.일상q14_1, m.일상q14_2, m.일상q14_3, m.일상q14_4, m.일상q15_1, m.일상q15_2, m.일상q15_3, m.일상q15_4,
    m.의약q14_1, m.의약q14_2, m.의약q14_3, m.의약q14_4, m.의약q15_1, m.의약q15_2, m.의약q15_3, m.의약q15_4,
    m.교육q14_1, m.교육q14_2, m.교육q14_3, m.교육q14_4, m.교육q15_1, m.교육q15_2, m.교육q15_3, m.교육q15_4,
    m.디지털q14_1, m.디지털q14_2, m.디지털q14_3, m.디지털q14_4, m.디지털q15_1, m.디지털q15_2, m.디지털q15_3, m.디지털q15_4,
    m.가구q14_1, m.가구q14_2, m.가구q14_3, m.가구q14_4, m.가구q15_1, m.가구q15_2, m.가구q15_3, m.가구q15_4,
    m.의류q14_1, m.의류q14_2, m.의류q14_3, m.의류q14_4, m.의류q15_1, m.의류q15_2, m.의류q15_3, m.의류q15_4,
    m.전문스포츠q14_1, m.전문스포츠q14_2, m.전문스포츠q14_3, m.전문스포츠q14_4, m.전문스포츠q15_1, m.전문스포츠q15_2, m.전문스포츠q15_3, m.전문스포츠q15_4,
    m.패션잡화q14_1, m.패션잡화q14_2, m.패션잡화q14_3, m.패션잡화q14_4, m.패션잡화q15_1, m.패션잡화q15_2, m.패션잡화q15_3, m.패션잡화q15_4,
    m.명품q14_1, m.명품q14_2, m.명품q14_3, m.명품q14_4, m.명품q15_1, m.명품q15_2, m.명품q15_3, m.명품q15_4,
    m.기타q14_1, m.기타q14_2, m.기타q14_3, m.기타q14_4, m.기타q15_1, m.기타q15_2, m.기타q15_3, m.기타q15_4,
    m.가공1, m.가공2, m.가공3, m.가공4, m.가공5, m.가공6, m.가공7, m.가공8,
    m.신선1, m.신선2, m.신선3, m.신선4, m.신선5, m.신선6, m.신선7, m.신선8,
    m.일상1, m.일상2, m.일상3, m.일상4, m.일상5, m.일상6, m.일상7, m.일상8,
    m.의약1, m.의약2, m.의약3, m.의약4, m.의약5, m.의약6, m.의약7, m.의약8,
    m.교육1, m.교육2, m.교육3, m.교육4, m.교육5, m.교육6, m.교육7, m.교육8,
    m.디지털1, m.디지털2, m.디지털3, m.디지털4, m.디지털5, m.디지털6, m.디지털7, m.디지털8,
    m.가구1, m.가구2, m.가구3, m.가구4, m.가구5, m.가구6, m.가구7, m.가구8,
    m.의류1, m.의류2, m.의류3, m.의류4, m.의류5, m.의류6, m.의류7, m.의류8,
    m.전문스포츠1, m.전문스포츠2, m.전문스포츠3, m.전문스포츠4, m.전문스포츠5, m.전문스포츠6, m.전문스포츠7, m.전문스포츠8,
    m.패션잡화1, m.패션잡화2, m.패션잡화3, m.패션잡화4, m.패션잡화5, m.패션잡화6, m.패션잡화7, m.패션잡화8,
    m.명품1, m.명품2, m.명품3, m.명품4, m.명품5, m.명품6, m.명품7, m.명품8,
    m.기타1, m.기타2, m.기타3, m.기타4, m.기타5, m.기타6, m.기타7, m.기타8 
order by m.고객번호;

select * from mastertable1;



--train test
drop table train;
create table train as
select 고객번호, 성별, 연령대분류,
    가공1 - 가공6 as 가공변화,
    신선1 - 신선6 as 신선변화,
    일상1 - 일상6 as 일상변화,
    의약1 - 의약6 as 의약변화,
    교육1 - 교육6 as 교육변화,
    디지털1 - 디지털6 as 디지털변화,
    가구1 - 가구6 as 가구변화,
    의류1 - 의류6 as 의류변화,
    전문스포츠1 - 전문스포츠6 as 전문스포츠변화,
    패션잡화1 - 패션잡화6 as 패션잡화변화,
    명품1 - 명품6 as 명품변화,
    기타1 - 기타6 as 기타변화,
    
    abs(가공1-가공2)+abs(가공2-가공3)+abs(가공3-가공4)+abs(가공4-가공5)+abs(가공5-가공6) as abs가공,
    abs(신선1-신선2)+abs(신선2-신선3)+abs(신선3-신선4)+abs(신선4-신선5)+abs(신선5-신선6) as abs신선,
    abs(일상1-일상2)+abs(일상2-일상3)+abs(일상3-일상4)+abs(일상4-일상5)+abs(일상5-일상6) as abs일상,
    abs(의약1-의약2)+abs(의약2-의약3)+abs(의약3-의약4)+abs(의약4-의약5)+abs(의약5-의약6) as abs의약,
    abs(교육1-교육2)+abs(교육2-교육3)+abs(교육3-교육4)+abs(교육4-교육5)+abs(교육5-교육6) as abs교육,
    abs(디지털1-디지털2)+abs(디지털2-디지털3)+abs(디지털3-디지털4)+abs(디지털4-디지털5)+abs(디지털5-디지털6) as abs디지털,
    abs(가구1-가구2)+abs(가구2-가구3)+abs(가구3-가구4)+abs(가구4-가구5)+abs(가구5-가구6) as abs가구,
    abs(의류1-의류2)+abs(의류2-의류3)+abs(의류3-의류4)+abs(의류4-의류5)+abs(의류5-의류6) as abs의류,
    abs(전문스포츠1-전문스포츠2)+abs(전문스포츠2-전문스포츠3)+abs(전문스포츠3-전문스포츠4)+abs(전문스포츠4-전문스포츠5)+abs(전문스포츠5-전문스포츠6) as abs전문스포츠,
    abs(패션잡화1-패션잡화2)+abs(패션잡화2-패션잡화3)+abs(패션잡화3-패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6) as abs패션잡화,
    abs(명품1-명품2)+abs(명품2-명품3)+abs(명품3-명품4)+abs(명품4-명품5)+abs(명품5-명품6) as abs명품,
    abs(기타1-기타2)+abs(기타2-기타3)+abs(기타3-기타4)+abs(기타4-기타5)+abs(기타5-기타6) as abs기타,
    
    -(가공q14_1 - 가공q15_2) as 가공변화금액,
    -(신선q14_1 - 신선q15_2) as 신선변화금액,
    -(일상q14_1 - 일상q15_2) as 일상변화금액,
    -(의약q14_1 - 의약q15_2) as 의약변화금액,
    -(교육q14_1 - 교육q15_2) as 교육변화금액,
    -(디지털q14_1 - 디지털q15_2) as 디지털변화금액,
    -(가구q14_1 - 가구q15_2) as 가구변화금액,
    -(의류q14_1 - 의류q15_2) as 의류변화금액,
    -(전문스포츠q14_1 - 전문스포츠q15_2) as 전문스포츠변화금액,
    -(패션잡화q14_1 - 패션잡화q15_2) as 패션잡화변화금액,
    -(명품q14_1 - 명품q15_2) as 명품변화금액,
    -(기타q14_1 - 기타q15_2) as 기타변화금액
    
from mastertable;


drop table test;
create table test as
select 고객번호, 성별, 연령대분류,
    가공2 - 가공7 as 가공변화,
    신선2 - 신선7 as 신선변화,
    일상2 - 일상7 as 일상변화,
    의약2 - 의약7 as 의약변화,
    교육2 - 교육7 as 교육변화,
    디지털2 - 디지털7 as 디지털변화,
    가구2 - 가구7 as 가구변화,
    의류2 - 의류7 as 의류변화,
    전문스포츠2 - 전문스포츠7 as 전문스포츠변화,
    패션잡화2 - 패션잡화7 as 패션잡화변화,
    명품2 - 명품7 as 명품변화,
    기타2 - 기타7 as 기타변화,
    
    abs(가공2-가공3)+abs(가공3-가공4)+abs(가공4-가공5)+abs(가공5-가공6)+abs(가공6-가공7) as abs가공,
    abs(신선2-신선3)+abs(신선3-신선4)+abs(신선4-신선5)+abs(신선5-신선6)+abs(신선6-신선7) as abs신선,
    abs(일상2-일상3)+abs(일상3-일상4)+abs(일상4-일상5)+abs(일상5-일상6)+abs(일상6-일상7) as abs일상,
    abs(의약2-의약3)+abs(의약3-의약4)+abs(의약4-의약5)+abs(의약5-의약6)+abs(의약6-의약7) as abs의약,
    abs(교육2-교육3)+abs(교육3-교육4)+abs(교육4-교육5)+abs(교육5-교육6)+abs(교육6-교육7) as abs교육,
    abs(디지털2-디지털3)+abs(디지털3-디지털4)+abs(디지털4-디지털5)+abs(디지털5-디지털6) as abs디지털,
    abs(가구2-가구3)+abs(가구3-가구4)+abs(가구4-가구5)+abs(가구5-가구6)+abs(가구6-가구7) as abs가구,
    abs(의류2-의류3)+abs(의류3-의류4)+abs(의류4-의류5)+abs(의류5-의류6)+abs(의류6-의류7) as abs의류,
    abs(전문스포츠3-전문스포츠4)+abs(전문스포츠4-전문스포츠5)+abs(전문스포츠5-전문스포츠6)+abs(전문스포츠6-전문스포츠7) as abs전문스포츠,
    abs(패션잡화2-패션잡화3)+abs(패션잡화3-패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6)+abs(패션잡화6-패션잡화7) as abs패션잡화,
    abs(명품2-명품3)+abs(명품3-명품4)+abs(명품4-명품5)+abs(명품5-명품6)+abs(명품6-명품7) as abs명품,
    abs(기타2-기타3)+abs(기타3-기타4)+abs(기타4-기타5)+abs(기타5-기타6)+abs(기타6-기타7) as abs기타,
    
    -(가공q14_2 - 가공q15_3) as 가공변화금액,
    -(신선q14_2 - 신선q15_3) as 신선변화금액,
    -(일상q14_2 - 일상q15_3) as 일상변화금액,
    -(의약q14_2 - 의약q15_3) as 의약변화금액,
    -(교육q14_2 - 교육q15_3) as 교육변화금액,
    -(디지털q14_2 - 디지털q15_3) as 디지털변화금액,
    -(가구q14_2 - 가구q15_3) as 가구변화금액,
    -(의류q14_2 - 의류q15_3) as 의류변화금액,
    -(전문스포츠q14_2 - 전문스포츠q15_3) as 전문스포츠변화금액,
    -(패션잡화q14_2 - 패션잡화q15_3) as 패션잡화변화금액,
    -(명품q14_2 - 명품q15_3) as 명품변화금액,
    -(기타q14_2 - 기타q15_3) as 기타변화금액

from mastertable;

select * from train;
select * from test;

drop table train1;
create table train1 as
select t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타,
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
    
    ntile(10) over (order by min(case when p.구매일자 between 20140101 and 20150630 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
    ntile(10) over (order by count(p.고객번호)) as f,
    ntile(10) over (order by sum(p.계절성)) as m,
    
   case when (nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0) -
    nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0)) < 0 
    then 1 else 0 end as label
        
from train t
join purprod0 p on t.고객번호 = p.고객번호
group by t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
order by t.고객번호;

drop table test1;
create table test1 as
select  t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타,
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
    
    ntile(10) over (order by min(case when p.구매일자 between 20140401 and 20150930 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
    ntile(10) over (order by count(p.고객번호)) as f,
    ntile(10) over (order by sum(p.계절성)) as m,
    
    case when (nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0) -
    nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0)) < 0 
    then 1 else 0 end as label
    
from test t
join purprod0 p on t.고객번호 = p.고객번호
group by t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
order by t.고객번호;

select * from train1;
select * from test1;

drop table pro_pur6;
create table pro_pur6 as
select 고객번호, 
    가공q14_1, 가공q14_2, 가공q14_3, 가공q14_4, 가공q15_1, 가공q15_2, 가공q15_3, 가공q15_4,
    신선q14_1, 신선q14_2, 신선q14_3, 신선q14_4, 신선q15_1, 신선q15_2, 신선q15_3, 신선q15_4,
    일상q14_1, 일상q14_2, 일상q14_3, 일상q14_4, 일상q15_1, 일상q15_2, 일상q15_3, 일상q15_4,
    의약q14_1, 의약q14_2, 의약q14_3, 의약q14_4, 의약q15_1, 의약q15_2, 의약q15_3, 의약q15_4,
    교육q14_1, 교육q14_2, 교육q14_3, 교육q14_4, 교육q15_1, 교육q15_2, 교육q15_3, 교육q15_4,
    디지털q14_1, 디지털q14_2, 디지털q14_3, 디지털q14_4, 디지털q15_1, 디지털q15_2, 디지털q15_3, 디지털q15_4,
    가구q14_1, 가구q14_2, 가구q14_3, 가구q14_4, 가구q15_1, 가구q15_2, 가구q15_3, 가구q15_4,
    의류q14_1, 의류q14_2, 의류q14_3, 의류q14_4, 의류q15_1, 의류q15_2, 의류q15_3, 의류q15_4,
    전문스포츠q14_1, 전문스포츠q14_2, 전문스포츠q14_3, 전문스포츠q14_4, 전문스포츠q15_1, 전문스포츠q15_2, 전문스포츠q15_3, 전문스포츠q15_4,
    패션잡화q14_1, 패션잡화q14_2, 패션잡화q14_3, 패션잡화q14_4, 패션잡화q15_1, 패션잡화q15_2, 패션잡화q15_3, 패션잡화q15_4,
    명품q14_1, 명품q14_2, 명품q14_3, 명품q14_4, 명품q15_1, 명품q15_2, 명품q15_3, 명품q15_4,
    기타q14_1, 기타q14_2, 기타q14_3, 기타q14_4, 기타q15_1, 기타q15_2, 기타q15_3, 기타q15_4,
    
    case when 가공q14_1 <> 0 then ntile(10) over (order by 가공q14_1 desc) else 10 end as 가공1,
    case when 가공q14_2 <> 0 then ntile(10) over (order by 가공q14_2 desc) else 10 end as 가공2,
    case when 가공q14_3 <> 0 then ntile(10) over (order by 가공q14_3 desc) else 10 end as 가공3,
    case when 가공q14_4 <> 0 then ntile(10) over (order by 가공q14_4 desc) else 10 end as 가공4,
    case when 가공q15_1 <> 0 then ntile(10) over (order by 가공q15_1 desc) else 10 end as 가공5,
    case when 가공q15_2 <> 0 then ntile(10) over (order by 가공q15_2 desc) else 10 end as 가공6,
    case when 가공q15_3 <> 0 then ntile(10) over (order by 가공q15_3 desc) else 10 end as 가공7,
    case when 가공q15_4 <> 0 then ntile(10) over (order by 가공q15_4 desc) else 10 end as 가공8,
    
    case when 신선q14_1 <> 0 then ntile(10) over (order by 신선q14_1 desc) else 10 end as 신선1,
    case when 신선q14_2 <> 0 then ntile(10) over (order by 신선q14_2 desc) else 10 end as 신선2,
    case when 신선q14_3 <> 0 then ntile(10) over (order by 신선q14_3 desc) else 10 end as 신선3,
    case when 신선q14_4 <> 0 then ntile(10) over (order by 신선q14_4 desc) else 10 end as 신선4,
    case when 신선q15_1 <> 0 then ntile(10) over (order by 신선q15_1 desc) else 10 end as 신선5,
    case when 신선q15_2 <> 0 then ntile(10) over (order by 신선q15_2 desc) else 10 end as 신선6,
    case when 신선q15_3 <> 0 then ntile(10) over (order by 신선q15_3 desc) else 10 end as 신선7,
    case when 신선q15_4 <> 0 then ntile(10) over (order by 신선q15_4 desc) else 10 end as 신선8,
    
    case when 일상q14_1 <> 0 then ntile(10) over (order by 일상q14_1 desc) else 10 end as 일상1,
    case when 일상q14_2 <> 0 then ntile(10) over (order by 일상q14_2 desc) else 10 end as 일상2,
    case when 일상q14_3 <> 0 then ntile(10) over (order by 일상q14_3 desc) else 10 end as 일상3,
    case when 일상q14_4 <> 0 then ntile(10) over (order by 일상q14_4 desc) else 10 end as 일상4,
    case when 일상q15_1 <> 0 then ntile(10) over (order by 일상q15_1 desc) else 10 end as 일상5,
    case when 일상q15_2 <> 0 then ntile(10) over (order by 일상q15_2 desc) else 10 end as 일상6,
    case when 일상q15_3 <> 0 then ntile(10) over (order by 일상q15_3 desc) else 10 end as 일상7,
    case when 일상q15_4 <> 0 then ntile(10) over (order by 일상q15_4 desc) else 10 end as 일상8,
    
    case when 의약q14_1 <> 0 then ntile(10) over (order by 의약q14_1 desc) else 10 end as 의약1,
    case when 의약q14_2 <> 0 then ntile(10) over (order by 의약q14_2 desc) else 10 end as 의약2,
    case when 의약q14_3 <> 0 then ntile(10) over (order by 의약q14_3 desc) else 10 end as 의약3,
    case when 의약q14_4 <> 0 then ntile(10) over (order by 의약q14_4 desc) else 10 end as 의약4,
    case when 의약q15_1 <> 0 then ntile(10) over (order by 의약q15_1 desc) else 10 end as 의약5,
    case when 의약q15_2 <> 0 then ntile(10) over (order by 의약q15_2 desc) else 10 end as 의약6,
    case when 의약q15_3 <> 0 then ntile(10) over (order by 의약q15_3 desc) else 10 end as 의약7,
    case when 의약q15_4 <> 0 then ntile(10) over (order by 의약q15_4 desc) else 10 end as 의약8,
    
    case when 교육q14_1 <> 0 then ntile(10) over (order by 교육q14_1 desc) else 10 end as 교육1,
    case when 교육q14_2 <> 0 then ntile(10) over (order by 교육q14_2 desc) else 10 end as 교육2,
    case when 교육q14_3 <> 0 then ntile(10) over (order by 교육q14_3 desc) else 10 end as 교육3,
    case when 교육q14_4 <> 0 then ntile(10) over (order by 교육q14_4 desc) else 10 end as 교육4,
    case when 교육q15_1 <> 0 then ntile(10) over (order by 교육q15_1 desc) else 10 end as 교육5,
    case when 교육q15_2 <> 0 then ntile(10) over (order by 교육q15_2 desc) else 10 end as 교육6,
    case when 교육q15_3 <> 0 then ntile(10) over (order by 교육q15_3 desc) else 10 end as 교육7,
    case when 교육q15_4 <> 0 then ntile(10) over (order by 교육q15_4 desc) else 10 end as 교육8,
    
    case when 디지털q14_1 <> 0 then ntile(10) over (order by 디지털q14_1 desc) else 10 end as 디지털1,
    case when 디지털q14_2 <> 0 then ntile(10) over (order by 디지털q14_2 desc) else 10 end as 디지털2,
    case when 디지털q14_3 <> 0 then ntile(10) over (order by 디지털q14_3 desc) else 10 end as 디지털3,
    case when 디지털q14_4 <> 0 then ntile(10) over (order by 디지털q14_4 desc) else 10 end as 디지털4,
    case when 디지털q15_1 <> 0 then ntile(10) over (order by 디지털q15_1 desc) else 10 end as 디지털5,
    case when 디지털q15_2 <> 0 then ntile(10) over (order by 디지털q15_2 desc) else 10 end as 디지털6,
    case when 디지털q15_3 <> 0 then ntile(10) over (order by 디지털q15_3 desc) else 10 end as 디지털7,
    case when 디지털q15_4 <> 0 then ntile(10) over (order by 디지털q15_4 desc) else 10 end as 디지털8,
    
    case when 가구q14_1 <> 0 then ntile(10) over (order by 가구q14_1 desc) else 10 end as 가구1,
    case when 가구q14_2 <> 0 then ntile(10) over (order by 가구q14_2 desc) else 10 end as 가구2,
    case when 가구q14_3 <> 0 then ntile(10) over (order by 가구q14_3 desc) else 10 end as 가구3,
    case when 가구q14_4 <> 0 then ntile(10) over (order by 가구q14_4 desc) else 10 end as 가구4,
    case when 가구q15_1 <> 0 then ntile(10) over (order by 가구q15_1 desc) else 10 end as 가구5,
    case when 가구q15_2 <> 0 then ntile(10) over (order by 가구q15_2 desc) else 10 end as 가구6,
    case when 가구q15_3 <> 0 then ntile(10) over (order by 가구q15_3 desc) else 10 end as 가구7,
    case when 가구q15_4 <> 0 then ntile(10) over (order by 가구q15_4 desc) else 10 end as 가구8,
    
    case when 의류q14_1 <> 0 then ntile(10) over (order by 의류q14_1 desc) else 10 end as 의류1,
    case when 의류q14_2 <> 0 then ntile(10) over (order by 의류q14_2 desc) else 10 end as 의류2,
    case when 의류q14_3 <> 0 then ntile(10) over (order by 의류q14_3 desc) else 10 end as 의류3,
    case when 의류q14_4 <> 0 then ntile(10) over (order by 의류q14_4 desc) else 10 end as 의류4,
    case when 의류q15_1 <> 0 then ntile(10) over (order by 의류q15_1 desc) else 10 end as 의류5,
    case when 의류q15_2 <> 0 then ntile(10) over (order by 의류q15_2 desc) else 10 end as 의류6,
    case when 의류q15_3 <> 0 then ntile(10) over (order by 의류q15_3 desc) else 10 end as 의류7,
    case when 의류q15_4 <> 0 then ntile(10) over (order by 의류q15_4 desc) else 10 end as 의류8,
    
    case when 전문스포츠q14_1 <> 0 then ntile(10) over (order by 전문스포츠q14_1 desc) else 10 end as 전문스포츠1,
    case when 전문스포츠q14_2 <> 0 then ntile(10) over (order by 전문스포츠q14_2 desc) else 10 end as 전문스포츠2,
    case when 전문스포츠q14_3 <> 0 then ntile(10) over (order by 전문스포츠q14_3 desc) else 10 end as 전문스포츠3,
    case when 전문스포츠q14_4 <> 0 then ntile(10) over (order by 전문스포츠q14_4 desc) else 10 end as 전문스포츠4,
    case when 전문스포츠q15_1 <> 0 then ntile(10) over (order by 전문스포츠q15_1 desc) else 10 end as 전문스포츠5,
    case when 전문스포츠q15_2 <> 0 then ntile(10) over (order by 전문스포츠q15_2 desc) else 10 end as 전문스포츠6,
    case when 전문스포츠q15_3 <> 0 then ntile(10) over (order by 전문스포츠q15_3 desc) else 10 end as 전문스포츠7,
    case when 전문스포츠q15_4 <> 0 then ntile(10) over (order by 전문스포츠q15_4 desc) else 10 end as 전문스포츠8,
    
    case when 패션잡화q14_1 <> 0 then ntile(10) over (order by 패션잡화q14_1 desc) else 10 end as 패션잡화1,
    case when 패션잡화q14_2 <> 0 then ntile(10) over (order by 패션잡화q14_2 desc) else 10 end as 패션잡화2,
    case when 패션잡화q14_3 <> 0 then ntile(10) over (order by 패션잡화q14_3 desc) else 10 end as 패션잡화3,
    case when 패션잡화q14_4 <> 0 then ntile(10) over (order by 패션잡화q14_4 desc) else 10 end as 패션잡화4,
    case when 패션잡화q15_1 <> 0 then ntile(10) over (order by 패션잡화q15_1 desc) else 10 end as 패션잡화5,
    case when 패션잡화q15_2 <> 0 then ntile(10) over (order by 패션잡화q15_2 desc) else 10 end as 패션잡화6,
    case when 패션잡화q15_3 <> 0 then ntile(10) over (order by 패션잡화q15_3 desc) else 10 end as 패션잡화7,
    case when 패션잡화q15_4 <> 0 then ntile(10) over (order by 패션잡화q15_4 desc) else 10 end as 패션잡화8,
    
    case when 명품q14_1 <> 0 then ntile(10) over (order by 명품q14_1 desc) else 10 end as 명품1,
    case when 명품q14_2 <> 0 then ntile(10) over (order by 명품q14_2 desc) else 10 end as 명품2,
    case when 명품q14_3 <> 0 then ntile(10) over (order by 명품q14_3 desc) else 10 end as 명품3,
    case when 명품q14_4 <> 0 then ntile(10) over (order by 명품q14_4 desc) else 10 end as 명품4,
    case when 명품q15_1 <> 0 then ntile(10) over (order by 명품q15_1 desc) else 10 end as 명품5,
    case when 명품q15_2 <> 0 then ntile(10) over (order by 명품q15_2 desc) else 10 end as 명품6,
    case when 명품q15_3 <> 0 then ntile(10) over (order by 명품q15_3 desc) else 10 end as 명품7,
    case when 명품q15_4 <> 0 then ntile(10) over (order by 명품q15_4 desc) else 10 end as 명품8,
    
    case when 기타q14_1 <> 0 then ntile(10) over (order by 기타q14_1 desc) else 10 end as 기타1,
    case when 기타q14_2 <> 0 then ntile(10) over (order by 기타q14_2 desc) else 10 end as 기타2,
    case when 기타q14_3 <> 0 then ntile(10) over (order by 기타q14_3 desc) else 10 end as 기타3,
    case when 기타q14_4 <> 0 then ntile(10) over (order by 기타q14_4 desc) else 10 end as 기타4,
    case when 기타q15_1 <> 0 then ntile(10) over (order by 기타q15_1 desc) else 10 end as 기타5,
    case when 기타q15_2 <> 0 then ntile(10) over (order by 기타q15_2 desc) else 10 end as 기타6,
    case when 기타q15_3 <> 0 then ntile(10) over (order by 기타q15_3 desc) else 10 end as 기타7,
    case when 기타q15_4 <> 0 then ntile(10) over (order by 기타q15_4 desc) else 10 end as 기타8
    
from pro_pur
order by 고객번호;

select * from pro_pur6;

drop table mastertable1;
create table mastertable1 as
SELECT d.고객번호, d.성별, 
    case 
        when 연령대 in ('19세이하', '20세~24세', '25세~29세') then '청년층'
        when 연령대 in ('30세~34세', '35세~39세', '40세~44세', '45세~49세') then '중년층'
        when 연령대 in ('50세~54세', '55세~59세', '60세이상') then '노년층'
    end as 연령대분류,
    
    p.가공q14_1, p.가공q14_2, p.가공q14_3, p.가공q14_4, p.가공q15_1, p.가공q15_2, p.가공q15_3, p.가공q15_4,
    p.신선q14_1, p.신선q14_2, p.신선q14_3, p.신선q14_4, p.신선q15_1, p.신선q15_2, p.신선q15_3, p.신선q15_4,
    p.일상q14_1, p.일상q14_2, p.일상q14_3, p.일상q14_4, p.일상q15_1, p.일상q15_2, p.일상q15_3, p.일상q15_4,
    p.의약q14_1, p.의약q14_2, p.의약q14_3, p.의약q14_4, p.의약q15_1, p.의약q15_2, p.의약q15_3, p.의약q15_4,
    p.교육q14_1, p.교육q14_2, p.교육q14_3, p.교육q14_4, p.교육q15_1, p.교육q15_2, p.교육q15_3, p.교육q15_4,
    p.디지털q14_1, p.디지털q14_2, p.디지털q14_3, p.디지털q14_4, p.디지털q15_1, p.디지털q15_2, p.디지털q15_3, p.디지털q15_4,
    p.가구q14_1, p.가구q14_2, p.가구q14_3, p.가구q14_4, p.가구q15_1, p.가구q15_2, p.가구q15_3, p.가구q15_4,
    p.의류q14_1, p.의류q14_2, p.의류q14_3, p.의류q14_4, p.의류q15_1, p.의류q15_2, p.의류q15_3, p.의류q15_4,
    p.전문스포츠q14_1, p.전문스포츠q14_2, p.전문스포츠q14_3, p.전문스포츠q14_4, p.전문스포츠q15_1, p.전문스포츠q15_2, p.전문스포츠q15_3, p.전문스포츠q15_4,
    p.패션잡화q14_1, p.패션잡화q14_2, p.패션잡화q14_3, p.패션잡화q14_4, p.패션잡화q15_1, p.패션잡화q15_2, p.패션잡화q15_3, p.패션잡화q15_4,
    p.명품q14_1, p.명품q14_2, p.명품q14_3, p.명품q14_4, p.명품q15_1, p.명품q15_2, p.명품q15_3, p.명품q15_4,
    p.기타q14_1, p.기타q14_2, p.기타q14_3, p.기타q14_4, p.기타q15_1, p.기타q15_2, p.기타q15_3, p.기타q15_4,
    p.가공1, p.가공2, p.가공3, p.가공4, p.가공5, p.가공6, p.가공7, p.가공8,
    p.신선1, p.신선2, p.신선3, p.신선4, p.신선5, p.신선6, p.신선7, p.신선8,
    p.일상1, p.일상2, p.일상3, p.일상4, p.일상5, p.일상6, p.일상7, p.일상8,
    p.의약1, p.의약2, p.의약3, p.의약4, p.의약5, p.의약6, p.의약7, p.의약8,
    p.교육1, p.교육2, p.교육3, p.교육4, p.교육5, p.교육6, p.교육7, p.교육8,
    p.디지털1, p.디지털2, p.디지털3, p.디지털4, p.디지털5, p.디지털6, p.디지털7, p.디지털8,
    p.가구1, p.가구2, p.가구3, p.가구4, p.가구5, p.가구6, p.가구7, p.가구8,
    p.의류1, p.의류2, p.의류3, p.의류4, p.의류5, p.의류6, p.의류7, p.의류8,
    p.전문스포츠1, p.전문스포츠2, p.전문스포츠3, p.전문스포츠4, p.전문스포츠5, p.전문스포츠6, p.전문스포츠7, p.전문스포츠8,
    p.패션잡화1, p.패션잡화2, p.패션잡화3, p.패션잡화4, p.패션잡화5, p.패션잡화6, p.패션잡화7, p.패션잡화8,
    p.명품1, p.명품2, p.명품3, p.명품4, p.명품5, p.명품6, p.명품7, p.명품8,
    p.기타1, p.기타2, p.기타3, p.기타4, p.기타5, p.기타6, p.기타7, p.기타8
    
FROM demo d
JOIN pro_pur6 p ON d.고객번호 = p.고객번호
ORDER BY d.고객번호;

select * from mastertable1;

drop table train2;
create table train2 as
select 고객번호, 성별, 연령대분류,
    가공1 - 가공6 as 가공변화,
    신선1 - 신선6 as 신선변화,
    일상1 - 일상6 as 일상변화,
    의약1 - 의약6 as 의약변화,
    교육1 - 교육6 as 교육변화,
    디지털1 - 디지털6 as 디지털변화,
    가구1 - 가구6 as 가구변화,
    의류1 - 의류6 as 의류변화,
    전문스포츠1 - 전문스포츠6 as 전문스포츠변화,
    패션잡화1 - 패션잡화6 as 패션잡화변화,
    명품1 - 명품6 as 명품변화,
    기타1 - 기타6 as 기타변화,
    
    abs(가공1-가공2)+abs(가공2-가공3)+abs(가공3-가공4)+abs(가공4-가공5)+abs(가공5-가공6) as abs가공,
    abs(신선1-신선2)+abs(신선2-신선3)+abs(신선3-신선4)+abs(신선4-신선5)+abs(신선5-신선6) as abs신선,
    abs(일상1-일상2)+abs(일상2-일상3)+abs(일상3-일상4)+abs(일상4-일상5)+abs(일상5-일상6) as abs일상,
    abs(의약1-의약2)+abs(의약2-의약3)+abs(의약3-의약4)+abs(의약4-의약5)+abs(의약5-의약6) as abs의약,
    abs(교육1-교육2)+abs(교육2-교육3)+abs(교육3-교육4)+abs(교육4-교육5)+abs(교육5-교육6) as abs교육,
    abs(디지털1-디지털2)+abs(디지털2-디지털3)+abs(디지털3-디지털4)+abs(디지털4-디지털5)+abs(디지털5-디지털6) as abs디지털,
    abs(가구1-가구2)+abs(가구2-가구3)+abs(가구3-가구4)+abs(가구4-가구5)+abs(가구5-가구6) as abs가구,
    abs(의류1-의류2)+abs(의류2-의류3)+abs(의류3-의류4)+abs(의류4-의류5)+abs(의류5-의류6) as abs의류,
    abs(전문스포츠1-전문스포츠2)+abs(전문스포츠2-전문스포츠3)+abs(전문스포츠3-전문스포츠4)+abs(전문스포츠4-전문스포츠5)+abs(전문스포츠5-전문스포츠6) as abs전문스포츠,
    abs(패션잡화1-패션잡화2)+abs(패션잡화2-패션잡화3)+abs(패션잡화3-패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6) as abs패션잡화,
    abs(명품1-명품2)+abs(명품2-명품3)+abs(명품3-명품4)+abs(명품4-명품5)+abs(명품5-명품6) as abs명품,
    abs(기타1-기타2)+abs(기타2-기타3)+abs(기타3-기타4)+abs(기타4-기타5)+abs(기타5-기타6) as abs기타,
    
    -(가공q14_1 - 가공q15_2) as 가공변화금액,
    -(신선q14_1 - 신선q15_2) as 신선변화금액,
    -(일상q14_1 - 일상q15_2) as 일상변화금액,
    -(의약q14_1 - 의약q15_2) as 의약변화금액,
    -(교육q14_1 - 교육q15_2) as 교육변화금액,
    -(디지털q14_1 - 디지털q15_2) as 디지털변화금액,
    -(가구q14_1 - 가구q15_2) as 가구변화금액,
    -(의류q14_1 - 의류q15_2) as 의류변화금액,
    -(전문스포츠q14_1 - 전문스포츠q15_2) as 전문스포츠변화금액,
    -(패션잡화q14_1 - 패션잡화q15_2) as 패션잡화변화금액,
    -(명품q14_1 - 명품q15_2) as 명품변화금액,
    -(기타q14_1 - 기타q15_2) as 기타변화금액
    
from mastertable1;


drop table test2;
create table test2 as
select 고객번호, 성별, 연령대분류,
    가공2 - 가공7 as 가공변화,
    신선2 - 신선7 as 신선변화,
    일상2 - 일상7 as 일상변화,
    의약2 - 의약7 as 의약변화,
    교육2 - 교육7 as 교육변화,
    디지털2 - 디지털7 as 디지털변화,
    가구2 - 가구7 as 가구변화,
    의류2 - 의류7 as 의류변화,
    전문스포츠2 - 전문스포츠7 as 전문스포츠변화,
    패션잡화2 - 패션잡화7 as 패션잡화변화,
    명품2 - 명품7 as 명품변화,
    기타2 - 기타7 as 기타변화,
    
    abs(가공2-가공3)+abs(가공3-가공4)+abs(가공4-가공5)+abs(가공5-가공6)+abs(가공6-가공7) as abs가공,
    abs(신선2-신선3)+abs(신선3-신선4)+abs(신선4-신선5)+abs(신선5-신선6)+abs(신선6-신선7) as abs신선,
    abs(일상2-일상3)+abs(일상3-일상4)+abs(일상4-일상5)+abs(일상5-일상6)+abs(일상6-일상7) as abs일상,
    abs(의약2-의약3)+abs(의약3-의약4)+abs(의약4-의약5)+abs(의약5-의약6)+abs(의약6-의약7) as abs의약,
    abs(교육2-교육3)+abs(교육3-교육4)+abs(교육4-교육5)+abs(교육5-교육6)+abs(교육6-교육7) as abs교육,
    abs(디지털2-디지털3)+abs(디지털3-디지털4)+abs(디지털4-디지털5)+abs(디지털5-디지털6)+abs(디지털6-디지털7) as abs디지털,
    abs(가구2-가구3)+abs(가구3-가구4)+abs(가구4-가구5)+abs(가구5-가구6)+abs(가구6-가구7) as abs가구,
    abs(의류2-의류3)+abs(의류3-의류4)+abs(의류4-의류5)+abs(의류5-의류6)+abs(의류6-의류7) as abs의류,
    abs(전문스포츠2-전문스포츠3)+abs(전문스포츠3-전문스포츠4)+abs(전문스포츠4-전문스포츠5)+abs(전문스포츠5-전문스포츠6)+abs(전문스포츠6-전문스포츠7) as abs전문스포츠,
    abs(패션잡화2-패션잡화3)+abs(패션잡화3-패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6)+abs(패션잡화6-패션잡화7) as abs패션잡화,
    abs(명품2-명품3)+abs(명품3-명품4)+abs(명품4-명품5)+abs(명품5-명품6)+abs(명품6-명품7) as abs명품,
    abs(기타2-기타3)+abs(기타3-기타4)+abs(기타4-기타5)+abs(기타5-기타6)+abs(기타6-기타7) as abs기타,
    
    -(가공q14_2 - 가공q15_3) as 가공변화금액,
    -(신선q14_2 - 신선q15_3) as 신선변화금액,
    -(일상q14_2 - 일상q15_3) as 일상변화금액,
    -(의약q14_2 - 의약q15_3) as 의약변화금액,
    -(교육q14_2 - 교육q15_3) as 교육변화금액,
    -(디지털q14_2 - 디지털q15_3) as 디지털변화금액,
    -(가구q14_2 - 가구q15_3) as 가구변화금액,
    -(의류q14_2 - 의류q15_3) as 의류변화금액,
    -(전문스포츠q14_2 - 전문스포츠q15_3) as 전문스포츠변화금액,
    -(패션잡화q14_2 - 패션잡화q15_3) as 패션잡화변화금액,
    -(명품q14_2 - 명품q15_3) as 명품변화금액,
    -(기타q14_2 - 기타q15_3) as 기타변화금액
    
from mastertable1;

select 고객번호,
    CASE 
        WHEN (가공q15_3 - 가공q14_2) > 0 THEN round(POWER((가공q15_3 - 가공q14_2), 1/6) - 1, 2)
        when (가공q15_3 - 가공q14_2) < 0 THEN -round(POWER(abs(가공q15_3 - 가공q14_2), 1/6) -1, 2)
        else 0
    end as cagr
from mastertable1;

select * from train2;
select * from test2;

drop table train3;
create table train3 as
select t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타,
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
    
    ntile(10) over (order by min(case when p.구매일자 between 20140101 and 20150630 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
    ntile(10) over (order by count(p.고객번호)) as f,
    ntile(10) over (order by sum(p.계절성) desc) as m,
    
    CASE 
        WHEN 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)) > 0 
        THEN 
        round(POWER((nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)), 1/6) - 1, 2)
        when 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)) < 0 
        THEN 
        -round(POWER(abs(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)), 1/6) -1, 2)
        else 0
    end as cagr,
    
--    (ntile(10) over (order by (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0)))) -
--    (ntile(10) over (order by (nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)))) as diff,
    
    case when
    (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then p.계절성 end), 0) - 
    nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then p.계절성 end), 0)) < 0 and
    ((nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then p.계절성 end), 0) -
    nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then p.계절성 end), 0)) /
    nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then p.계절성 end), 0)) < -0.1
    then 1 else 0 end as label
        
from train2 t
join purprod0 p on t.고객번호 = p.고객번호
group by t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
order by t.고객번호;

--train 과 test
drop table test3;
create table test3 as
select t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타,
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
    
    ntile(10) over (order by min(case when p.구매일자 between 20140401 and 20150930 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
    ntile(10) over (order by count(p.고객번호)) as f,
    ntile(10) over (order by sum(p.계절성) desc) as m,
    
    CASE 
        WHEN 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0)) > 0 
        THEN 
        round(POWER((nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0)), 1/6) - 1, 2)
        when 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0)) < 0 
        THEN 
        -round(POWER(abs(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0)), 1/6) -1, 2)
        else 0
    end as cagr,
    
--    (ntile(10) over (order by (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0)))) -
--    (ntile(10) over (order by (nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0)))) as diff,
    
    case when
    (nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then p.계절성 end), 0) - 
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then p.계절성 end), 0)) < 0 and
    ((nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then p.계절성 end), 0) -
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then p.계절성 end), 0)) /
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then p.계절성 end), 0)) < -0.1
    then 1 else 0 end as label
    
from test2 t
join purprod0 p on t.고객번호 = p.고객번호
group by t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
order by t.고객번호;

select * from train3;
select * from test3;

select 고객번호,
    
    min(case when 구매일자 between 20140701 and 20151231 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(구매일자 , 'YYYY-MM-DD') end),
    
    ntile(10) over (order by min(case when 구매일자 between 20140401 and 20150930 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(구매일자 , 'YYYY-MM-DD') end) desc) as r,
    
    count(고객번호),
    ntile(10) over (order by count(고객번호)) as f,
    
    sum(계절성),
    ntile(10) over (order by sum(계절성) desc) as m,
    
    (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0) - 
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)),
    
--    ((nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0) -
--    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)) /
--    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)),
    
    case when
    (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0) - 
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)) < 0 and
    ((nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0) -
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)) /
    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)) < -0.1
    then 1 else 0 end as label
    
from purprod0
group by 고객번호
order by 고객번호;

drop table train4;
create table train4 as
select 고객번호, 성별, 연령대분류,
    가공3 - 가공8 as 가공변화,
    신선3 - 신선8 as 신선변화,
    일상3 - 일상8 as 일상변화,
    의약3 - 의약8 as 의약변화,
    교육3 - 교육8 as 교육변화,
    디지털3 - 디지털8 as 디지털변화,
    가구3 - 가구8 as 가구변화,
    의류3 - 의류8 as 의류변화,
    전문스포츠3 - 전문스포츠8 as 전문스포츠변화,
    패션잡화3 - 패션잡화8 as 패션잡화변화,
    명품3 - 명품8 as 명품변화,
    기타3 - 기타8 as 기타변화,
    
    abs(가공3-가공4)+abs(가공4-가공5)+abs(가공5-가공6)+abs(가공6-가공7)+abs(가공7-가공8) as abs가공,
    abs(신선3-신선4)+abs(신선4-신선5)+abs(신선5-신선6)+abs(신선6-신선7)+abs(신선7-신선8) as abs신선,
    abs(일상3-일상4)+abs(일상4-일상5)+abs(일상5-일상6)+abs(일상6-일상7)+abs(일상7-일상8) as abs일상,
    abs(의약3-의약4)+abs(의약4-의약5)+abs(의약5-의약6)+abs(의약6-의약7)+abs(의약7-의약8) as abs의약,
    abs(교육3-교육4)+abs(교육4-교육5)+abs(교육5-교육6)+abs(교육6-교육7)+abs(교육7-교육8) as abs교육,
    abs(디지털3-디지털4)+abs(디지털4-디지털5)+abs(디지털5-디지털6)+abs(디지털6-디지털7)+abs(디지털7-디지털8) as abs디지털,
    abs(가구3-가구4)+abs(가구4-가구5)+abs(가구5-가구6)+abs(가구6-가구7)+abs(가구7-가구8) as abs가구,
    abs(의류3-의류4)+abs(의류4-의류5)+abs(의류5-의류6)+abs(의류6-의류7)+abs(의류7-의류8) as abs의류,
    abs(전문스포츠3-전문스포츠4)+abs(전문스포츠4-전문스포츠5)+abs(전문스포츠5-전문스포츠6)+abs(전문스포츠6-전문스포츠7)+abs(전문스포츠7-전문스포츠8) as abs전문스포츠,
    abs(패션잡화3-패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6)+abs(패션잡화6-패션잡화7)+abs(패션잡화7-패션잡화8) as abs패션잡화,
    abs(명품3-명품4)+abs(명품4-명품5)+abs(명품5-명품6)+abs(명품6-명품7)+abs(명품7-명품8) as abs명품,
    abs(기타3-기타4)+abs(기타4-기타5)+abs(기타5-기타6)+abs(기타6-기타7)+abs(기타7-기타8) as abs기타,
    
    -(가공q14_3 - 가공q15_4) as 가공변화금액,
    -(신선q14_3 - 신선q15_4) as 신선변화금액,
    -(일상q14_3 - 일상q15_4) as 일상변화금액,
    -(의약q14_3 - 의약q15_4) as 의약변화금액,
    -(교육q14_3 - 교육q15_4) as 교육변화금액,
    -(디지털q14_3 - 디지털q15_4) as 디지털변화금액,
    -(가구q14_3 - 가구q15_4) as 가구변화금액,
    -(의류q14_3 - 의류q15_4) as 의류변화금액,
    -(전문스포츠q14_3 - 전문스포츠q15_4) as 전문스포츠변화금액,
    -(패션잡화q14_3 - 패션잡화q15_4) as 패션잡화변화금액,
    -(명품q14_3 - 명품q15_4) as 명품변화금액,
    -(기타q14_3 - 기타q15_4) as 기타변화금액
    
from mastertable1;


--q3-q8
drop table train5;
create table train5 as
select t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타,
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
    
    ntile(10) over (order by min(case when p.구매일자 between 20140701 and 20151231 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
    ntile(10) over (order by count(p.고객번호)) as f,
    ntile(10) over (order by sum(p.계절성) desc) as m,
    
    CASE 
        WHEN 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0)) > 0 
        THEN 
        round(POWER((nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0)), 1/6) - 1, 2)
        when 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0)) < 0 
        THEN 
        -round(POWER(abs(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0)), 1/6) -1, 2)
        else 0
    end as cagr
    
from train4 t
join purprod0 p on t.고객번호 = p.고객번호
group by t.고객번호, t.성별, t.연령대분류, 
    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
    t.패션잡화변화, t.명품변화, t.기타변화,
    
    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
    t.abs명품,t.abs기타
    
--    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
--    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
order by t.고객번호;

select * from train5;

--
--drop table train6;
--create table train6 as
--select t.성별, t.연령대분류, 
--    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
--    t.패션잡화변화, t.명품변화, t.기타변화,
--    
--    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
--    t.abs명품,t.abs기타,
--    
----    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
----    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
--    
--    ntile(10) over (order by min(case when p.구매일자 between 20140101 and 20150630 then
--    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
--    ntile(10) over (order by count(p.고객번호)) as f,
--    ntile(10) over (order by sum(p.계절성) desc) as m,
--    
--    case when
--    (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0) -
--    nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then 계절성 end), 0)) < 0
--    then 1 else 0 end as label
--        
--from train2 t
--join purprod0 p on t.고객번호 = p.고객번호
--group by t.고객번호, t.성별, t.연령대분류, 
--    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
--    t.패션잡화변화, t.명품변화, t.기타변화,
--    
--    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
--    t.abs명품,t.abs기타
--    
----    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
----    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
--order by t.고객번호;

--drop table test6;
--create table test6 as
--select  t.성별, t.연령대분류, 
--    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
--    t.패션잡화변화, t.명품변화, t.기타변화,
--    
--    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
--    t.abs명품,t.abs기타,
--    
----    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
----    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액,
--    
--    ntile(10) over (order by min(case when p.구매일자 between 20140401 and 20150930 then
--    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
--    ntile(10) over (order by count(p.고객번호)) as f,
--    ntile(10) over (order by sum(p.계절성) desc) as m,
--    
--    case when
--    (nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then 계절성 end), 0) -
--    nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0)) < 0
--    then 1 else 0 end as label
--    
--from test2 t
--join purprod0 p on t.고객번호 = p.고객번호
--group by t.고객번호, t.성별, t.연령대분류, 
--    t.가공변화, t.신선변화, t.일상변화, t.의약변화, t.교육변화, t.디지털변화, t.가구변화, t.의류변화, t.전문스포츠변화, 
--    t.패션잡화변화, t.명품변화, t.기타변화,
--    
--    t.abs가공,t.abs신선,t.abs일상,t.abs의약,t.abs교육,t.abs디지털,t.abs가구,t.abs의류,t.abs전문스포츠,t.abs패션잡화,
--    t.abs명품,t.abs기타
--    
----    t.가공변화금액,t.신선변화금액,t.일상변화금액,t.의약변화금액,t.교육변화금액,t.디지털변화금액,t.가구변화금액,t.의류변화금액,t.전문스포츠변화금액,
----    t.패션잡화변화금액,t.명품변화금액,t.기타변화금액
--order by t.고객번호;
--
--select * from train6;
--select * from test6;

select 고객번호,
    nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then 계절성 end), 0),
    nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then 계절성 end), 0),
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then 계절성 end), 0))desc)) as 분1,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0))desc)) as 분2,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 07 and 09 then 계절성 end), 0))desc)) as 분3,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 10 and 12 then 계절성 end), 0))desc)) as 분4,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 01 and 03 then 계절성 end), 0))desc)) as 분5,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 04 and 06 then 계절성 end), 0))desc)) as 분6,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0))desc)) as 분7,
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then 계절성 end), 0))desc)) as 분8,

    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then 계절성 end), 0))desc)) as 분기1,
    
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 07 and 09 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 04 and 06 then 계절성 end), 0))desc)) as 분기2,
    
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 10 and 12 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 07 and 09 then 계절성 end), 0))desc)) as 분기3,
    
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 01 and 03 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 10 and 12 then 계절성 end), 0))desc)) as 분기4,
    
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 04 and 06 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 01 and 03 then 계절성 end), 0))desc)) as 분기5,
    
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 04 and 06 then 계절성 end), 0))desc)) as 분기6,
    
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 07 and 09 then 계절성 end), 0))desc)) as 분기7,
    
    -((ntile(10) over (order by (nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then 계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then 계절성 end), 0))desc))) as diff
    
from purprod0
group by 고객번호
order by 고객번호;

--군집화

select * from mastertable1;

select * from purprod0;
select * from total_code0 where 임의분류명 = '기타';
select * from pro_pur;

select 
    nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 05 then p.계절성 end), 0),
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0),
    round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 05 then p.계절성 end), 0)/
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0),10)
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호
order by p.고객번호;

drop table prefer;
create table prefer as
select p.고객번호,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 가공구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 01 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 가공구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 신선구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 02 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 신선구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 일상구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 03 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 일상구매금액8,
--    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 의약구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 05 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 의약구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 교육구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 06 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 교육구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 디지털구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 07 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 디지털구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 가구구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 08 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 가구구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 의류구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 09 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 의류구매금액8,

    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 전문스포츠구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 10 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 전문스포츠구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 패션잡화구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 11 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 패션잡화구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 명품구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 12 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 명품구매금액8,
    
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100 as 기타구매금액1,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액2,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액3,
    nvl(round(nvl(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2014 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액4,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 01 and 03 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액5,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 04 and 06 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액6,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 07 and 09 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액7,
    nvl(round(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 and t.통합코드 = 99 then p.계절성 end), 0) /
    nullif(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0), 3), 0) * 100  as 기타구매금액8
    
    
    
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호
order by p.고객번호;

select * from prefer;

drop table prefer1;
create table prefer1 as
select 고객번호, 
    case 
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 가공구매금액1
        then 01 
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 신선구매금액1
        then 02 
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 일상구매금액1
        then 03
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 의약구매금액1
        then 05
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 교육구매금액1
        then 06
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 디지털구매금액1
        then 07
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 가구구매금액1
        then 08
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 의류구매금액1
        then 09
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 전문스포츠구매금액1
        then 10
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 패션잡화구매금액1
        then 11
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 명품구매금액1
        then 12
        when greatest(가공구매금액1, 신선구매금액1, 일상구매금액1, 의약구매금액1, 교육구매금액1, 디지털구매금액1, 가구구매금액1, 
                의류구매금액1, 전문스포츠구매금액1, 패션잡화구매금액1, 명품구매금액1, 기타구매금액1) = 기타구매금액1
        then 99
    end as 선호제품1,
    
    case 
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 가공구매금액2
        then 01 
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 신선구매금액2
        then 02 
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 일상구매금액2
        then 03
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 의약구매금액2
        then 05
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 교육구매금액2
        then 06
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 디지털구매금액2
        then 07
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 가구구매금액2
        then 08
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 의류구매금액2
        then 09
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 전문스포츠구매금액2
        then 10
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 패션잡화구매금액2
        then 11
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 명품구매금액2
        then 12
        when greatest(가공구매금액2, 신선구매금액2, 일상구매금액2, 의약구매금액2, 교육구매금액2, 디지털구매금액2, 가구구매금액2, 
                의류구매금액2, 전문스포츠구매금액2, 패션잡화구매금액2, 명품구매금액2, 기타구매금액2) = 기타구매금액2
        then 99
    end as 선호제품2,
    
    case 
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 가공구매금액3
        then 01 
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 신선구매금액3
        then 02 
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 일상구매금액3
        then 03
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 의약구매금액3
        then 05
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 교육구매금액3
        then 06
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 디지털구매금액3
        then 07
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 가구구매금액3
        then 08
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 의류구매금액3
        then 09
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 전문스포츠구매금액3
        then 10
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 패션잡화구매금액3
        then 11
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 명품구매금액3
        then 12
        when greatest(가공구매금액3, 신선구매금액3, 일상구매금액3, 의약구매금액3, 교육구매금액3, 디지털구매금액3, 가구구매금액3, 
                의류구매금액3, 전문스포츠구매금액3, 패션잡화구매금액3, 명품구매금액3, 기타구매금액3) = 기타구매금액3
        then 99
    end as 선호제품3,
    
    case 
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 가공구매금액4
        then 01 
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 신선구매금액4
        then 02 
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 일상구매금액4
        then 03
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 의약구매금액4
        then 05
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 교육구매금액4
        then 06
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 디지털구매금액4
        then 07
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 가구구매금액4
        then 08
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 의류구매금액4
        then 09
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 전문스포츠구매금액4
        then 10
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 패션잡화구매금액4
        then 11
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 명품구매금액4
        then 12
        when greatest(가공구매금액4, 신선구매금액4, 일상구매금액4, 의약구매금액4, 교육구매금액4, 디지털구매금액4, 가구구매금액4, 
                의류구매금액4, 전문스포츠구매금액4, 패션잡화구매금액4, 명품구매금액4, 기타구매금액4) = 기타구매금액4
        then 99
    end as 선호제품4,
    
    case 
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 가공구매금액5
        then 01 
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 신선구매금액5
        then 02 
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 일상구매금액5
        then 03
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 의약구매금액5
        then 05
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 교육구매금액5
        then 06
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 디지털구매금액5
        then 07
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 가구구매금액5
        then 08
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 의류구매금액5
        then 09
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 전문스포츠구매금액5
        then 10
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 패션잡화구매금액5
        then 11
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 명품구매금액5
        then 12
        when greatest(가공구매금액5, 신선구매금액5, 일상구매금액5, 의약구매금액5, 교육구매금액5, 디지털구매금액5, 가구구매금액5, 
                의류구매금액5, 전문스포츠구매금액5, 패션잡화구매금액5, 명품구매금액5, 기타구매금액5) = 기타구매금액5
        then 99
    end as 선호제품5,
    
    case 
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 가공구매금액6
        then 01 
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 신선구매금액6
        then 02 
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 일상구매금액6
        then 03
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 의약구매금액6
        then 05
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 교육구매금액6
        then 06
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 디지털구매금액6
        then 07
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 가구구매금액6
        then 08
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 의류구매금액6
        then 09
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 전문스포츠구매금액6
        then 10
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 패션잡화구매금액6
        then 11
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 명품구매금액6
        then 12
        when greatest(가공구매금액6, 신선구매금액6, 일상구매금액6, 의약구매금액6, 교육구매금액6, 디지털구매금액6, 가구구매금액6, 
                의류구매금액6, 전문스포츠구매금액6, 패션잡화구매금액6, 명품구매금액6, 기타구매금액6) = 기타구매금액6
        then 99
    end as 선호제품6,
    
    case 
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 가공구매금액7
        then 01 
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 신선구매금액7
        then 02 
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 일상구매금액7
        then 03
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 의약구매금액7
        then 05
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 교육구매금액7
        then 06
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 디지털구매금액7
        then 07
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 가구구매금액7
        then 08
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 의류구매금액7
        then 09
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 전문스포츠구매금액7
        then 10
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 패션잡화구매금액7
        then 11
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 명품구매금액7
        then 12
        when greatest(가공구매금액7, 신선구매금액7, 일상구매금액7, 의약구매금액7, 교육구매금액7, 디지털구매금액7, 가구구매금액7, 
                의류구매금액7, 전문스포츠구매금액7, 패션잡화구매금액7, 명품구매금액7, 기타구매금액7) = 기타구매금액7
        then 99
    end as 선호제품7,
    
    case 
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 가공구매금액8
        then 01 
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 신선구매금액8
        then 02 
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 일상구매금액8
        then 03
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 의약구매금액8
        then 05
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 교육구매금액8
        then 06
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 디지털구매금액8
        then 07
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 가구구매금액8
        then 08
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 의류구매금액8
        then 09
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 전문스포츠구매금액8
        then 10
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 패션잡화구매금액8
        then 11
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 명품구매금액8
        then 12
        when greatest(가공구매금액8, 신선구매금액8, 일상구매금액8, 의약구매금액8, 교육구매금액8, 디지털구매금액8, 가구구매금액8, 
                의류구매금액8, 전문스포츠구매금액8, 패션잡화구매금액8, 명품구매금액8, 기타구매금액8) = 기타구매금액8
        then 99
    end as 선호제품8
    
from prefer;

select * from prefer1;



select 고객번호, 선호제품1, 선호제품2, 선호제품3, 선호제품4, 선호제품5, 선호제품6, 선호제품7, 선호제품8,
    greatest(선호제품1, 선호제품2, 선호제품3, 선호제품4, 선호제품5, 선호제품6, 선호제품7, 선호제품8) as 최종1
from prefer1;

select * from train3;

drop table train_prot;
create table train_prot as
select t.*, greatest(선호제품1, 선호제품2, 선호제품3, 선호제품4, 선호제품5, 선호제품6) as 선호
from train3 t
join prefer1 p on t.고객번호 = p.고객번호
order by t.고객번호;

drop table test_prot;
create table test_prot as
select t.*, greatest(선호제품2, 선호제품3, 선호제품4, 선호제품5, 선호제품6, 선호제품7) as 선호
from test3 t
join prefer1 p on t.고객번호 = p.고객번호
order by t.고객번호;

drop table pred_prot;
create table pred_prot as
select t.*, greatest(선호제품3, 선호제품4, 선호제품5, 선호제품6, 선호제품7, 선호제품8) as 선호
from test3 t
join prefer1 p on t.고객번호 = p.고객번호
order by t.고객번호;

drop table mastertable0;
create table mastertable0 as
select m.고객번호, m.성별, m.연령대분류,
    m.가공1 - m.가공8 as 가공변화,
    m.신선1 - m.신선8 as 신선변화,
    m.일상1 - m.일상8 as 일상변화,
    m.의약1 - m.의약8 as 의약변화,
    m.교육1 - m.교육8 as 교육변화,
    m.디지털1 - m.디지털8 as 디지털변화,
    m.가구1 - m.가구8 as 가구변화,
    m.의류1 - m.의류8 as 의류변화,
    m.전문스포츠1 - m.전문스포츠8 as 전문스포츠변화,
    m.패션잡화1 - m.패션잡화8 as 패션잡화변화,
    m.명품1 - m.명품8 as 명품변화,
    m.기타1 - m.기타8 as 기타변화,
    
    abs(m.가공1-m.가공2)+abs(m.가공2-m.가공3)+abs(m.가공3-m.가공4)+abs(m.가공4-m.가공5)+abs(m.가공5-m.가공6)+abs(m.가공6-m.가공7)+abs(m.가공7-m.가공8) as abs가공,
    abs(m.신선1-m.신선2)+abs(m.신선2-m.신선3)+abs(m.신선3-m.신선4)+abs(m.신선4-m.신선5)+abs(m.신선5-m.신선6)+abs(m.신선6-m.신선7)+abs(m.신선7-m.신선8) as abs신선,
    abs(m.일상1-m.일상2)+abs(m.일상2-m.일상3)+abs(m.일상3-m.일상4)+abs(m.일상4-m.일상5)+abs(m.일상5-m.일상6)+abs(m.일상6-m.일상7)+abs(m.일상7-m.일상8) as abs일상,
    abs(m.의약1-m.의약2)+abs(m.의약2-m.의약3)+abs(m.의약3-m.의약4)+abs(m.의약4-m.의약5)+abs(m.의약5-m.의약6)+abs(m.의약6-m.의약7)+abs(m.의약7-m.의약8) as abs의약,
    abs(m.교육1-m.교육2)+abs(m.교육2-m.교육3)+abs(m.교육3-m.교육4)+abs(m.교육4-m.교육5)+abs(m.교육5-m.교육6)+abs(m.교육6-m.교육7)+abs(m.교육7-m.교육8) as abs교육,
    abs(m.디지털1-m.디지털2)+abs(m.디지털2-m.디지털3)+abs(m.디지털3-m.디지털4)+abs(m.디지털4-m.디지털5)+abs(m.디지털5-m.디지털6)+abs(m.디지털6-m.디지털7)+abs(m.디지털7-m.디지털8) as abs디지털,
    abs(m.가구1-m.가구2)+abs(m.가구2-m.가구3)+abs(m.가구3-m.가구4)+abs(m.가구4-m.가구5)+abs(m.가구5-m.가구6)+abs(m.가구6-m.가구7)+abs(m.가구7-m.가구8) as abs가구,
    abs(m.의류1-m.의류2)+abs(m.의류2-m.의류3)+abs(m.의류3-m.의류4)+abs(m.의류4-m.의류5)+abs(m.의류5-m.의류6)+abs(m.의류6-m.의류7)+abs(m.의류7-m.의류8) as abs의류,
    abs(m.전문스포츠1-m.전문스포츠2)+abs(m.전문스포츠2-m.전문스포츠3)+abs(m.전문스포츠3-m.전문스포츠4)+abs(m.전문스포츠4-m.전문스포츠5)+abs(m.전문스포츠5-m.전문스포츠6)+abs(m.전문스포츠6-m.전문스포츠7)+abs(m.전문스포츠7-m.전문스포츠8) as abs전문스포츠,
    abs(m.패션잡화1-m.패션잡화2)+abs(m.패션잡화2-m.패션잡화3)+abs(m.패션잡화3-m.패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6)+abs(패션잡화6-패션잡화7)+abs(패션잡화7-패션잡화8) as abs패션잡화,
    abs(m.명품1-m.명품2)+abs(m.명품2-m.명품3)+abs(m.명품3-m.명품4)+abs(m.명품4-m.명품5)+abs(m.명품5-m.명품6)+abs(m.명품6-m.명품7)+abs(m.명품7-m.명품8) as abs명품,
    abs(m.기타1-m.기타2)+abs(m.기타2-m.기타3)+abs(m.기타3-m.기타4)+abs(m.기타4-m.기타5)+abs(m.기타5-m.기타6)+abs(m.기타6-m.기타7)+abs(m.기타7-m.기타8) as abs기타,
    
--    nvl(sum(case when year_pur = 2015 and month_pur between 10 and 12 then p계절성 end), 0) -
--    nvl(sum(case when year_pur = 2014 and month_pur between 01 and 03 then 계절성 end), 0) as diff,

    (ntile(10) over (order by (nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0))desc)) -
    (ntile(10) over (order by (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0))desc)) as 총diff,
    
    ntile(10) over (order by min(case when p.구매일자 between 20140103 and 20151231 then
    to_date('2016-01-01', 'YYYY-MM-DD') - to_date(p.구매일자 , 'YYYY-MM-DD') end) desc) as r,
    ntile(10) over (order by count(p.고객번호)) as f,
    ntile(10) over (order by sum(p.계절성) desc) as m,
    
    CASE 
        WHEN 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)) > 0 
        THEN 
        round(POWER((nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)), 1/8) - 1, 2)
        
        when 
        (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)) < 0 
        THEN 
        -round(POWER(abs(nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) - 
        nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)), 1/8) -1, 2)
        
        else 0
    end as cagr,
    
    case when 
    (nvl(sum(case when p.year_pur = 2015 and p.month_pur between 10 and 12 then p.계절성 end), 0) -
    nvl(sum(case when p.year_pur = 2014 and p.month_pur between 01 and 03 then p.계절성 end), 0)) < 0
    then 1 else 0 end as label
    
from purprod0 p
join mastertable1 m on p.고객번호 = m.고객번호
group by m.고객번호, m.성별, m.연령대분류 ,
    m.가공1 - m.가공8 ,
    m.신선1 - m.신선8 ,
    m.일상1 - m.일상8 ,
    m.의약1 - m.의약8 ,
    m.교육1 - m.교육8 ,
    m.디지털1 - m.디지털8 ,
    m.가구1 - m.가구8,
    m.의류1 - m.의류8 ,
    m.전문스포츠1 - m.전문스포츠8 ,
    m.패션잡화1 - m.패션잡화8 ,
    m.명품1 - m.명품8 ,
    m.기타1 - m.기타8 ,
    
    abs(m.가공1-m.가공2)+abs(m.가공2-m.가공3)+abs(m.가공3-m.가공4)+abs(m.가공4-m.가공5)+abs(m.가공5-m.가공6)+abs(m.가공6-m.가공7)+abs(m.가공7-m.가공8) ,
    abs(m.신선1-m.신선2)+abs(m.신선2-m.신선3)+abs(m.신선3-m.신선4)+abs(m.신선4-m.신선5)+abs(m.신선5-m.신선6)+abs(m.신선6-m.신선7)+abs(m.신선7-m.신선8) ,
    abs(m.일상1-m.일상2)+abs(m.일상2-m.일상3)+abs(m.일상3-m.일상4)+abs(m.일상4-m.일상5)+abs(m.일상5-m.일상6)+abs(m.일상6-m.일상7)+abs(m.일상7-m.일상8) ,
    abs(m.의약1-m.의약2)+abs(m.의약2-m.의약3)+abs(m.의약3-m.의약4)+abs(m.의약4-m.의약5)+abs(m.의약5-m.의약6)+abs(m.의약6-m.의약7)+abs(m.의약7-m.의약8) ,
    abs(m.교육1-m.교육2)+abs(m.교육2-m.교육3)+abs(m.교육3-m.교육4)+abs(m.교육4-m.교육5)+abs(m.교육5-m.교육6)+abs(m.교육6-m.교육7)+abs(m.교육7-m.교육8) ,
    abs(m.디지털1-m.디지털2)+abs(m.디지털2-m.디지털3)+abs(m.디지털3-m.디지털4)+abs(m.디지털4-m.디지털5)+abs(m.디지털5-m.디지털6)+abs(m.디지털6-m.디지털7)+abs(m.디지털7-m.디지털8) ,
    abs(m.가구1-m.가구2)+abs(m.가구2-m.가구3)+abs(m.가구3-m.가구4)+abs(m.가구4-m.가구5)+abs(m.가구5-m.가구6)+abs(m.가구6-m.가구7)+abs(m.가구7-m.가구8) ,
    abs(m.의류1-m.의류2)+abs(m.의류2-m.의류3)+abs(m.의류3-m.의류4)+abs(m.의류4-m.의류5)+abs(m.의류5-m.의류6)+abs(m.의류6-m.의류7)+abs(m.의류7-m.의류8) ,
    abs(m.전문스포츠1-m.전문스포츠2)+abs(m.전문스포츠2-m.전문스포츠3)+abs(m.전문스포츠3-m.전문스포츠4)+abs(m.전문스포츠4-m.전문스포츠5)+abs(m.전문스포츠5-m.전문스포츠6)+abs(m.전문스포츠6-m.전문스포츠7)+abs(m.전문스포츠7-m.전문스포츠8),
    abs(m.패션잡화1-m.패션잡화2)+abs(m.패션잡화2-m.패션잡화3)+abs(m.패션잡화3-m.패션잡화4)+abs(패션잡화4-패션잡화5)+abs(패션잡화5-패션잡화6)+abs(패션잡화6-패션잡화7)+abs(패션잡화7-패션잡화8) ,
    abs(m.명품1-m.명품2)+abs(m.명품2-m.명품3)+abs(m.명품3-m.명품4)+abs(m.명품4-m.명품5)+abs(m.명품5-m.명품6)+abs(m.명품6-m.명품7)+abs(m.명품7-m.명품8) ,
    abs(m.기타1-m.기타2)+abs(m.기타2-m.기타3)+abs(m.기타3-m.기타4)+abs(m.기타4-m.기타5)+abs(m.기타5-m.기타6)+abs(m.기타6-m.기타7)+abs(m.기타7-m.기타8) 
    
order by m.고객번호;

select * from mastertable0;

--추천

drop table choice;
create table choice as
select  p.제휴사, t.통합코드,
    count(t.통합코드) as 구매제품수,
    ROW_NUMBER() OVER (PARTITION BY p.제휴사 ORDER BY count(t.통합코드) DESC) AS rn

from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.제휴사, t.통합코드
order by p.제휴사;

select *
from choice;


drop table purprod1;
create table purprod1 as
select p.고객번호, p.제휴사, t.임의코드, t.통합코드,
    count(t.임의코드) as 구매빈도,
    row_number() over (partition by p.고객번호, p.제휴사 order by count(t.임의코드) desc) as rank0,
    ntile(5) over (partition by p.고객번호, p.제휴사 order by count(t.임의코드)) as rank1
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호, p.제휴사, t.임의코드, t.통합코드
order by p.고객번호, p.제휴사, rank0;

select * from purprod1;

drop table purprod2;
create table purprod2 as
select p.소분류코드, t.임의코드, t.소분류명, t.임의분류명, count(t.임의코드) as 구매빈도
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호, p.제휴사, t.임의코드, t.임의분류명, t.통합코드, p.소분류코드, t.소분류명
order by p.고객번호, p.제휴사;

select * from purprod2;

select * from total_code0;

select * 
from purprod0;

drop table purprod3;
create table purprod3 as
select p.고객번호, p.제휴사, p.소분류코드, t.임의코드, t.통합코드,
    count(p.소분류코드) as 구매빈도,
    row_number() over (partition by p.고객번호, p.제휴사 order by count(p.소분류코드) desc) as rank0,
    case when count(p.소분류코드) <> 1 
    then ntile(5) over (partition by p.고객번호, p.제휴사 order by count(p.소분류코드)) else 1 end as rank1
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호, p.제휴사, t.임의코드, t.통합코드, p.소분류코드
order by p.고객번호, p.제휴사, rank0;

select * from purprod3;

drop table purprod4;
create table purprod4 as
select p.고객번호, p.소분류코드, t.임의코드, t.통합코드,
    count(p.소분류코드) as 구매빈도,
    nvl(sum(p.계절성), 0) as 구매금액,
    row_number() over (partition by p.고객번호 order by count(p.소분류코드) desc) as rank0,
    case when count(p.소분류코드) <> 1 
    then ntile(5) over (partition by p.고객번호 order by count(p.소분류코드)) else 1 end as rank1,
    ntile(5) over (partition by p. 고객번호 order by nvl(sum(p.계절성), 0)) as rank2,
    (case when count(p.소분류코드) <> 1 
    then ntile(5) over (partition by p.고객번호 order by count(p.소분류코드)) else 1 end +
    ntile(5) over (partition by p. 고객번호 order by nvl(sum(p.계절성), 0))) / 2 as rank3
    
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호, t.임의코드, t.통합코드, p.소분류코드
order by p.고객번호, rank0;

select * from purprod4 where rank3 = 1.5;

select count(p.계절성), sum(p.계절성), t.소분류명 
from purprod0 p
join total_code0 t on p.소분류코드 = t.소분류코드
group by p.고객번호, p.소분류코드, t.소분류명
having p.고객번호 = '11763'
order by sum(p.계절성) desc;
