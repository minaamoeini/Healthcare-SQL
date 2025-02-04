--Age Column:
-- 1. Equal Intervals (e.g., every 10 years)
-- Categorize the ages into bins and count the number of individuals in each bin
--Use Case: General demographics, education, healthcare.

SELECT
    CASE
        WHEN Age BETWEEN 0 AND 10 THEN '0-10'
        WHEN Age BETWEEN 11 AND 20 THEN '11-20'
        WHEN Age BETWEEN 21 AND 30 THEN '21-30'
        WHEN Age BETWEEN 31 AND 40 THEN '31-40'
        WHEN Age BETWEEN 41 AND 50 THEN '41-50'
        WHEN Age BETWEEN 51 AND 60 THEN '51-60'
        WHEN Age BETWEEN 61 AND 70 THEN '61-70'
        WHEN Age BETWEEN 71 AND 80 THEN '71-80'
        WHEN Age BETWEEN 81 AND 90 THEN '81-90'
        ELSE '90+'
    END AS Age_Group,       -- Define age groups
    COUNT(*) AS Count,      -- Count the number of individuals in each age group
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage
                            -- Calculate percentage relative to the total count
FROM healthcare    -- Specify the dataset (table) to query
GROUP BY Age_Group          -- Group the results by age group
ORDER BY Age_Group;         -- Order the results by age group for readability

-- 2. Developmental Stages (Life Stages)
-- Categorize ages into developmental stages, count individuals, and calculate percentage
--Use Case: Life-stage-specific analyses like healthcare or behavioral studies.

SELECT
    CASE
        WHEN Age BETWEEN 0 AND 5 THEN 'Infants and Toddlers (0-5)'
        WHEN Age BETWEEN 6 AND 12 THEN 'Children (6-12)'
        WHEN Age BETWEEN 13 AND 17 THEN 'Adolescents (13-17)'
        WHEN Age BETWEEN 18 AND 24 THEN 'Young Adults (18-24)'
        WHEN Age BETWEEN 25 AND 39 THEN 'Early Adulthood (25-39)'
        WHEN Age BETWEEN 40 AND 59 THEN 'Middle Adulthood (40-59)'
        WHEN Age >= 60 THEN 'Older Adults (60+)'
        ELSE 'Unknown' -- Handle any missing or invalid age values
    END AS Life_Stage,         -- Define the developmental stage categories
    COUNT(*) AS Count,         -- Count the number of individuals in each stage
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage
                                -- Calculate percentage relative to the total count
FROM healthcare        -- Replace with your actual table name
GROUP BY Life_Stage             -- Group by the life stage categories
ORDER BY Count DESC;            -- Order by the count (descending) for better readability

--3. Targeted Grouping (Domain-Specific)
-- Categorize the ages into specific groups, count individuals, and calculate percentage
-- Use Case: Health interventions, insurance policies.

SELECT
    CASE
        WHEN Age BETWEEN 0 AND 18 THEN 'Pediatric (0-18)'
        WHEN Age BETWEEN 19 AND 35 THEN 'Young Adults (19-35)'
        WHEN Age BETWEEN 36 AND 50 THEN 'Mature Adults (36-50)'
        WHEN Age BETWEEN 51 AND 65 THEN 'Pre-Seniors (51-65)'
        WHEN Age >= 66 THEN 'Seniors (66+)'
        ELSE 'Unknown'
    END AS Age_Group,         -- Define age group categories
    COUNT(*) AS Count,        -- Count the number of individuals in each group
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage,
    CASE
        WHEN Age BETWEEN 0 AND 18 THEN 1
        WHEN Age BETWEEN 19 AND 35 THEN 2
        WHEN Age BETWEEN 36 AND 50 THEN 3
        WHEN Age BETWEEN 51 AND 65 THEN 4
        WHEN Age >= 66 THEN 5
        ELSE 6
    END AS Age_Order          -- Define an order for sorting by age group
FROM healthcare       -- Specify the dataset (table) to query
GROUP BY Age_Group, Age_Order -- Group by the age group categories and the order column
ORDER BY Age_Order;           -- Order the results based on the logical age order
--3. Uneven Ranges for Specific Analysis
-- Categorize the ages into uneven ranges, count individuals, and calculate percentage
--Use Case: Workforce, economics, housing

