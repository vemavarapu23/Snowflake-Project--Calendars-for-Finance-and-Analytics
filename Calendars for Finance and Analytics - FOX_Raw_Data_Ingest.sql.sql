--=============================================================================
-- Project: Calendars for Finance and Analytics
--Worksheet 0: Raw Data Ingestion
-- Purpose: Reference the raw calendar dataset from Snowflake Marketplace into FOX_DB for further processing.
-- Note: This layer is read-only. No transformations are applied here.
-- ============================================================================
-- Switch to the shared Marketplace database
USE DATABASE CALENDARS_FOR_FINANCE_AND_ANALYTICS;

-- List schemas
SHOW SCHEMAS;

-- Check tables in PUBLIC schema
SHOW TABLES IN SCHEMA PUBLIC;

-- Check views (sometimes Marketplace uses views instead of tables)
SHOW VIEWS IN SCHEMA PUBLIC;

--switch to your own database
USE DATABASE FOX_DB;
USE SCHEMA PUBLIC;

-- Copy the Marketplace view into your own raw table
CREATE OR REPLACE TABLE CALENDAR_RAW AS
SELECT *
FROM CALENDARS_FOR_FINANCE_AND_ANALYTICS.PUBLIC.V_CALENDAR_DIM;

-- Preview data
SELECT * FROM CALENDAR_RAW LIMIT 10;
