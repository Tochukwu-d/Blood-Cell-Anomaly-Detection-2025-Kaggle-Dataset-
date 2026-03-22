-- SQLBook: Code
# Data Integrity Audit/Quality check.
# File: blood_cell_anomaly_detection.csv, cell_type_reference.csv, cytodiffusion_benchmark_scores.csv
SELECT
    `TABLE_NAME`,
    `TABLE_ROWS`
FROM information_schema.TABLES
WHERE TABLE_NAME IN (
    'blood_cell_anomaly_detection', 
    'cell_type_reference', 
    'cytodiffusion_benchmark_scores');       # TABLE_ROWS are usually approximate for innoDB

SELECT 
    COUNT(*) AS row_count
FROM blood_cell_anomaly_detection;  # to get the accurate value of number of rows for the tables

SELECT 
    COUNT(*) AS row_count 
FROM cell_type_reference;        # to get the accurate value of number of rows for the tables
    
SELECT 
    COUNT(*) AS row_count 
FROM cytodiffusion_benchmark_scores;  # to get the accurate value of number of rows for the tables


SELECT  `TABLE_NAME`, COUNT(*) AS total_columns
FROM information_schema.COLUMNS
WHERE `TABLE_SCHEMA` = "clinical_analyst_db"
GROUP BY `TABLE_NAME`
ORDER BY total_columns DESC;     # confirms the total number of columns in the dataset.

# Get table descriptions.
DESCRIBE blood_cell_anomaly_detection;
DESCRIBE cell_type_reference;
DESCRIBE cytodiffusion_benchmark_scores;
    
SELECT 
    `TABLE_NAME`,
    `COLUMN_NAME`,
    `DATA_TYPE`,
    `COLUMN_TYPE`,
    `IS_NULLABLE`,
    `COLUMN_DEFAULT`
FROM information_schema.COLUMNS
WHERE TABLE_NAME IN (
    'blood_cell_anomaly_detection', 
    'cell_type_reference' 
    'cytodiffusion_benchmark_scores')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

# check for columns with null values
SELECT   -- Select table names and build a SQL query string to count rows with nulls
    TABLE_NAME, -- Table name in the DB
    -- Build a SQL query as a string for each table
    CONCAT(
        'SELECT ''', TABLE_NAME, ''' AS table_name, COUNT(*) AS null_rows FROM ', TABLE_NAME,
        ' WHERE ',  
        GROUP_CONCAT(CONCAT(COLUMN_NAME, ' IS NULL') SEPARATOR ' OR ')
    ) AS query_to_run
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME IN (
    'blood_cell_anomaly_detection', 
    'cell_type_reference', 
    'cytodiffusion_benchmark_scores')
GROUP BY TABLE_NAME;         # the queries are ran to give the number of null values in the tables


