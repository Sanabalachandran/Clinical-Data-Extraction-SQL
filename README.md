# Clinical-Data-Extraction-SQL
PostgreSQL
# Clinical Data Extraction & Advanced Query Optimization

## 📌 Project Overview
This repository contains production-grade SQL scripts optimized for advanced data extraction, longitudinal tracking, and patient data deduplication. Using a simulated clinical operations database, the queries demonstrate how to cleanly structure, filter, and isolate specific clinical events from complex relational tables without compromising data integrity.

## 🛠️ Core SQL Concepts Demonstrated
* **Multi-Table Joins:** Utilizing `LEFT JOIN` to preserve complete patient cohorts (preventing accidental record loss) vs. `INNER JOIN` for strict operational matches.
* **Common Table Expressions (CTEs):** Chaining multiple `WITH` clauses to build highly readable, modular, and maintainable extraction pipelines instead of nested subqueries.
* **Window Functions:** Employing `ROW_NUMBER()` paired with `PARTITION BY` and `ORDER BY` to isolate the single most recent lab result per patient.
* **Date & Timestamp Manipulation:** Implementing strict date boundaries (`>= '2026-02-01'`) and data formatting tools.
* **Conditional Handling:** Using `COALESCE()` to cleanly substitute potential `NULL` database returns with clear, operational values (e.g., displaying `0` instead of blank spaces for total appointments).
* **Conditional Logic (`CASE WHEN`):** Implementing multi-branch conditional loops directly within the data pipeline to synthesize new categorical indicators based on continuous clinical thresholds.
* **Advanced Text Filtering (`LIKE` / `ILIKE`):** Applying case-insensitive wildcard searches (`%`) to robustly isolate specific target groups within unstructured or variable text fields.
## 📊 Database Schema Summary
The extraction pipeline interacts with three core tables:
1. **`patients`**: Master demographic and enrollment records.
2. **`appointments`**: Operational log tracking dates and clinical departments (e.g., Oncology, Cardiology).
3. **`lab_results`**: Longitudinal laboratory tracking data containing test names, values, and precise timestamps.

## 🚀 How to Replicate This Environment
1. Run the scripts inside `schema_setup.sql` in any PostgreSQL environment (such as pgAdmin 4) to automatically generate the architecture and populate the practice records.
2. Execute the production script in `patient_extraction_queries.sql` to generate the consolidated clinical summary report.
