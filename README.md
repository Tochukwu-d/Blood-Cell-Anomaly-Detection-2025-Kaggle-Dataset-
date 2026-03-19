# **🩸 Blood Cell Anomaly Detection 2025**

This dataset provides 5,880 blood cell records across 19 cell types — covering normal white blood cells, red blood cells, and platelets alongside 12 clinically significant abnormal cell types linked to leukemia, anemia, infections, and sickle cell disease.

# **🔬 Inspiration**
Inspired by CytoDiffusion — published in Nature Machine Intelligence (2025) by researchers at the University of Cambridge, UCL, and Queen Mary University of London.

The model identifies abnormal blood cells with greater accuracy than human specialists. It generated synthetic blood cell images so realistic that 10 expert haematologists with up to 34 years of experience could not tell them apart from real ones (authenticity accuracy = 0.523 ≈ random chance).

**📂 Files**
| File                                  | Description                                      |
|---------------------------------------|--------------------------------------------------|
| blood_cell_anomaly_detection.csv      | Main dataset — 5,880 cells × 36 features         |
| cell_type_reference.csv               | Clinical reference for all 19 cell types         |
| cytodiffusion_benchmark_scores.csv    | Published benchmark metrics from the paper       |

**Task Overview**
Blood Cell Anomaly Detection 2025 dataset using SQL-based analysis.

