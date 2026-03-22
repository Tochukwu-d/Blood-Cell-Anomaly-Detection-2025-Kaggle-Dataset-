SELECT COUNT(DISTINCT cell_type) AS unique_cell_types
FROM blood_cell_anomaly_detection;       # confirms the 19 distinct cell types in the data

SELECT cell_type, COUNT(cell_type) AS total_num
FROM blood_cell_anomaly_detection
GROUP BY cell_type
ORDER BY total_num DESC;     -- showing distribution of the different cell types across the data

SELECT
    cell_type,
    SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END) AS anomaly_cell_type_count,
    ROUND(
        SUM(CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END)
        / COUNT(*) * 100.0
    , 2) AS anomaly_rate_cell_type
FROM blood_cell_anomaly_detection
GROUP BY cell_type
ORDER BY cell_type;    -- showing the anomaly rate of the different cell types and total count for each.