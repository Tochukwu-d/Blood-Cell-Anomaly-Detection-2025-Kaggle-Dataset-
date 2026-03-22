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