## 📋 Task Index
1. [Disease Category Profiling](#1-disease-category-profiling)
2. [Anomaly Rate Analysis](#2-anomaly-rate-analysis)
3. [Cell Type Clinical Cross-Reference](#3-cell-type-clinical-cross-reference)
4. [Morphological Feature Comparison](#4-morphological-feature-comparison)
5. [Colorimetric & Staining Analysis](#5-colorimetric--staining-analysis)
6. [Nuclear & Chromatin Characterization](#6-nuclear--chromatin-characterization)
7. [Leukemia Cell Distinctiveness Profiling](#7-leukemia-cell-distinctiveness-profiling)
8. [Anemia & RBC Morphology Analysis](#8-anemia--rbc-morphology-analysis)
9. [Patient Demographics vs. Anomaly Patterns](#9-patient-demographics-vs-anomaly-patterns)
10. [Hematological Panel Correlation](#10-hematological-panel-correlation)
11. [AI Score vs. Clinical Label Alignment](#11-ai-score-vs-clinical-label-alignment)
12. [Labeller Confidence & Data Reliability](#12-labeller-confidence--data-reliability)
13. [Multi-Condition Cell Overlap Detection](#13-multi-condition-cell-overlap-detection)
14. [Imaging & Protocol Variation Audit](#14-imaging--protocol-variation-audit)

---

## 1. Disease Category Profiling

**Task:** Count total cells and compute anomaly prevalence per disease category.

**Insights:**
- Which disease categories (leukemia, anemia, infection, sickle cell) dominate the dataset
- Proportion of normal vs. abnormal cells within each condition
- Whether any disease category is underrepresented relative to clinical prevalence
- Dataset balance for diagnostic modelling across conditions

---

## 2. Anomaly Rate Analysis

**Task:** Calculate the anomaly rate per cell type and rank by severity of deviation from normal.

**Insights:**
- Which specific cell types have the highest anomaly concentration
- Whether anomaly rates cluster around particular disease families
- Identification of cell types that are exclusively abnormal vs. conditionally abnormal
- Early signal for which cell types require the most clinical attention

---

## 3. Cell Type Clinical Cross-Reference

**Task:** Join the main dataset with `cell_type_reference` to attach clinical significance to every record.

**Insights:**
- Full clinical context (disease linkage, significance) mapped onto each observed cell
- Whether actual sample counts in the dataset match expected reference counts
- Missing or over-sampled cell types that may skew clinical conclusions
- A complete lookup of which cell types are tied to life-threatening conditions

---

## 4. Morphological Feature Comparison

**Task:** Compare shape-based features (diameter, area, circularity, eccentricity, lobularity, membrane smoothness) between normal and abnormal cells — and across individual cell types.

**Insights:**
- Quantified morphological differences between healthy and diseased cells
- Which features show the largest separation between normal and anomaly groups
- Whether abnormal cells skew toward larger/smaller size or irregular shape
- Feature ranges that could serve as clinical diagnostic thresholds
- Lobularity patterns distinguishing neutrophils, blasts, and sickle cells

---

## 5. Colorimetric & Staining Analysis

**Task:** Analyse mean RGB channel values and stain intensity across cell groups, staining protocols, and microscope models.

**Insights:**
- Whether staining intensity reliably differentiates normal from abnormal cells
- Color profile signatures unique to specific disease-linked cell types
- Impact of staining protocol variation on colorimetric readings
- Red/blue channel dominance patterns linked to cell maturity or pathology
- Cells with atypical staining that may indicate preparation artifacts vs. true anomalies

---

## 6. Nuclear & Chromatin Characterization

**Task:** Analyse nucleus area percentage, chromatin density, and cytoplasm ratio across cell types and disease categories.

**Insights:**
- Nuclear-to-cytoplasm ratio shifts that indicate malignant transformation (common in leukemia)
- Chromatin density elevation in blast cells vs. mature normal cells
- Whether the nucleus area percentage alone is sufficient to flag anomalies
- Correlation between high chromatin density and high AI anomaly scores
- Cytoplasm ratio patterns distinguishing lymphocytes, monocytes, and blast variants

---

## 7. Leukemia Cell Distinctiveness Profiling

**Task:** Compute a morphological distinctiveness score for every leukemia-linked cell type relative to the normal cell average.

**Insights:**
- Ranking of leukemia subtypes by how morphologically extreme they appear
- Which blast or immature cell types are hardest to distinguish from normal (low distinctiveness = diagnostic risk)
- Feature-level breakdown of where each leukemia type diverges most from normal
- Prioritisation guide for which leukemia types need the most robust detection model

---

## 8. Anemia & RBC Morphology Analysis

**Task:** Filter for anemia- and sickle cell-linked records and analyse RBC-specific features (diameter, circularity, eccentricity, hemoglobin levels, MCV, MCHC).

**Insights:**
- Morphological signature of sickle cells vs. normal RBCs (eccentricity, circularity collapse)
- Correlation between low hemoglobin readings and abnormal RBC morphology
- MCV and MCHC patterns distinguishing microcytic, macrocytic, and normocytic anemia
- Whether hematocrit percentage aligns with visual cell-level anomaly scores
- Platelet count co-variation with anemia cell types

---

## 9. Patient Demographics vs. Anomaly Patterns

**Task:** Stratify anomaly rates, feature averages, and cell type distributions by `patient_age_group` and `patient_sex`.

**Insights:**
- Whether certain anomaly types are age-skewed (e.g., blast cells in younger patients)
- Sex-based variation in WBC/RBC counts and their relationship to anomaly prevalence
- Age group segments with disproportionately high cytodiffusion anomaly scores
- Demographics that may indicate dataset representation gaps for real-world deployment

---

## 10. Hematological Panel Correlation

**Task:** Correlate clinical blood count columns (WBC, RBC, hemoglobin, hematocrit, platelet count, MCV, MCHC) with morphological anomaly classifications.

**Insights:**
- Whether elevated WBC count reliably predicts leukemia-linked cell types in the dataset
- RBC count thresholds that co-occur with anemia cell type flags
- Hemoglobin and hematocrit joint patterns for each disease category
- Platelet count anomalies co-occurring with specific abnormal cell types
- Which hematological panel values are most clinically redundant given visual morphology

---

## 11. AI Score vs. Clinical Label Alignment

**Task:** Compare `cytodiffusion_anomaly_score` and `cytodiffusion_classification_confidence` against the ground truth `anomaly_label` to identify agreement and divergence.

**Insights:**
- Percentage of cells where the AI score agrees vs. disagrees with clinical labelling
- Cell types where the AI model is systematically under- or over-confident
- High-confidence AI calls that contradict the clinical label — potential labelling errors or edge cases
- Confidence score distribution across normal vs. anomaly groups
- Whether AI confidence correlates with labeller confidence or diverges

---

## 12. Labeller Confidence & Data Reliability

**Task:** Analyse `labeller_confidence_score` distribution across cell types, disease categories, and anomaly labels.

**Insights:**
- Cell types where human labellers showed lowest confidence — highest clinical ambiguity
- Whether low labeller confidence concentrates in specific disease categories
- Records where both AI and human confidence are low — highest-risk data points
- Confidence score thresholds below which records should be excluded from training data
- Distribution of confident vs. uncertain labels per dataset source

---

## 13. Multi-Condition Cell Overlap Detection

**Task:** Identify cell types or records whose feature profile overlaps across multiple disease categories, using range-based and average-proximity SQL logic.

**Insights:**
- Cell types that are morphologically ambiguous between two disease conditions
- Feature combinations that fail to uniquely distinguish leukemia from infection-linked cells
- Overlap zones between anemia subtypes that may cause misclassification
- Clinical decision boundaries where a second confirmatory test would be warranted
- Input for building a disambiguation ruleset for borderline cases

---

## 14. Imaging & Protocol Variation Audit

**Task:** Segment the dataset by `dataset_source`, `staining_protocol`, `microscope_model`, `magnification_x`, and `image_resolution_px` and assess whether imaging conditions affect feature measurements.

**Insights:**
- Whether morphological feature averages shift significantly across microscope models
- Staining protocol effect on mean RGB values and stain intensity readings
- Magnification-level impact on measured cell diameter and area in pixels
- Dataset sources introducing systematic bias in AI anomaly scores
- Protocol combinations that produce the most consistent, clinically reliable measurements

---

