SELECT COUNT(DISTINCT cell_type) AS unique_cell_types
FROM blood_cell_anomaly_detection;       # confirms the 19 distinct cell types in the data

SELECT cell_type, COUNT(cell_type) AS total_num
FROM blood_cell_anomaly_detection
GROUP BY cell_type
ORDER BY total_num DESC;     -- showing distribution of the different cell types across the data

SELECT
    cell_type,
    disease_category,
    SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END) AS anomaly_cell_type_count,
    ROUND(
        SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END)
        / COUNT(*) * 100.0
    , 2) AS anomaly_rate_cell_type  
FROM blood_cell_anomaly_detection
GROUP BY cell_type, disease_category
ORDER BY cell_type, disease_category;    -- showing the anomaly rate of the different cell types and total count for each.

/* Artefact, Leukemia, Anemia, Sickle_Cell_Anemia, Infection, 
produces an exclusive abnormal cell types.*/

SELECT
    cell_type,
    disease_category,
    anomaly_cell_type_count,
    anomaly_rate_cell_type,
    RANK() OVER (ORDER BY anomaly_rate_cell_type DESC) AS anomaly_ranking
FROM (
    SELECT
        cell_type,
        disease_category,
        SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END) AS anomaly_cell_type_count,
        ROUND(
            SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END) 
            / COUNT(*) * 100.0
        , 2) AS anomaly_rate_cell_type
    FROM blood_cell_anomaly_detection
    GROUP BY cell_type, disease_category
) t
ORDER BY anomaly_ranking;       -- adding the ranking logic to the code

SELECT
    cell_type,
    disease_category,
    anomaly_cell_type_count,
    anomaly_rate_cell_type,
    CASE 
        WHEN anomaly_rate_cell_type >= 99.99 THEN 'Exclusively Abnormal'
        WHEN anomaly_rate_cell_type > 0 AND anomaly_rate_cell_type < 99.99 THEN 'Conditionally Abnormal'
        WHEN anomaly_rate_cell_type = 0 THEN 'Exclusively Normal'
        ELSE 'Undefined'
    END AS flag
FROM (
    SELECT
        cell_type,
        disease_category,
        SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END) AS anomaly_cell_type_count,
        ROUND(
            SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END) * 100.0
            / COUNT(*)
        , 2) AS anomaly_rate_cell_type
    FROM blood_cell_anomaly_detection
    GROUP BY cell_type, disease_category
) t
ORDER BY cell_type, disease_category;        -- adding flag for abnormal and normal cell types

