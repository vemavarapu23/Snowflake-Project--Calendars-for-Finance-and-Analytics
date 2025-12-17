-- ======================================================================
-- PROJECT: Calendars for Finance and Analytics
-- WORKSHEET #3: Aggregation Layer
-- PURPOSE:
--   • Create aggregated views/tables that summarize curated data.
--   • Provide business-friendly metrics for reporting and dashboards.
--   • Store all aggregation objects in a separate schema to maintain
--     clear data pipeline layers (Raw → Curated → Aggregation).
--
-- DATABASE: FOX_DB
-- SCHEMA (NEW): AGG_LAYER
-- ======================================================================

USE DATABASE FOX_DB;

-- Step 1: Create a new schema for the aggregation layer
-- we use to separate CURATION objects from AGGREGATION objects.
CREATE OR REPLACE SCHEMA AGG_LAYER;

-- Switch to new schema
USE SCHEMA AGG_LAYER;


-- STEP 2: Create aggregation views/tables (minimum 4)
-- Each uses a different aggregation method: SUM, AVG, COUNT, MIN, MAX
-- Source table: CUR_CALENDAR (created in Worksheet #1)

-- ===========================================================
-- VIEW 1: Total Working Days per Month (SUM)
-- Purpose:
--   Summarize how many working days exist in each month.
--   Useful for payroll, scheduling, and forecasting workloads.
CREATE OR REPLACE VIEW AGG_WORKING_DAYS_MONTH AS
SELECT
    YEAR,
    MONTH,
    MONTHNAME,
    SUM(IS_WORKING_DAY) AS TOTAL_WORKING_DAYS
FROM PUBLIC.CUR_CALENDAR
GROUP BY YEAR, MONTH, MONTHNAME;


-- ===========================================================
-- VIEW 2: Average Working Days per Quarter (AVG)
-- Purpose:
--   Helps finance and planning teams understand typical
--   quarter lengths for forecasting and budgeting.
-- ===========================================================
CREATE OR REPLACE VIEW AGG_AVG_WORKING_DAYS_QTR AS
SELECT
    YEAR,
    QUARTER,
    AVG(IS_WORKING_DAY) AS AVG_WORKING_DAYS
FROM PUBLIC.CUR_CALENDAR
GROUP BY YEAR, QUARTER;

-- ===========================================================
-- VIEW 3: Number of Holidays per Year (COUNT)
-- Purpose:
--   Shows how many official holidays occur each year.
--   Used by HR and Finance teams.
-- ===========================================================
CREATE OR REPLACE VIEW AGG_HOLIDAY_COUNT_YEAR AS
SELECT
    YEAR,
    COUNT(*) AS TOTAL_HOLIDAYS
FROM PUBLIC.CUR_CALENDAR
WHERE ISHOLIDAY = 1
GROUP BY YEAR;


-- ===========================================================
-- VIEW 4: Minimum and Maximum Day Numbers per Month (MIN/MAX)
-- Purpose:
--   Shows the smallest and largest day-of-month values.
--   Helps validate calendar completeness and detect missing data.
-- ===========================================================
CREATE OR REPLACE VIEW AGG_DAY_RANGE_MONTH AS
SELECT
    YEAR,
    MONTH,
    MIN(DAY) AS MIN_DAY,
    MAX(DAY) AS MAX_DAY
FROM PUBLIC.CUR_CALENDAR
GROUP BY YEAR, MONTH;


-- ======================================================================
-- STEP 3: Create a MATERIALIZED VIEW
-- Purpose:
--   Provide a fast, pre-computed summary for dashboards.
--   Combines multiple metrics from curated calendar data.
-- ======================================================================
CREATE OR REPLACE MATERIALIZED VIEW MV_MONTHLY_SUMMARY AS
SELECT
    YEAR,
    MONTH,
    MONTHNAME,
    SUM(IS_WORKING_DAY) AS TOTAL_WORKING_DAYS,
    COUNT(CASE WHEN ISHOLIDAY = 1 THEN 1 END) AS HOLIDAY_COUNT,
    MIN(DAY) AS FIRST_DAY,
    MAX(DAY) AS LAST_DAY
FROM PUBLIC.CUR_CALENDAR
GROUP BY YEAR, MONTH, MONTHNAME;

--==========================================
-- preview views and materialized view
SHOW VIEWS IN SCHEMA AGG_LAYER;
SHOW MATERIALIZED VIEWS IN SCHEMA AGG_LAYER;
--========================================================
--Description:
--Purpose:
-- Create summary tables so teams can quickly see
-- monthly, quarterly, and yearly insights without scanning daily data.
--
-- What we did:
-- 1) Created a new schema AGG_LAYER for aggregated views.
-- 2) Built 4 summary views using SUM, COUNT, AVG, MIN/MAX.
-- 3) Added a materialized view for faster performance.
-- 4) All views read from CUR_CALENDAR (clean curated data).
--
-- Why it’s useful:
-- 1) Makes it easy for others to understand calendar trends.
-- 2) Helps dashboards load faster.
-- 3) Gives multiple ways to view the same data