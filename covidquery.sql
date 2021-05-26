SELECT * FROM covid.cases;

describe cases;
describe vaccinations;


/*Viewing number of Countries available in the dataset*/
select
count(distinct location) 
from covid.cases
where continent is not null;


/*Viewing all the Countries available in the dataset*/
select
distinct location
from covid.cases
where continent is not null;


/* Death Percentage Country-wise (as of 11/05/2021) */
select
location,
(sum(total_deaths)/sum(total_cases))*100 as death_percentage
from cases
where continent is not null
group by 1
order by 2 desc;


-- Total cases in India
select
max(total_cases)
from cases
where location = 'India';


/* Death percentage in India from 30/01/2020 to 11/05/2021 */
select
location,
total_cases,
total_deaths,
date,
(total_deaths/total_cases)*100 as death_percentage
from cases
where continent is not null
and location = 'India';


/* Countries with most percentage of population effected */
select
location,
population,
max(total_cases) as highest_cases,
(max(total_cases)/population)*100 as percent_population_effected
from cases
where continent is not null 
group by 1
order by 4 desc;



/* Countries with most numbers of deaths */
select
location,
population,
max(total_cases) as highest_cases,
(max(total_cases)/population)*100 as percent_population_effected
from cases
where continent is null 
group by 1;


-- Grouping with case function by nnumber of deaths
select
location,
max(total_deaths),
case when max(total_deaths) > 10000 then 'High' else 'Low' end as highlow
from cases
group by 1;


-- Vaccinations
select
cases.location,
cases.population,
cases.date,
vaccinations.total_tests
from cases
right join vaccinations
on cases.location = vaccinations.location
where cases.continent is not null;