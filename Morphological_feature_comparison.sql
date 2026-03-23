-- Comparing statistical features across the 19 cell types
SELECT 
    cell_type,

    ROUND(MIN(cell_diameter_um), 2) AS min_cell_diameter,    
    ROUND(MAX(cell_diameter_um), 2) AS max_cell_diameter,
    ROUND(AVG(cell_diameter_um), 2) AS avg_cell_diameter,
    ROUND(STDDEV(cell_diameter_um), 2) AS stddev_cell_diameter,

    ROUND(MIN(cell_area_px), 2) AS min_cell_area_px,
    ROUND(MAX(cell_area_px), 2) AS max_cell_area_px,
    ROUND(AVG(cell_area_px), 2) AS avg_cell_area_px,
    ROUND(STDDEV(cell_area_px), 2) AS stddev_cell_area_px,

    ROUND(MIN(circularity), 2) AS min_circularity,
    ROUND(MAX(circularity), 2) AS max_circularity,
    ROUND(AVG(circularity), 2) AS avg_circularity,
    ROUND(STDDEV(circularity), 2) AS stddev_circularity,

    ROUND(MIN(eccentricity), 2) AS min_eccentricity,
    ROUND(MAX(eccentricity), 2) AS max_eccentricity,
    ROUND(AVG(eccentricity), 2) AS avg_eccentricity,
    ROUND(STDDEV(eccentricity), 2) AS stddev_eccentricity,

    ROUND(MIN(lobularity_score), 2) AS min_lobularity_score,
    ROUND(MAX(lobularity_score), 2) AS max_lobularity_score,
    ROUND(AVG(lobularity_score), 2) AS avg_lobularity_score,
    ROUND(STDDEV(lobularity_score), 2) AS stddev_lobularity_score,

    ROUND(MIN(membrane_smoothness), 2) AS min_membrane_smoothness,
    ROUND(MAX(membrane_smoothness), 2) AS max_membrane_smoothness,
    ROUND(AVG(membrane_smoothness), 2) AS avg_membrane_smoothness,
    ROUND(STDDEV(membrane_smoothness), 2) AS stddev_membrane_smoothness

FROM blood_cell_anomaly_detection
GROUP BY cell_type
ORDER BY cell_type;

SELECT
    anomaly_label,
    ROUND(
        AVG(cell_diameter_um), 4
    ) AS avg_cell_diameter,

    ROUND(
        STDDEV(cell_diameter_um), 4
    ) AS stddev_cell_diameter,

    ROUND(
        AVG(cell_area_px), 4
    ) AS avg_cell_area,

    ROUND(
        STDDEV(cell_area_px), 4
    ) AS stddev_cell_area,

    ROUND(
        AVG(circularity), 4
    ) AS avg_circularity,

    ROUND(
        STDDEV(circularity), 4
    ) AS stddev_circularity,

    ROUND(
        AVG(eccentricity), 4
    ) AS avg_eccentricity,

    ROUND(
        STDDEV(eccentricity), 4
    ) AS stddev_eccentricity,

    ROUND(
        AVG(lobularity_score), 4
    ) AS avg_lobularity_score,

    ROUND(
        STDDEV(lobularity_score), 4
    ) AS stddev_lobularity_score,

    ROUND(
        AVG(membrane_smoothness), 4
    ) AS avg_membrane_smoothness,

    ROUND(
        STDDEV(membrane_smoothness), 4
    ) AS stddev_membrane_smoothness
FROM blood_cell_anomaly_detection
GROUP BY anomaly_label;

/* 
The cell_area_px shows the biggest average difference between the anomaly_label.
Abnormal cells then to be larger, with abnormal physical characteristics compared to the normal cell types.

Across all six morphological features, the average values are consistently higher than the standard deviation, 
implying a low coefficient of variation. This suggests that the data exhibits limited dispersion relative to 
its mean, indicating homogeneity in cell characteristics within each cell type.
*/

-- deeper statistically dive
SELECT
    cell_type,
    anomaly_label,
    ROUND(
        AVG(cell_diameter_um), 4
    ) AS avg_cell_diameter,

    ROUND(
        STDDEV(cell_diameter_um), 4
    ) AS stddev_cell_diameter,

    ROUND(
        AVG(cell_area_px), 4
    ) AS avg_cell_area,

    ROUND(
        STDDEV(cell_area_px), 4
    ) AS stddev_cell_area,

    ROUND(
        AVG(circularity), 4
    ) AS avg_circularity,

    ROUND(
        STDDEV(circularity), 4
    ) AS stddev_circularity,

    ROUND(
        AVG(eccentricity), 4
    ) AS avg_eccentricity,

    ROUND(
        STDDEV(eccentricity), 4
    ) AS stddev_eccentricity,

    ROUND(
        AVG(lobularity_score), 4
    ) AS avg_lobularity_score,

    ROUND(
        STDDEV(lobularity_score), 4
    ) AS stddev_lobularity_score,

    ROUND(
        AVG(membrane_smoothness), 4
    ) AS avg_membrane_smoothness,

    ROUND(
        STDDEV(membrane_smoothness), 4
    ) AS stddev_membrane_smoothness
