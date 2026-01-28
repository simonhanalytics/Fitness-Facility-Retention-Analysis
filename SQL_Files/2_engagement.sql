-- General reasons members want to get involved in their fitness studio
SELECT
    stay_reason,
    COUNT(*)
FROM engagement
GROUP BY 1
ORDER BY 2 DESC

-- Fitness goals count
SELECT
    fitness_goal,
    COUNT(*)
FROM
    members
GROUP BY 1
ORDER BY 2 DESC

-- Reasons for engagement based on fitness goals
SELECT
    fitness_goal,
    stay_reason,
    COUNT(*) AS reasons_count
FROM members
JOIN engagement USING (member_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Reasons for engagement based on the activity
SELECT
    fitness_activity,
    stay_reason,
    COUNT(*) AS reasons_count
FROM members
JOIN engagement USING (member_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Retention based on the sign-up method
SELECT
    sign_up_method,
    COUNT(*) AS sign_up_count
FROM members
JOIN engagement USING (member_id)
GROUP BY 1
ORDER BY 2 DESC

-- Reasons for engagement based on the member's fitness level
SELECT
    fitness_level,
    stay_reason,
    COUNT(*) AS reasons_count
FROM members
JOIN engagement USING (member_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Members sign-up method based on fitness level
SELECT
    fitness_level,
    sign_up_method,
    COUNT(*)
FROM members
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Minimum age of 18, and maximum age of 65 in the dataset
SELECT
    MIN(age),
    MAX(age)
FROM members

-- Age ranges VIEW
CREATE VIEW members_with_age_range AS
SELECT
    *,
    CASE
        WHEN age BETWEEN 13 AND 19 THEN 'Teen'
        WHEN age BETWEEN 20 AND 29 THEN '20s'
        WHEN age BETWEEN 30 AND 39 THEN '30s'
        WHEN age BETWEEN 40 AND 49 THEN '40s'
        WHEN age BETWEEN 50 AND 59 THEN '50s'
        WHEN age >= 60 THEN '60+'
        ELSE 'Unknown'
    END AS age_range
FROM
    members

-- Top 3 reasons members want to stay for each age group
WITH stay_reason_age AS (
    SELECT
        age_range,
        stay_reason,
        COUNT(*) AS num_of_reasons,
        RANK() OVER (PARTITION BY age_range ORDER BY COUNT(*) DESC) AS age_reasons_rank
    FROM
        members_with_age_range m
    JOIN engagement e ON
        m.member_id = e.member_id
    GROUP BY 1, 2
)
SELECT
    stay_reason,
    COUNT(*) AS stay_reason_age_count
FROM
    stay_reason_age
WHERE age_reasons_rank <= 3 AND age_range != 'Unknown'
GROUP BY 1
ORDER BY 2 DESC

-- Top 3 fitness goals for each age group
WITH fitness_goal_age AS (
    SELECT
        age_range,
        fitness_goal,
        COUNT(*) AS member_fitness_goal_count,
        RANK() OVER (PARTITION BY age_range ORDER BY COUNT(*) DESC) AS fitness_goal_rank
    FROM
        members_with_age_range
    GROUP BY 1, 2
)
SELECT
    fitness_goal,
    COUNT(*) AS fitness_goal_count
FROM
    fitness_goal_age
WHERE fitness_goal_rank <= 3 AND age_range != 'Unknown'
GROUP BY 1
ORDER BY 2 DESC

-- Engagement reasons based on the top 10 members with the most number of sessions per month
WITH top10_highest_attendance AS (
    SELECT
        a.member_id,
        COUNT(*) AS num_of_sessions,
        e.length_of_membership,
        ROUND(COUNT(*)*1.0/NULLIF(e.length_of_membership, 0), 2) AS avg_sessions_per_month_eng,
        e.stay_reason AS stay_reason_top10
    FROM attendance a
    JOIN engagement e ON
        a.member_id = e.member_id
    GROUP BY
        1, 3, 5
    ORDER BY 4 DESC
    LIMIT 21
)
SELECT
    stay_reason_top10,
    COUNT(*)
FROM
    top10_highest_attendance
GROUP BY 1
ORDER BY 2 DESC

-- Number of stay reasons in the top 3 segmented by fitness goal (Windows function)
WITH fitness_goal_rank AS (
    SELECT
        fitness_goal,
        stay_reason,
        COUNT(*) AS reasons_count,
        RANK() OVER (PARTITION BY fitness_goal ORDER BY COUNT(*) DESC) AS goal_rank
    FROM members
    JOIN engagement USING (member_id)
    GROUP BY 1, 2
)
SELECT
    stay_reason,
    COUNT(*)
FROM fitness_goal_rank
WHERE goal_rank <= 3
GROUP BY 1
ORDER BY 2 DESC