SELECT
    CASE
        WHEN Age BETWEEN 0 AND 14 THEN 'Dependent Children (0-14)'
        WHEN Age BETWEEN 15 AND 24 THEN 'Transition Age (15-24)'
        WHEN Age BETWEEN 25 AND 54 THEN 'Working-Age Adults (25-54)'
        WHEN Age BETWEEN 55 AND 64 THEN 'Pre-Retirement (55-64)'
        WHEN Age >= 65 THEN 'Retirement (65+)'
        ELSE 'Unknown'
    END AS Age_Group,         -- Define age group categories
    COUNT(*) AS Count,        -- Count the number of individuals in each group
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage,
    CASE
        WHEN Age BETWEEN 0 AND 14 THEN 1
        WHEN Age BETWEEN 15 AND 24 THEN 2
        WHEN Age BETWEEN 25 AND 54 THEN 3
        WHEN Age BETWEEN 55 AND 64 THEN 4
        WHEN Age >= 65 THEN 5
        ELSE 6
    END AS Age_Order          -- Define an order for sorting by age group
FROM healthcare       -- Specify the dataset (table) to query
GROUP BY Age_Group, Age_Order -- Group by the age group categories and the order column
ORDER BY Age_Order;           -- Order the results based on the logical age order

--Gender Column:
-- Count the number of individuals by gender and calculate their percentage
SELECT
    Gender,                         -- Gender column (Male, Female, etc.)
    COUNT(*) AS Count,              -- Count the number of occurrences for each gender
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage
                                    -- Calculate percentage relative to the total count
FROM healthcare             -- Specify the dataset (table) to query
GROUP BY Gender                     -- Group by each unique gender
ORDER BY Count DESC;                -- Order the results by count in descending order

--Blood Type Column:
-- Count the occurrences of each blood type and calculate the percentage
SELECT
    "Blood Type",                     -- Blood type column
    COUNT(*) AS Count,              -- Count the number of occurrences for each blood type
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage
                                     -- Calculate percentage relative to the total count
FROM healthcare             -- Replace with your actual table name
GROUP BY "Blood Type"                 -- Group by each unique blood type
ORDER BY Count DESC;                -- Order the results by count in descending order
--Medical Condition Column:
-- Count occurrences of each medical condition and calculate their percentage
SELECT
    "Medical Condition",              -- Medical condition column
    COUNT(*) AS Count,              -- Count the number of occurrences for each medical condition
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)), 2) AS Percentage
                                     -- Calculate percentage relative to the total count
FROM healthcare             -- Specify the dataset (table) to query
GROUP BY "Medical Condition"          -- Group by each unique medical condition
ORDER BY Count DESC;                -- Order by count in descending order

---1. Find the length of stay and distribution of patients
SELECT
    -- Calculate the length of stay in days by subtracting admission date from discharge date
    -- and round to the nearest whole number for easier grouping
    ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) AS Length_of_Stay,

    -- Count the number of patients for each length of stay
    COUNT(*) AS Frequency,

    -- Calculate the percentage of each length of stay group
    -- by dividing the frequency by the total number of records
    -- and multiplying by 100 for percentage representation
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM healthcare

-- Group by the calculated length of stay to count occurrences for each unique value
GROUP BY
    ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission]))

-- Order the results by length of stay in ascending order for better readability
ORDER BY
    Length_of_Stay;

-- Classify patients into categories based on their length of stay and analyze the distribution with percentages
SELECT
    -- Use a CASE statement to group Length of Stay into defined ranges
    CASE
        WHEN ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) BETWEEN 0 AND 5 THEN '0-5'
        WHEN ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) BETWEEN 6 AND 10 THEN '6-10'
        WHEN ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) BETWEEN 11 AND 15 THEN '11-15'
        WHEN ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) BETWEEN 16 AND 20 THEN '16-20'
        WHEN ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) BETWEEN 21 AND 25 THEN '21-25'
        WHEN ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) BETWEEN 26 AND 30 THEN '26-30'
        ELSE '31+' -- Group any Length of Stay greater than 30 days into '31+'
    END AS Length_of_Stay_Group,

    -- Count the number of patients in each Length of Stay group
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients in each Length of Stay group
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM
    healthcare

-- Group the results by the Length of Stay ranges defined in the CASE statement
GROUP BY
    Length_of_Stay_Group

