/*
Answer: What are the most optimal skills to learn (jobs high in-demand and high-paying)?
- Identify skills in high-demand and associated with high average salary for data analyst roles.
- concentrate on remote positions with specified salaries.
- Why? Target skills that offer job security and financial benefits (high demand + high pay),
     offering a strategic advantage in career planning.
*/

WITH skill_demand AS (
  SELECT
    skills,
    skill_id,
    COUNT(skills_job_dim.skill_id) AS demand_count
  FROM job_postings_fact
  INNER JOIN skills_job_dim USING (job_id)
  INNER JOIN skills_dim USING (skill_id)
  WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
  GROUP BY skill_id, skills
), avg_salary AS (
  SELECT
    skills,
    skill_id,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
  FROM job_postings_fact
  INNER JOIN skills_job_dim USING (job_id)
  INNER JOIN skills_dim USING (skill_id)
  WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
    AND salary_year_avg IS NOT NULL
  GROUP BY skill_id, skills
)

SELECT
  skill_demand.skill_id,
  skill_demand.skills AS skill,
  skill_demand.demand_count,
  avg_salary.average_salary
FROM skill_demand
INNER JOIN avg_salary USING (skill_id)
WHERE skill_demand.demand_count > 10
ORDER BY average_salary DESC, demand_count DESC
LIMIT 25;

-- re-writing same query more concisely

SELECT
skills_dim.skill_id,
skills_dim.skills,
COUNT(skills_job_dim.skill_id) AS demand_count,
ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim USING (job_id)
INNER JOIN skills_dim USING (skill_id)
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
  AND job_postings_fact.job_work_from_home = True
  AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.skill_id) > 10
ORDER BY average_salary DESC, demand_count DESC
LIMIT 25;