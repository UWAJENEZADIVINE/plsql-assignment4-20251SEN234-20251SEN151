CREATE OR REPLACE PROCEDURE batch_update_grades AS
    TYPE t_enrollment_list IS TABLE OF enrollment%ROWTYPE INDEX BY PLS_INTEGER;
    v_enrollments t_enrollment_list;

    bulk_errors EXCEPTION;
    PRAGMA EXCEPTION_INIT(bulk_errors, -24381);
BEGIN
    SELECT enrollment_id, student_id, course_code, grade, semester
    BULK COLLECT INTO v_enrollments
    FROM enrollment;

    IF v_enrollments.COUNT > 0 THEN
        FOR i in v_enrollments.FIRST .. v_enrollments.LAST LOOP
            IF v_enrollments(i).grade <= 98 THEN
                v_enrollments(i).grade := v_enrollments(i).grade + 2;
            END IF;
        END LOOP;
    END IF;

    BEGIN
        FORALL i in 1..v_enrollments.COUNT SAVE EXCEPTIONS
            UPDATE enrollment
            SET grade = v_enrollments(i).grade
            WHERE enrollment_id = v_enrollments(i).enrollment_id;
    EXCEPTION
        WHEN bulk_errors THEN
            FOR idx in 1..SQL%BULK_EXCEPTIONS.COUNT LOOP
                DBMS_OUTPUT.PUT_LINE('Error index: ' || SQL%BULK_EXCEPTIONS(idx).ERROR_INDEX);
            END LOOP;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Batch grade update completed using bulk processing.');
END batch_update_grades;
/