-- Ensure the groups are displayed in a logical order based on the defined ranges
ORDER BY
    CASE
        WHEN Length_of_Stay_Group = '0-5' THEN 1
        WHEN Length_of_Stay_Group = '6-10' THEN 2
        WHEN Length_of_Stay_Group = '11-15' THEN 3
        WHEN Length_of_Stay_Group = '16-20' THEN 4
        WHEN Length_of_Stay_Group = '21-25' THEN 5
        WHEN Length_of_Stay_Group = '26-30' THEN 6
        ELSE 7 -- Assign the highest order to the '31+' group
    END;

-- Count the Number of patients in each hospital with percentages
SELECT
    Hospital,

    -- Count the number of patients associated with each hospital
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients for each hospital
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM
    healthcare

-- Group the results by the hospital name
GROUP BY
    Hospital

-- Sort the results in descending order of patient count for better readability
ORDER BY
    Patient_Count DESC;


-- Number of patients in each insurance provider with percentages
SELECT
    [Insurance Provider],

    -- Count the number of patients associated with each insurance provider
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients for each insurance provider
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM
    healthcare

-- Group the results by the insurance provider name
GROUP BY
    [Insurance Provider]

-- Sort the results in descending order of patient count for better readability
ORDER BY
    Patient_Count DESC;

--Count of patients in each billing amount category
SELECT
    -- Categorize billing amounts into predefined ranges
    CASE
        WHEN [Billing Amount] BETWEEN 0 AND 10000 THEN '0-10K'
        WHEN [Billing Amount] BETWEEN 10001 AND 20000 THEN '10K-20K'
        WHEN [Billing Amount] BETWEEN 20001 AND 30000 THEN '20K-30K'
        WHEN [Billing Amount] BETWEEN 30001 AND 40000 THEN '30K-40K'
        ELSE '40K+' -- Group any billing amount greater than 40,000 into '40K+'
    END AS Billing_Category,

    -- Count the number of patients in each category
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients in each billing category
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM healthcare

-- Group the results by the billing categories
GROUP BY Billing_Category

-- Sort the results for better readability
ORDER BY  Billing_Category;

-- Count of patients in each admission type category with percentages
SELECT
    -- Select the admission type
    [Admission Type],

    -- Count the number of patients in each admission type category
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients in each admission type category
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM
    -- Specify the table containing the healthcare data
    healthcare

-- Group the results by the admission type
GROUP BY
    [Admission Type]

-- Sort the results in descending order of patient count for better readability
ORDER BY
    Patient_Count DESC;

-- Count of patients for each medication with percentages
SELECT Medication,

    -- Count the number of patients for each medication
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients for each medication
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM
    -- Specify the table containing the healthcare data
    healthcare

-- Group the results by the medication
GROUP BY
    Medication

-- Sort the results in descending order of patient count for better readability
ORDER BY
    Patient_Count DESC;

-- Count of patients for each test result with percentages
SELECT [Test Results],

    -- Count the number of patients for each test result
    COUNT(*) AS Patient_Count,

    -- Calculate the percentage of patients for each test result
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM healthcare)) AS Percentage
FROM healthcare

-- Group the results by the test result
GROUP BY [Test Results]

-- Sort the results in descending order of patient count for better readability
ORDER BY
    Patient_Count DESC;


-- Select the columns "Medical Condition" and "Blood Type" for grouping
-- along with a calculated count of rows for each group.
SELECT
    "Medical Condition",  -- The medical condition of patients
    "Blood Type",         -- The blood type of patients
    COUNT(*) AS "Patient Count"  -- Count of patients for each combination of medical condition and blood type
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Medical Condition",  -- Group by medical condition to aggregate patient data
    "Blood Type"          -- Group by blood type to further refine aggregation
ORDER BY
    "Medical Condition",  -- Sort the results first by medical condition
    "Blood Type";         -- Then sort by blood type within each medical condition

-- Select the "Medical Condition" and calculate the average length of stay for patients.
SELECT
    "Medical Condition",  -- The medical condition of patients
    ROUND(JULIANDAY([Discharge Date]) - JULIANDAY([Date of Admission])) AS "Average Length of Stay"
    -- Calculate the difference in days between the discharge date and the admission date,
    -- then round the result to get the average length of stay (in whole days).
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Medical Condition"  -- Group data by medical condition to calculate the average length of stay per condition
ORDER BY
    "Average Length of Stay" DESC;  -- Sort results in descending order of average length of stay


