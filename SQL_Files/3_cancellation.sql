-- General reasons members decide to cancel
SELECT
    cancel_reason,
    COUNT(*) AS cancel_reason_count
FROM
    cancellations
GROUP BY
    1
ORDER BY
    2 DESC

-- Reasons for cancelling by fitness goal
SELECT
    fitness_goal,
    cancel_reason,
    COUNT(*) AS reasons_count
FROM
    members
JOIN cancellations USING (member_id)
GROUP BY
    1, 2
ORDER BY
    1, 3 DESC

-- Number of top 3 reasons for cancellations segmented by fitness goal
WITH fitness_goal_cancel_rank AS (
    SELECT
        fitness_goal,
        cancel_reason,
        COUNT(*) AS reasons_count,
        RANK() OVER (PARTITION BY fitness_goal ORDER BY COUNT(*) DESC) AS cancel_reason_rank
    FROM
        members
    JOIN cancellations USING (member_id)
    GROUP BY
        1, 2
)
SELECT
    cancel_reason,
    COUNT(*) AS cancel_reason_count
FROM
    fitness_goal_cancel_rank
WHERE cancel_reason_rank <= 3
GROUP BY 1
ORDER BY 2 DESC

-- Reasons for cancelling by fitness activity
SELECT
    fitness_activity,
    cancel_reason,
    COUNT(*) AS reasons_count
FROM
    members
JOIN cancellations USING (member_id)
GROUP BY 
    1, 2
ORDER BY
    1, 3 DESC

-- Reasons for cancelling by sign-up method
SELECT
    sign_up_method,
    COUNT(*) AS reasons_count
FROM
    members
JOIN cancellations USING (member_id)
GROUP BY
    1
ORDER BY
    2 DESC

-- Reasons for cancelling by fitness level
SELECT
    fitness_level,
    cancel_reason,
    COUNT(*) AS reasons_count
FROM
    members
JOIN cancellations USING (member_id)
GROUP BY
    1, 2
ORDER BY
    1, 3 DESC

-- Reasons members want to cancel for each age group 
SELECT
    age_range,
    cancel_reason,
    COUNT(*) AS age_cancellations
FROM
    members_with_age_range
JOIN cancellations c USING (member_id)
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Number of top 3 cancellation reasons segmented by age group
WITH top3_age_cancellations AS (
    SELECT
        age_range,
        cancel_reason,
        COUNT(*) AS age_cancellations,
        RANK() OVER (PARTITION BY age_range ORDER BY COUNT(*) DESC) AS age_cancel_rank
    FROM
        members_with_age_range
    JOIN cancellations USING (member_id)
    GROUP BY 1, 2
)
SELECT
    cancel_reason,
    COUNT(*) AS cancel_reason_count
FROM
    top3_age_cancellations
WHERE
    age_cancel_rank <= 3
GROUP BY 1
ORDER BY 2 DESC


-- People who have joined but then left within 1 month
SELECT
    cancel_reason,
    COUNT(*) AS cancel_reason_count
FROM
    cancellations
WHERE
    length_of_membership <= 1
GROUP BY 1
ORDER BY 2 DESC

-- Count of each fitness levels who left within 1 month
SELECT
    fitness_level,
    COUNT(DISTINCT c.member_id) AS cancel_reason_count
FROM
    members m
JOIN cancellations c USING (member_id)
WHERE
    length_of_membership <= 1
GROUP BY 1
ORDER BY 2 DESC

-- Reasons for cancellations of different fitness levels who left within 1 month
SELECT
    fitness_level,
    cancel_reason,
    COUNT(*) AS cancel_reason_count
FROM
    members
JOIN cancellations USING (member_id)
WHERE
    length_of_membership <= 1
GROUP BY 1, 2
ORDER BY 1, 3 DESC

-- Cancel reasons for low commitment members
SELECT
    a.member_id,
    COUNT(*) AS num_of_sessions,
    c.length_of_membership,
    ROUND(COUNT(*)*1.0/NULLIF(c.length_of_membership, 0), 2) AS avg_sessions_per_month_canc,
    c.cancel_reason
FROM attendance a
JOIN cancellations c ON
    a.member_id = c.member_id
GROUP BY
    1, 3, 5
ORDER BY
    4

-- Attendance by month
SELECT
    EXTRACT (MONTH FROM attendance_start_time),
    COUNT(*)
FROM attendance
GROUP BY 1
ORDER BY 2 DESC

-- Cancellations by month
WITH cancel_month_conv AS(
    SELECT
        member_id,
        EXTRACT (MONTH FROM cancel_date) AS cancel_month,
        CASE EXTRACT (MONTH FROM cancel_date)
            WHEN 1 THEN 'January'
            WHEN 2 THEN 'February'
            WHEN 3 THEN 'March'
            WHEN 4 THEN 'April'
            WHEN 5 THEN 'May'
            WHEN 6 THEN 'June'
            WHEN 7 THEN 'July'
            WHEN 8 THEN 'August'
            WHEN 9 THEN 'September'
            WHEN 10 THEN 'October'
            WHEN 11 THEN 'November'
            WHEN 12 THEN 'December'
        ELSE 'Unknown'
        END AS cancel_month_conv
    FROM
        cancellations
)
SELECT
    cancel_month_conv,
    COUNT(DISTINCT(cancel_reason_id))
FROM cancellations c
LEFT JOIN cancel_month_conv cm ON
    c.member_id = cm.member_id
GROUP BY 1
ORDER BY 2 DESC