FROM blood_cell_anomaly_detection
GROUP BY cell_type, anomaly_label;

-- finding feature characteristics with largest seperation
SELECT *
FROM (

    SELECT
        'cell_diameter_um' AS cell_type_feature,
        ROUND(AVG(CASE WHEN anomaly_label = 0 THEN cell_diameter_um    ELSE NULL END), 2) AS normal_avg,
        ROUND(AVG(CASE WHEN anomaly_label = 1 THEN cell_diameter_um    ELSE NULL END), 2) AS anomaly_avg,
        ABS(
            ROUND(AVG(CASE WHEN anomaly_label = 1 THEN cell_diameter_um ELSE NULL END), 2) -
            ROUND(AVG(CASE WHEN anomaly_label = 0 THEN cell_diameter_um ELSE NULL END), 2)
        ) AS difference_value
    FROM blood_cell_anomaly_detection

    UNION ALL

    SELECT
        'cell_area_px' AS cell_type_feature,
        ROUND(AVG(CASE WHEN anomaly_label = 0 THEN cell_area_px ELSE NULL END), 2) AS normal_avg,
        ROUND(AVG(CASE WHEN anomaly_label = 1 THEN cell_area_px ELSE NULL END), 2) AS anomaly_avg,
        ABS(
            ROUND(AVG(CASE WHEN anomaly_label = 1 THEN cell_area_px ELSE NULL END), 2) -
            ROUND(AVG(CASE WHEN anomaly_label = 0 THEN cell_area_px ELSE NULL END), 2)
        ) AS difference_value
    FROM blood_cell_anomaly_detection

    UNION ALL

    SELECT
        'circularity' AS cell_type_feature,
        ROUND(AVG(CASE WHEN anomaly_label = 0 THEN circularity ELSE NULL END), 2) AS normal_avg,
        ROUND(AVG(CASE WHEN anomaly_label = 1 THEN circularity ELSE NULL END), 2) AS anomaly_avg,
        ABS(
            ROUND(AVG(CASE WHEN anomaly_label = 1 THEN circularity ELSE NULL END), 2) -
            ROUND(AVG(CASE WHEN anomaly_label = 0 THEN circularity ELSE NULL END), 2)
        ) AS difference_value
    FROM blood_cell_anomaly_detection

    UNION ALL

    SELECT
        'eccentricity' AS cell_type_feature,
        ROUND(AVG(CASE WHEN anomaly_label = 0 THEN eccentricity ELSE NULL END), 2) AS normal_avg,
        ROUND(AVG(CASE WHEN anomaly_label = 1 THEN eccentricity ELSE NULL END), 2) AS anomaly_avg,
        ABS(
            ROUND(AVG(CASE WHEN anomaly_label = 1 THEN eccentricity     ELSE NULL END), 2) -
            ROUND(AVG(CASE WHEN anomaly_label = 0 THEN eccentricity     ELSE NULL END), 2)
        ) AS difference_value
    FROM blood_cell_anomaly_detection

    UNION ALL

    SELECT
        'lobularity_score' AS cell_type_feature,
        ROUND(AVG(CASE WHEN anomaly_label = 0 THEN lobularity_score ELSE NULL END), 2) AS normal_avg,
        ROUND(AVG(CASE WHEN anomaly_label = 1 THEN lobularity_score ELSE NULL END), 2) AS anomaly_avg,
        ABS(
            ROUND(AVG(CASE WHEN anomaly_label = 1 THEN lobularity_score ELSE NULL END), 2) -
            ROUND(AVG(CASE WHEN anomaly_label = 0 THEN lobularity_score ELSE NULL END), 2)
        ) AS difference_value
    FROM blood_cell_anomaly_detection

    UNION ALL

    SELECT
        'membrane_smoothness' AS cell_type_feature,
        ROUND(AVG(CASE WHEN anomaly_label = 0 THEN membrane_smoothness ELSE NULL END), 2) AS normal_avg,
        ROUND(AVG(CASE WHEN anomaly_label = 1 THEN membrane_smoothness ELSE NULL END), 2) AS anomaly_avg,
        ABS(
            ROUND(AVG(CASE WHEN anomaly_label = 1 THEN membrane_smoothness ELSE NULL END), 2) -
            ROUND(AVG(CASE WHEN anomaly_label = 0 THEN membrane_smoothness ELSE NULL END), 2)
        ) AS difference_value
    FROM blood_cell_anomaly_detection

) AS difference_value

