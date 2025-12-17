-- ========================================================
-- Project: Calendars for Finance and Analytics
-- Worksheet 6: Task Layer
-- Purpose: Automate execution of data transformation stored procedure on a schedule
-- Database: FOX_DB
-- Schema: PUBLIC
-- ========================================================================

-- Switch to your working database and schema
USE DATABASE FOX_DB;
USE SCHEMA PUBLIC;

SHOW WAREHOUSES;


-- Step 1: Create a task to run every Sunday at 4 AM
-- This task will execute the stored procedure from Worksheet 2
CREATE OR REPLACE TASK TASK_CUR_CALENDAR
  WAREHOUSE = FOX_WH  -- replace with your warehouse name (FOX is my WH name)
  SCHEDULE = 'USING CRON 0 4 * * 0 UTC'  -- Every Sunday at 4 AM UTC
AS
CALL SP_CURATE_CALENDAR();  -- Stored Procedure created in Worksheet 2

-- Step 2: Test the task by running it manually (optional)
-- EXECUTE TASK TASK_CUR_CALENDAR;
EXECUTE TASK TASK_CUR_CALENDAR;

-- Step 3: Suspend the task after testing to prevent automatic runs
ALTER TASK TASK_CUR_CALENDAR SUSPEND;

-- Step 4: Check task status
SHOW TASKS LIKE 'TASK_CUR_CALENDAR';

-- ========================================================
--Description: 
-- Purpose:
-- Automate the execution of your stored procedure that performs data transformations.
-- Ensures your curated data is always updated on a scheduled basis.

-- What we did:
-- Created TASK_CUR_CALENDAR to run every Sunday at 4 AM.
-- Linked it to the stored procedure SP_CURATE_CALENDAR from Worksheet 2.
-- Tested and suspended it to prevent accidental execution.

-- Why it is useful:
-- Automation reduces manual work and ensures consistent, timely updates.
-- Makes your project look professional and production-ready.