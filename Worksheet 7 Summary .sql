-- ========================================================
-- Project : Calendars for Finance and Analytics
-- Worksheet #7: Project Summary
-- ========================================================
-- Data Set Name and Description:
-- FOX Calendar Data
-- Curated calendar dataset for finance and analytics.
-- Includes flags for weekends, holidays, working days, fiscal quarters, and formatted date fields.

-- Naming Convention and Schemas:
-- Curated tables: CUR_<table_name> (e.g., CUR_CALENDAR)
-- Aggregation tables/views: AGG_<table_name> or GLD_<table_name>
-- Stored procedures: SP_<procedure_name>
-- Tasks: TASK_<task_name>
-- Schemas:
-- PUBLIC - Curation Layer
-- AGGREGATION (or chosen schema) - Aggregation Layer
-- Makes it easy to locate objects in the database.

-- Custom Fields / Logic in Curation Layer:
-- IS_WORKING_DAY - 1 if weekday & not holiday, else 0
-- MONTH_NAME_ABBR - first 3 letters of month
-- FISCAL_QUARTER_LABEL - 'Q' || QUARTER || '-' || YEAR
-- YEAR_MONTH - formatted YYYY-MM for aggregation
-- CURRENT_MONTH_FLAG - 1 if current month, else 0

-- Why it is useful:
-- Standardizes data for analysis and dashboards.
-- Enables quick reporting, aggregation, and automation.
-- All objects use CREATE OR REPLACE for easy recreation.
