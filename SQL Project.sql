#----------------------------------------Bank Analytics Project-------------------------------#

select * from finance_1;
select * from finance_2;

#-------------KPI-1--------------#
#---Year wise loan amount stats--#

select
year(issue_d) as Year,
concat(round(sum(loan_amnt)/1000000,2),"M") as Total_loan_amnt
from finance_1
group by Year
order by year;

#------------------KPI-2--------------------#
#--Grade and sub-grade wise revol_balance---#

select
f1.grade,f1.sub_grade,
concat(round(sum(revol_bal)/1000000,2),'M')as revol_bal
from finance_1 as f1
join finance_2 as f2 
using(id)
group by f1.grade,f1.sub_grade
order by f1.grade,f1.sub_grade;




#--------------------------KPI-3-----------------------------#
#--Total Payment for verified status Vs Non verified status--#

select
f1.verification_status,
concat(round(sum(total_pymnt)/1000000),"M") as "Total Payment"
from finance_1 as f1
join finance_2 as f2 
using (id)
group by verification_status
order by verification_status desc;


#-------------------------KPI-4------------------------#
#--State wise and last_credit_pull_d wise loan status--#

select
f1.addr_state as State,
max(f2.last_credit_pull_d) as Date,
f1.loan_status as "Loan Status"
from finance_1 as f1
join finance_2 as f2 
using(id)
group by addr_state,loan_status
order by state;


#---------------------KPI 5-----------------------#
#----Home ownership Vs last payment date stats----#

select
f1.home_ownership,
max(last_pymnt_d) as last_payment,
count(home_ownership) as no_of_home_ownership
from finance_1 as f1
join finance_2 using(id)
group by home_ownership;

#------------KPI 5------------#

select 
year(f2.last_pymnt_d) as payment_year,
monthname(f2.last_pymnt_d) as payment_month,
f1.home_ownership,
count(f1.home_ownership) as home_ownership
from finance_1 as f1 
inner join finance_2 as f2
using(id)
group by payment_year, payment_month, f1.home_ownership
order by payment_year desc;