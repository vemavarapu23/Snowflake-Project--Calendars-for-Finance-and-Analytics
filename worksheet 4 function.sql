-- ===========================================================
-- Project: Calendars for Finance and Analytics
-- Worksheet 4: Function Layer
-- Purpose: Create a table function that returns aggregated data
-- Database: FOX_DB
-- Schema: AGG_LAYER
-- ===========================================================
USE DATABASE FOX_DB;
USE SCHEMA PUBLIC;

-- Create a view to summarize monthly data dynamically
CREATE OR REPLACE VIEW V_MONTHLY_SUMMARY AS
SELECT 
    YEAR,
    MONTH,
    MONTHNAME,
    SUM(CASE WHEN IS_WORKING_DAY = 1 THEN 1 ELSE 0 END) AS TOTAL_WORKING_DAYS,
    SUM(CASE WHEN ISHOLIDAY = 1 THEN 1 ELSE 0 END) AS HOLIDAY_COUNT,
    MIN(DATE_AT) AS FIRST_DAY,
    MAX(DATE_AT) AS LAST_DAY
FROM CUR_CALENDAR
GROUP BY YEAR, MONTH, MONTHNAME
ORDER BY YEAR, MONTH;

-- Preview the view
SELECT *
FROM V_MONTHLY_SUMMARY
WHERE YEAR = 2025;
---==========================================================
-- Description
-- Purpose: generate reusable results from aggregated data.
--
-- What we did:
-- created function (or view) to summarize data by month.
--
-- Why it is Usefull:
-- makes analytics and dashboards easier without repeating queries.