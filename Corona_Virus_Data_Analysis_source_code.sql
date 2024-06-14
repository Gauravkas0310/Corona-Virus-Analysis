create database covid_analysis;
use covid_analysis;
/*Load data 'Corona virus Dataset'*/
select * from corona_virus_dataset;

/*Modifying the date data type*/
ALTER TABLE corona_virus_dataset ADD temp_date DATE;
UPDATE corona_virus_dataset
SET temp_date = STR_TO_DATE(`Date`, '%d-%m-%Y');
ALTER TABLE corona_virus_dataset DROP COLUMN `Date`;
ALTER TABLE corona_virus_dataset CHANGE temp_date `Date` DATE;




/*Ques1. Check Null Values*/
select 
sum(case when province is NULL then 1 else 0 End) as province_null_count,
sum(case when country is NULL then 1 else 0 End) as country_null_count,
sum(case when latitude is NULL then 1 else 0 End) as latitude_null_count,
sum(case when longitude is NULL then 1 else 0 End) as longitude_null_count,
sum(case when Date is NULL then 1 else 0 End) as date_null_count,
sum(case when confirmed is NULL then 1 else 0 End) as confirmed_null_count,
sum(case when deaths is NULL then 1 else 0 End) as deaths_null_count,
sum(case when recovered is NULL then 1 else 0 End) as recovered_null_count
from corona_virus_dataset;

/*Ques2. Update Null Values with Zero*/
UPDATE corona_virus_dataset
SET
    confirmed = IFNULL(confirmed, 0),
    deaths = IFNULL(deaths, 0),
    recovered = IFNULL(recovered, 0);


SET SQL_SAFE_UPDATES = 0;

/*Ques3. total number of rows*/
select count(*) as total_rows from corona_virus_dataset;

/*Ques4.check what is start_date and end_date*/
select
	min(Date) as start_date,
    max(Date) as end_date
    from corona_virus_dataset;
/*Ques5. number of months present in the dataset*/
select 
count(distinct date_format(date,'%Y-%m')) as number_of_months
from corona_virus_dataset;

/*Ques6. find monthly average for confirmed ,deaths, recovered*/
select 
	date_format(date,'%Y-%m') as month,
    avg(confirmed) as avg_confirmed,
    avg(deaths) as avg_deaths,
    avg(recovered) as avg_recovered
from corona_virus_dataset
group by month;
/*Ques7. Find most frequent value for confirmed, deaths, recovered each month*/
select 
	date_format(date,'%Y-%m') as month,
    confirmed, deaths, recovered,
    count(*) as frequency
    from corona_virus_dataset
    group by month,confirmed, deaths, recovered
    order by month, frequency DESC;
/*Ques8. minimum value for confirmed, deaths, recovered per year*/
select
	year(date) as Year,
    min(confirmed) as min_confirmed,
    min(deaths) as min_deaths,
    min(recovered) as min_recovered
    from corona_virus_dataset
    group by year;
    /*Ques9.Find maximum values of confirmed,deaths, recovered per year*/
    select
		year(date) as Year,
        max(confirmed) as max_confirmed,
        max(deaths) as max_deaths,
        max(recovered) as max_recovered
	from corona_virus_dataset
    group by year;
/*Ques10. the total number of confirmed, deaths, recovered each month*/
select
	date_format(date,'%Y-%m') as month,
    sum(confirmed) as total_confirmed,
    sum(deaths) as total_deaths,
    sum(recovered) as total_recovered
    from corona_virus_dataset
    group by month;
/*Ques11. corona virus spread out with respect to confirmed case*/
select
	sum(confirmed) as total_confirmed,
    avg(confirmed) as avg_confirmed,
    variance(confirmed) as var_confirmed,
    stddev(confirmed) as stddev_confirmed
from corona_virus_dataset;
/*Ques12. how corona virus spread out with respected to death case per month*/
select
	date_format(date,'%Y-%m') as month,
	sum(deaths) as total_deaths,
    avg(deaths) as avg_deaths,
    variance(deaths) as var_deaths,
    stddev(deaths) as stddev_deaths
from corona_virus_dataset
group by month;
/*Ques13. how corona virus spread out with respected to recovered cases per month*/
select
	date_format(date,'%Y-%m') as month,
	sum(recovered) as total_recovered,
    avg(recovered) as avg_recovered,
    variance(recovered) as var_recovered,
    stddev(recovered) as stddev_recovered
from corona_virus_dataset
group by month;
/*Ques14. country having highest number of the confirmed case*/
select
	country,
    sum(confirmed) as total_confirmed
from corona_virus_dataset
group by country
order by total_confirmed DESC
limit 1;
/*Ques15. country having lowest number of the death case*/
select 
	country,
    sum(deaths) as total_deaths
from corona_virus_dataset
group by country
order by country ASC
Limit 1;
/*Ques16. Top 5 countries having highest recovered cases*/
select
	country,
    sum(recovered) as total_recovered
from corona_virus_dataset
group by country
order by total_recovered desc
limit 5;