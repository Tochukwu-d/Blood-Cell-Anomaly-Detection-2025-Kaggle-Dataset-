-- SQLBook: Code
SELECT DISTINCT disease_category, anomaly_label
FROM blood_cell_anomaly_detection;   -- to check the distinct values for disease category and anomaly label from the main table

-- a total of 8 disease categories exits in the data.
-- the anomaly label is binary (0 and 1)

SELECT 
    disease_category, 
    COUNT(*) AS number_of_cells,
    SUM(COUNT(*)) OVER() AS total_cells
FROM blood_cell_anomaly_detection
GROUP BY disease_category
ORDER BY COUNT(*) DESC;     -- counting cell records per disease category.

/* Normal_WBC has the highest count of 2800
   Sickel_Cell_Anemia disease category has the lowest count of 140
*/

SELECT  
    disease_category,
    anomaly_label,
    COUNT(*) AS number_of_cells
FROM blood_cell_anomaly_detection
GROUP BY disease_category, anomaly_label
ORDER BY disease_category, anomaly_label;

/* Anemia, Artefact, Infection, Leukemia, Sickle_Cell_Anemia are all anomaly
while Normal_Platelet, Normal_RBC, Normal_WBC are normal cell
*/

-- checking the anomaly_rate in %
SELECT
    disease_category,
    COUNT(*) AS total_cells,
    SUM(
        CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END
    ) AS anomaly_count,
    ROUND(
        SUM(
            CASE WHEN anomaly_label = 1 THEN 1 ELSE 0 END
        ) / COUNT(*) * 100
    , 2) AS anomaly_rate_pct
FROM blood_cell_anomaly_detection
GROUP BY disease_category
ORDER BY anomaly_rate_pct DESC;

-- checking data distribution (%)
SELECT  
    disease_category,
    anomaly_label,
    COUNT(*) AS number_of_cells,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS distribution_pct
FROM blood_cell_anomaly_detection
GROUP BY disease_category, anomaly_label
ORDER BY anomaly_label;

SELECT 
    CASE 
        WHEN anomaly_label = 0 THEN 'Normal'
        ELSE 'Abnormal'
    END AS cell_status,
    COUNT(*) AS total_cells,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM blood_cell_anomaly_detection
GROUP BY anomaly_label;

/* the Abnormal cells consititute only 31.97%, 
while the Normal (anomaly_label = 0) constitute
68.03% of the entire dataset.
*/

