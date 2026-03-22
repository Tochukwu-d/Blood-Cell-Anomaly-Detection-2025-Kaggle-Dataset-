SELECT DISTINCT
    b.cell_type,
    b.disease_category,
    b.anomaly_label,
    c.clinical_significance
FROM blood_cell_anomaly_detection AS b
LEFT JOIN cell_type_reference AS c
    ON b.cell_type = c.cell_type
ORDER BY b.cell_type;      -- mapping the cell types to clinical significance for each