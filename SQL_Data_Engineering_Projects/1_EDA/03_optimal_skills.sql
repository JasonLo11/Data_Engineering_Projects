/* 
What are the most optimal skills for data engineers balancing both demand and salary?
 - Create a ranking that combines demand count and median salary to identify the most valuable skills for data engineers.
- Focus on remote job postings with specified annual salaries.
*/

SELECT DISTINCT
jpf.job_title_short,
sd.skills,
ROUND(LN(COUNT(jpf.*)), 1) AS demand_count,
ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary,
ROUND(MEDIAN(jpf.salary_year_avg) * LN(COUNT(jpf.*))/1000000, 2) AS optimal_score
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
ORDER BY optimal_score DESC
LIMIT 10;