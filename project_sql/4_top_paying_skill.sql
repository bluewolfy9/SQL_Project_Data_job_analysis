/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst roles.
- Focus on roles with specified salaries to ensure accuracy.
- Why? it reveals how different skills impact salary levels for data analysts and 
       helps identify the most financially rewarding skills to acquire or improve.
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS average_salary
FROM job_postings_fact
INNER JOIN skills_job_dim USING (job_id)
INNER JOIN skills_dim USING (skill_id)
WHERE
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL -- Consider only jobs with specified salaries
    AND job_work_from_home = True
GROUP BY skills
ORDER BY average_salary DESC
LIMIT 25;

/* 
Big Data & Engineering Lead: PySpark ($208k) rounds out the top, signaling that analysts who can handle massive, distributed datasets command a significant premium over traditional analysts.

The "DevOps" Shift: The high compensations for tools like Bitbucket, GitLab, and Kubernetes indicate that there is a strong market premium on analysts who could manage their own code versions, automation pipelines, and cloud environments.

Specialized AI and data science tools—such as Watson, DataRobot, and core Python stack-Pandas/NumPy-continue to help bridge the gap between analysis and predictive modeling and drive pay higher above the mark of $150,000.
*/
