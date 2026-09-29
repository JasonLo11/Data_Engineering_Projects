/* 
What are the highest paying skills for data engineers?
- Calculate the median salary for each skill.
- Focus on remote job postings with specified salaries
- Include skill frequency to identify both salary and demand
Why? 
- Helps identify which skills command the highest compensation while also showing how common those skills are, providing a more complete picture for the skill developmement priorities.
- The median is used instead of the average to reduce the impact of outliers salaries.
*/

SELECT DISTINCT
jpf.job_title_short,
sd.skills,
COUNT(jpf.*) AS demand_count,
ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary
FROM
job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE job_title_short = 'Data Engineer'
AND jpf.job_work_from_home = TRUE
AND jpf.salary_year_avg IS NOT NULL
GROUP BY
jpf.job_title_short,
sd.skills
ORDER BY median_salary DESC
LIMIT 10;