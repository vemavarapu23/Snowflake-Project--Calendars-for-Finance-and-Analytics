-- ========================================================
-- Project: Calendars for Finance and Analytics
-- Worksheet 2: Stored Procedure
-- Purpose: Apply additional transformations to curated calendar data
-- Database: FOX_DB
-- Schema: PUBLIC
-- ========================================================

USE DATABASE FOX_DB;
USE SCHEMA PUBLIC;

-- Step 1: Create or replace a stored procedure
CREATE OR REPLACE PROCEDURE SP_TRANSFORM_CALENDAR()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN

    -- ========================================================
    -- Transformation 1: Add a "Day_Type" column
    -- Categorize each day as 'Weekday', 'Weekend', or 'Holiday'
    -- ========================================================
    CREATE OR REPLACE TABLE CUR_CALENDAR_STEP2 AS
    SELECT
        *,
        CASE 
            WHEN ISHOLIDAY = 1 THEN 'Holiday'
            WHEN ISWEEKEND = 1 THEN 'Weekend'
            ELSE 'Weekday'
        END AS DAY_TYPE
    FROM CUR_CALENDAR;

    -- ========================================================
    -- Transformation 2: Add "Fiscal_Year_Label"
    -- Label fiscal year dynamically, assuming fiscal year starts on July 1
    -- ========================================================
    CREATE OR REPLACE TABLE CUR_CALENDAR_STEP2 AS
    SELECT
        *,
        CASE
            WHEN MONTH >= 7 THEN YEAR || '-' || (YEAR + 1)
            ELSE (YEAR - 1) || '-' || YEAR
        END AS FISCAL_YEAR_LABEL
    FROM CUR_CALENDAR_STEP2;

    RETURN 'Stored Procedure Completed: CUR_CALENDAR_STEP2 Created Successfully';

END;
$$;

-- Step 2: Execute the stored procedure to apply transformations
CALL SP_TRANSFORM_CALENDAR();

-- Step 3: Preview the transformed table
SELECT *
FROM CUR_CALENDAR_STEP2
LIMIT 10;

-- ========================================================
-- Description:
-- Purpose: Enhance curated calendar data with new business insights

-- What we did:
-- 1) Created SP_TRANSFORM_CALENDAR stored procedure
-- 2) Transformation 1 - Added DAY_TYPE column for 'Weekday', 'Weekend', 'Holiday'
-- 3) Transformation 2 - Added FISCAL_YEAR_LABEL column dynamically (July-June fiscal year)
-- 4) Results stored in CUR_CALENDAR_STEP2 table

-- Why it’s useful: 
--Gives more analytical insights and allows fiscal reporting & filtering
-- ========================================================