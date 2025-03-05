SELECT * FROM health_analysis.ocd_patient_dataset;
-- 1. Count of F vs M that have OCD & Average Obsession Score by Gender
with data as(
SELECT 
	Gender, 
    count(`Patient ID`) as patient_count,
    round(avg(`Y-BOCS Score (Obsessions)`),2) as avg_obs_score
From health_analysis.ocd_patient_dataset
Group by 1
Order by 2
)

select 

 sum(case when Gender = 'Female' then patient_count else 0 end) as count_female,
 sum(case when Gender = 'Male' then patient_count else 0 end) as count_male,

 round(sum(case when Gender = 'Female' then patient_count else 0 end)/
 (sum(case when Gender = 'Female' then patient_count else 0 end)+sum(case when Gender = 'Male' then patient_count else 0 end))*100,2)
 as pct_female,

 round(sum(case when Gender = 'Male' then patient_count else 0 end)/
 (sum(case when Gender = 'Male' then patient_count else 0 end)+sum(case when Gender = 'Female' then patient_count else 0 end))*100,2)
 as pct_male

from data;


-- 2. Count & Avg obsession score by ethnicity

SELECT * FROM health_analysis.ocd_patient_dataset;

select 
	Ethnicity,
    count(`Patient ID`) as patient_count,
    avg(`Y-BOCS Score (Obsessions)`) as ovs_score
from health_analysis.ocd_patient_dataset
Group by 1
Order by 2;

-- 3. no. of peole diagonsed with ocd MoM
-- alter table health_analysis.ocd_patient_dataset
-- modify `OCD Diagnosis Date` date;
select 
date_format(`OCD Diagnosis Date`, '%Y-%m-01') as month,
count(`Patient ID`) as patiet_count
from health_analysis.ocd_patient_dataset
group by 1
Order by 1;

-- 4. What is most common Obsession Type (Count) & its respective obsession score

Select
`Obsession Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from health_analysis.ocd_patient_dataset
group by 1
Order by 2;


-- 5. What is most common Complusion Type and its average obs_sore
Select
`Compulsion Type`,
count(`Patient ID`) as patient_count,
round(avg(`Y-BOCS Score (Obsessions)`),2) as obs_score
from health_analysis.ocd_patient_dataset
group by 1
Order by 2;




    

