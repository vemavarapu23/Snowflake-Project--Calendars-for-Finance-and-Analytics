-- ========================================================
-- Project: Calendars for Finance and Analytics
-- Worksheet 1: Curation Layer
-- Purpose: Enhance raw calendar data with additional flags, readable fields, and clean missing values
-- Database: FOX_DB
-- Schema: PUBLIC
-- ========================================================================
-- create or replace curated table
--- Original date
USE DATABASE FOX_DB;
USE SCHEMA PUBLIC;

-- Step 1: Create curated table with 5 enhancements:
-- 1) Add Is_Working_Day flag (1=working day, 0=weekend/holiday)
-- 2) Add Month_Name_Abbrev
-- 3) Add Fiscal_Quarter_Label
-- 4) Add Year-Month formatted string
-- 5) Add Current_Month_Flag
CREATE OR REPLACE TABLE CUR_CALENDAR AS
SELECT
    DATE_AT,   -- Orginal Date
    DAY,       --- Day number in the month
    WEEKDAY,   --- Day number in the week (0=Sunday, 1=Monday...)
    ISWEEKEND,  -- 1=Weekend, 0=Weekday
    ISHOLIDAY,  -- 1=Holiday, 0=Not holiday
    HOLIDAYTEXT, -- Name of holiday if applicable
    MONTH,       -- Month number
    MONTHNAME,   -- Month full name
    QUARTER,     -- Quarter number
    YEAR,        -- Year number
    
    -- Enhancement 1: Working day flag
    -- 1 = working day (not weekend and not holiday), 0 = weekend or holiday
    CASE WHEN ISWEEKEND = 0 AND ISHOLIDAY = 0 THEN 1 ELSE 0 END AS IS_WORKING_DAY,
    
 -- Enhancement 2: Abbreviated Month Name for cleaner labels in dashboards

    LEFT(MONTHNAME,3) AS MONTH_NAME_ABBR,
    
 -- Enhancement 3: Fiscal Quarter Label for reporting (i.e,Q2-2027)
    'Q' || QUARTER || '-' || YEAR AS FISCAL_QUARTER_LABEL,
    
    -- Enhancement 4: Year-Month formatted string for monthly aggregations (YYYY-MM)
    TO_CHAR(DATE_AT,'YYYY-MM') AS YEAR_MONTH,
    
    -- Enhancement 5: Current Month Flag (1=current month, 0=other months)
       CASE 
        WHEN EXTRACT(MONTH FROM DATE_AT) = EXTRACT(MONTH FROM CURRENT_DATE)
         AND EXTRACT(YEAR FROM DATE_AT) = EXTRACT(YEAR FROM CURRENT_DATE)
        THEN 1
        ELSE 0
    END AS CURRENT_MONTH_FLAG
-- -- Source raw calendar data
FROM CALENDAR_RAW; 

-- Preview curated table
SELECT *
FROM CUR_CALENDAR
LIMIT 10;
-- ===========================================
--Description
--Purpose:
--Prepare raw calendar data for analysis.
--Add useful flags and labels for reporting.
 
--What we did:
--1) Created CUR_CALENDAR in FOX_DB.PUBLIC using raw data
-- 2) Added dynamic enhancements for better reporting:
--    a) IS_WORKING_DAY - flags weekdays that are not holidays
--    b) MONTH_NAME_ABBR - short month names
--    c) FISCAL_QUARTER_LABEL - dynamically combines quarter and year
--    d) YEAR_MONTH - formats for monthly aggregation
--    e) CURRENT_MONTH_FLAG - dynamically marks dates in the current month
-- 3) Table is fully dynamic and can be recreated anytime
--Why it’s useful:
--Makes raw data ready for dashboards and analytics.