ORDER BY difference_value DESC;

/*
The cell_area_px has a largest absolute separation between normal and anomal, 
with gap of 39.09, making it a very clinically valuable for diagnosis.

Membrane_smoothness has the smallest to almost no difference between the two groups
*/


-- Flagging clinical threshold candidates
SELECT
    a.cell_type,
    -- Normal reference ranges
    n.min_diameter,     n.max_diameter,
    n.min_area,         n.max_area,
    n.min_circularity,  n.max_circularity,
    n.min_eccentricity, n.max_eccentricity,
    n.min_lobularity,   n.max_lobularity,
    n.min_smoothness,   n.max_smoothness,
    -- Flag each feature against the normal reference range
    CASE
        WHEN a.avg_diameter BETWEEN n.min_diameter AND n.max_diameter
        THEN 'Within range'
        ELSE 'Outside range'
    END AS diameter_flag,

    CASE
        WHEN a.avg_area BETWEEN n.min_area AND n.max_area
        THEN 'Within range'
        ELSE 'Outside range'
    END AS area_flag,

    CASE
        WHEN a.avg_circularity  BETWEEN n.min_circularity AND n.max_circularity
        THEN 'Within range'
        ELSE 'Outside range'
    END AS circularity_flag,

    CASE
        WHEN a.avg_eccentricity BETWEEN n.min_eccentricity  AND n.max_eccentricity
        THEN 'Within range'
        ELSE 'Outside range'
    END AS eccentricity_flag,

    CASE
        WHEN a.avg_lobularity   BETWEEN n.min_lobularity AND n.max_lobularity
        THEN 'Within range'
        ELSE 'Outside range'
    END AS lobularity_flag,

    CASE
        WHEN a.avg_smoothness   BETWEEN n.min_smoothness    AND n.max_smoothness
        THEN 'Within range'
        ELSE 'Outside range'
    END AS smoothness_flag,
    -- Total features outside normal range — clinical priority score
    (
        CASE WHEN a.avg_diameter     NOT BETWEEN n.min_diameter     AND n.max_diameter     THEN 1 ELSE 0 END +
        CASE WHEN a.avg_area         NOT BETWEEN n.min_area          AND n.max_area         THEN 1 ELSE 0 END +
        CASE WHEN a.avg_circularity  NOT BETWEEN n.min_circularity   AND n.max_circularity  THEN 1 ELSE 0 END +
        CASE WHEN a.avg_eccentricity NOT BETWEEN n.min_eccentricity  AND n.max_eccentricity THEN 1 ELSE 0 END +
        CASE WHEN a.avg_lobularity   NOT BETWEEN n.min_lobularity    AND n.max_lobularity   THEN 1 ELSE 0 END +
        CASE WHEN a.avg_smoothness   NOT BETWEEN n.min_smoothness    AND n.max_smoothness   THEN 1 ELSE 0 END
    ) AS features_outside_normal_range

FROM
    (
        SELECT
            cell_type,
            AVG(cell_diameter_um)    AS avg_diameter,
            AVG(cell_area_px)        AS avg_area,
            AVG(circularity)         AS avg_circularity,
            AVG(eccentricity)        AS avg_eccentricity,
            AVG(lobularity_score)    AS avg_lobularity,
            AVG(membrane_smoothness) AS avg_smoothness
        FROM blood_cell_anomaly_detection
        WHERE anomaly_label = 1
        GROUP BY cell_type
    ) AS a

    CROSS JOIN
    (
        SELECT
            MIN(cell_diameter_um)    AS min_diameter,     MAX(cell_diameter_um)    AS max_diameter,
            MIN(cell_area_px)        AS min_area,          MAX(cell_area_px)        AS max_area,
            MIN(circularity)         AS min_circularity,   MAX(circularity)         AS max_circularity,
            MIN(eccentricity)        AS min_eccentricity,  MAX(eccentricity)        AS max_eccentricity,
            MIN(lobularity_score)    AS min_lobularity,    MAX(lobularity_score)    AS max_lobularity,
            MIN(membrane_smoothness) AS min_smoothness,    MAX(membrane_smoothness) AS max_smoothness
        FROM blood_cell_anomaly_detection
        WHERE anomaly_label = 0
    ) AS n

ORDER BY features_outside_normal_range DESC;