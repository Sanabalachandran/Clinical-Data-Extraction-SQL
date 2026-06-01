WITH ranked_blood_labs AS (
    SELECT 
        patient_id,
        test_name,
        test_value,
        result_timestamp,
        ROW_NUMBER() OVER(PARTITION BY patient_id ORDER BY result_timestamp DESC) as ranking
    FROM lab_results
    -- Extract only tests containing 'globin' or 'plate' in the name
    WHERE test_name ILIKE '%globin%' OR test_name ILIKE '%plate%'
)
SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    r.test_name,
    r.test_value,
    CASE 
        WHEN r.test_name ILIKE '%hemoglobin%' AND r.test_value < 14.0 THEN 'Flagged: Below Range'
        WHEN r.test_name ILIKE '%platelet%' AND r.test_value < 150 THEN 'Flagged: Low Count'
        ELSE 'Within Acceptable Range'
    END AS evaluation_flag
FROM patients p
INNER JOIN ranked_blood_labs r ON p.patient_id = r.patient_id
WHERE r.ranking = 1;
