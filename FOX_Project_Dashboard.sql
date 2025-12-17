-- ========================================================
-- Project: Calendars for Finance and Analytics
-- Worksheet: FOX_Project_Dashboard
-- Purpose: Provide business-friendly summary and visual insights using curated calendar data
-- Database: FOX_DB
-- Schema: PUBLIC
-- ========================================================================

USE DATABASE FOX_DB;
USE SCHEMA PUBLIC;

-- ========================================================
-- TILE 1: Count of Working Days per Month
-- Business-friendly name: Monthly Working Days
-- Purpose: Shows how many working days are in each month for planning purposes
-- ========================================================================
SELECT 
    YEAR,
    MONTH_NAME_ABBR AS MONTH,
    SUM(IS_WORKING_DAY) AS WORKING_DAYS
FROM CUR_CALENDAR
GROUP BY YEAR, MONTH_NAME_ABBR
ORDER BY YEAR, MONTH;

-- ========================================================
-- TILE 2: Count of Holidays per Month
-- Business-friendly name: Monthly Holidays
-- Purpose: Highlights months with more holidays to help in resource planning
-- ========================================================================
SELECT 
    YEAR,
    MONTH_NAME_ABBR AS MONTH,
    SUM(CASE WHEN ISHOLIDAY = 1 THEN 1 ELSE 0 END) AS HOLIDAY_COUNT,
    LISTAGG(HOLIDAYTEXT, ', ') AS HOLIDAY_NAMES
FROM CUR_CALENDAR
GROUP BY YEAR, MONTH_NAME_ABBR
ORDER BY YEAR, MONTH;

-- ========================================================
-- TILE 3: Fiscal Quarter Summary
-- Business-friendly name: Quarter Overview
-- Purpose: Aggregates working days and holidays per quarter for management reporting
-- ========================================================================
SELECT
    FISCAL_QUARTER_LABEL,
    SUM(IS_WORKING_DAY) AS TOTAL_WORKING_DAYS,
    SUM(ISHOLIDAY) AS TOTAL_HOLIDAYS
FROM CUR_CALENDAR
GROUP BY FISCAL_QUARTER_LABEL
ORDER BY FISCAL_QUARTER_LABEL;

-- ========================================================
-- TILE 4: Year-to-Date Working Days vs Holidays
-- Business-friendly name: YTD Working Days vs Holidays
-- Purpose: Compares cumulative working days and holidays in the current year
-- ========================================================================
SELECT
    YEAR,
    SUM(IS_WORKING_DAY) AS YTD_WORKING_DAYS,
    SUM(ISHOLIDAY) AS YTD_HOLIDAYS
FROM CUR_CALENDAR
WHERE YEAR = EXTRACT(YEAR FROM CURRENT_DATE)
GROUP BY YEAR;

-- ========================================================
-- Description:
-- 1. Each tile is a separate query showing business-relevant insights.
-- 2. Columns and labels are named for easy interpretation by non-technical users.
-- 3. Aggregations used: SUM, LISTAGG for clear metrics.
-- 4. Naming convention: "FOX_Project_Dashboard" as worksheet name; tile names in comments.
-- 5. Useful for business: Quick visual summary of working days, holidays, and quarterly planning.
-- ========================================================