-- Select the "Medical Condition" and calculate the average billing amount for each condition.
SELECT
    "Medical Condition",  -- The medical condition of patients
    AVG("Billing Amount") AS "Average Billing Amount"
    -- Calculate the average of the billing amount for each medical condition
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Medical Condition"  -- Group data by medical condition to calculate the average billing amount per condition
ORDER BY
    "Average Billing Amount" DESC;  -- Sort the results in descending order of the average billing amount

-- Count the number of occurrences for each combination of "Medical Condition" and "Admission Type".
SELECT
    "Medical Condition",  -- The medical condition of patients
    "Admission Type",     -- The type of admission (e.g., emergency, elective)
    COUNT(*) AS "Count"   -- The count of occurrences for each combination
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Medical Condition",  -- Group by medical condition
    "Admission Type"      -- Further group by admission type within each medical condition
ORDER BY
    "Medical Condition",  -- Sort the results by medical condition
    "Admission Type";     -- Then sort by admission type within each medical condition

-- Calculate the average billing amount for each type of admission.
SELECT
    "Admission Type",       -- The type of admission (e.g., emergency, elective)
    AVG("Billing Amount") AS "Average Billing Amount"
    -- Calculate the average of the billing amount for each admission type
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Admission Type"        -- Group data by admission type to calculate the average billing amount per type
ORDER BY
    "Average Billing Amount" DESC;  -- Sort the results in descending order of the average billing amount

-- Count the number of occurrences for each combination of "Insurance Provider" and "Medical Condition".
SELECT
    "Insurance Provider",  -- The insurance provider associated with the patient
    "Medical Condition",   -- The medical condition of the patient
    COUNT(*) AS "Count"    -- The count of occurrences for each combination
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Insurance Provider",  -- Group by insurance provider
    "Medical Condition"    -- Further group by medical condition within each insurance provider
ORDER BY
    "Insurance Provider",  -- Sort the results by insurance provider
    "Medical Condition";   -- Then sort by medical condition within each insurance provider

-- Calculate the average billing amount for each insurance provider.
SELECT
    "Insurance Provider",       -- The insurance provider associated with the patient
    AVG("Billing Amount") AS "Average Billing Amount"
    -- Calculate the average of the billing amount for each insurance provider
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Insurance Provider"        -- Group data by insurance provider to calculate the average billing amount
ORDER BY
    "Average Billing Amount" DESC;  -- Sort the results in descending order of the average billing amount

-- Count the number of occurrences for each combination of "Test Result" and "Admission Type".
SELECT
    "Test Results",         -- The result of the medical test
    "Admission Type",      -- The type of admission (e.g., emergency, elective)
    COUNT(*) AS "Count"    -- The count of occurrences for each combination
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Test Results",         -- Group by test result
    "Admission Type"       -- Further group by admission type within each test result
ORDER BY
    "Test Results",         -- Sort the results by test result
    "Admission Type";      -- Then sort by admission type within each test result

-- Calculate the average age for each medical condition.
SELECT
    "Medical Condition",       -- The medical condition of patients
    AVG("Age") AS "Average Age"
    -- Calculate the average age of patients for each medical condition
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Medical Condition"        -- Group data by medical condition to calculate the average age
ORDER BY
    "Average Age" DESC;        -- Sort the results in descending order of the average age

-- Calculate the average age for each test result.
SELECT
    "Test Results",             -- The result of the medical test
    AVG("Age") AS "Average Age"
    -- Calculate the average age of patients for each test result
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Test Results"              -- Group data by test result to calculate the average age
ORDER BY
    "Average Age" DESC;        -- Sort the results in descending order of the average age
-- Calculate the average age for each insurance provider.
SELECT
    "Insurance Provider",       -- The insurance provider associated with the patient
    AVG("Age") AS "Average Age"
    -- Calculate the average age of patients for each insurance provider
FROM
    healthcare  -- The table containing patient data
GROUP BY
    "Insurance Provider"        -- Group data by insurance provider to calculate the average age
ORDER BY
    "Average Age" DESC;         -- Sort the results in descending order of the average age

