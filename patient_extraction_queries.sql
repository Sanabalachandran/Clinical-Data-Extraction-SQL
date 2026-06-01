-- Step 1: Isolate and rank lab results to find the newest test for each patient
WITH latest_lab_results AS (
    SELECT 
        patient_id,
        test_name,
        test_value,
        result_timestamp,
        ROW_NUMBER() OVER(PARTITION BY patient_id ORDER BY result_timestamp DESC) as ranking
    FROM lab_results
    -- Filter for records starting from February 2026 onwards
    WHERE result_timestamp >= '2026-02-01'
),

-- Step 2: Calculate total appointments per patient so we don't duplicate rows later
appointment_counts AS (
    SELECT 
        patient_id, 
        COUNT(appointment_id) AS total_appointments
    FROM appointments
    GROUP BY patient_id
)

-- Step 3: Extract the final consolidated report using clean Joins
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.enrollment_date,
    COALESCE(ac.total_appointments, 0) AS total_appointments,
    lr.test_name AS latest_test_name,
    lr.test_value AS latest_test_value,
    lr.result_timestamp AS latest_test_date
FROM patients p
LEFT JOIN appointment_counts ac ON p.patient_id = ac.patient_id
LEFT JOIN latest_lab_results lr ON p.patient_id = lr.patient_id AND lr.ranking = 1
ORDER BY p.patient_id;
