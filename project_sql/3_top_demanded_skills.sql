/*
Question: What are the most in-demand skills for data analyst?
- join job postings to inner join table as in query 2
- identify the top 5 in-demand skills for data analyst roles.
- Why? retrieve the top 5 skills with the heighest demand in job market, produce insights for job seekers.
*/

SELECT
  skills,
  COUNT(skills_job_dim.skill_id) AS demand_count
FROM
    job_postings_fact
INNER JOIN skills_job_dim USING (job_id) -- Join to get skills for the top-paying jobs
INNER JOIN skills_dim USING (skill_id) -- Join to get skill names
WHERE
  job_title_short = 'Data Analyst' AND-- Focus on data analyst roles
  job_work_from_home = True -- Consider only remote jobs
GROUP BY
  skills
ORDER BY
  demand_count DESC
LIMIT 5; -- Limit to top 5 results