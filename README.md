# Fitness Facility Retention Analysis

## Executive Summary
This project uncovers what drives fitness facility members to engage with or cancel their membership. It analyzes 500 members from various fitness facilties, with 175 of the members cancelling their membership. Four datasets were created using ChatGPT: members, attendance, engagement, and cancellations. Using Excel for data wranging, SQL for data analysis, and Power BI for data visualization, I discovered the top 5 reasons for fitness facility engagement and cancellations (from highest to lowest):
- Engagement reasons: Cleanliness and equipment, facility atmosphere, accountability, class variety, and community and friends.
- Cancellation reasons: Poor cleanliness, too hard/intimidating, disliked instructors, travel/commute time, and facility too crowded.

## Business Problem
There have been fitness members that have stayed in their fitness studio long term, but also fitness members who have cancelled their membership, including a few members cancelling only within 1 month of joining. This raises questions about what factors keep members engaged, and what factors causes members to cancel. This project explores the reasons people engage and cancel, and breaks the reasons down in terms of different factors such fitness level, age group, fitness goal, attendance, and length of membership.

## Methodology
1. Data creation using ChatGPT:
- Created 4 CSV datasets (members, attendance, engagement, and cancellations) through a detailed prompt on what the columns are, the primary/foreign key references, having it be as realistic as possible, and to include errors and null values on purpose to provide me the opportunity to clean the data.

2. Data wrangling using Excel Power Query:
- [CSV Datasets Link](https://github.com/simonhanalytics/Fitness-Facility-Retention-Analysis/tree/main/Cleaned_datasets)
- Uploaded the 4 CSV datasets onto Excel
- Cleaned and transformed the data on Power Query by fixing any misspelling, examining and replacing null values, fixing the data types, checking for strange values, and checking for any start dates after the end dates.
<img width="600" height="400" alt="Excel_PowerQuery_image" src="https://github.com/user-attachments/assets/66f31381-5887-41a1-81da-d6f538c8d951" />

3. Data analysis using SQL:
- [SQL Files Link](https://github.com/simonhanalytics/Fitness-Facility-Retention-Analysis/tree/main/SQL_Files)
- Imported the 4 cleaned datasets onto SQL
- Analyzed both the engagement and cancellation reasons in terms of age group, fitness level, fitness reason, sign-up method, and fitness level.
<img width="400" height="500" alt="SQL_image" src="https://github.com/user-attachments/assets/fe141cba-55a3-46cb-b904-8da122863d90" />

4. Dashboard creation using Power BI:
- [Power BI File Link](https://github.com/simonhanalytics/Fitness-Facility-Retention-Analysis/blob/main/Fitness%20Facilities%20Retention%20Dashboard.pbix)
- Built a 3 page interactive dashboard illustrating the overview, engagement, and cancellation reasons.
<img width="600" height="350" alt="PowerBI_image" src="https://github.com/user-attachments/assets/7d52a5f7-0958-4207-af8a-124245d5d76d" />


## Skills
- Excel Power Query for data wrangling
- SQL for data analysis using the following functions: Aggregate functions, CTEs, joins, case statements, date functions, and windows functions
- Power BI for data visualization using the following features: Multi-page dashboards, slicers, navigation buttons, charts (bar, line, and pie), and DAX measures

## Results
- The top 5 reasons for fitness facility member engagement (from highest to lowest) are: Cleanliness and equipment, facility atmosphere, accountability, class variety, and community and friends.
- The top 5 reasons for member cancellations are: Poor cleanliness, too hard/intimidating, disliked instructors, travel/commute time, and facility being too crowded.
- Top 3 reasons for member cancellations for those who have cancelled within 1 month of joining: Lost interest, poor cleanliness/equipment, and work/school change.
- The top sign-up method is online, followed by referral and in-person.

## Recommendations

Based on the results, fitness facilities should consider doing the following to improve member retention:
- Prioritize cleanliness and equipment quality (top reason members stay and leave):
    - Increase daily cleaning protocols
    - Have members practice fitness etiquette by cleaning after themselves after a workout
    - Do equipment inspections regularly to identify any issues, and invest in necessary equipment fixtures and upgrades
- Build a supportive, inclusive, and friendly atmosphere that supports all fitness levels:
    - Train staff to engage with and support all members
    - Encourage interaction between members during a fitness session (fist bumps, high fives, partner drills, etc)
    - Having friendly challenges that keeps members engaged and for them to meet fellow members
    - Having social gathering from time to time
- Having customizable programs:
    - Based on people's fitness level and goal
    - For beginner members, instructors should work on easing them into the activity, and supporting them along the way
    - For advanced members, they could be given the option for the instructors to hold them accountable to their goals
- Reduce overcrowding:
    - Having a reservation system
    - Identifying popular times, and add extra classes around those times
    - Have member take an attendance survey to figure out the most ideal times
- Better onboarding:
    - Effective communication when signing up new members discussing what to expect in the first classes, offering support along the way, and discussing if travel/commute time and life events would interfere with their attendance
    - Having a 1 week and 1 month check-in with the new member to review their experience
- Improved online presence:
    - Majority of the members sign-up online, which means that it is important to have a powerful online presence:
    - Have a well designed website and social media pages with all the information about the fitness facility such as the activities involved, what to expect from your first class, videos of how a typical class is, and member tesimonials

## Next Steps
To expand and deepen this analysis, we could:
- Improve the sample size to 1,000
- Identify the most popular fitness activities that keeps people engaged
- Figure out the percentage of the cancellation reasons to be factors out of the fitness facility's control
