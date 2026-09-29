/* 
What are the most in-demand skills in the job market? 
- Identify the top 10 most demanded skills for data engineers.
- Focus on remote job postings
- Why? Retrieve the top 10 skills with the highest
*/

SELECT
sd.skills,
COUNT(jpf.*) AS demand_count
FROM job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE job_title_short LIKE '%Data%Engineer%'
AND jpf.job_work_from_home = TRUE
GROUP BY 
sd.skills
ORDER BY demand_count DESC
LIMIT 10;
