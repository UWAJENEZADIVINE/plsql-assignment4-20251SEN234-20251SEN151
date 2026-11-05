SET SERVEROUTPUT ON;

BEGIN
    register_student(20254, 'Murenzi Paul', 'paul.murenzi@auca.ac.rw');
    DBMS_OUTPUT.PUT_LINE('Test 1 Passed: Student registered.');
END;
/

BEGIN
    batch_update_grades;
    DBMS_OUTPUT.PUT_LINE('Test 2 Passed: Bulk updates completed.');
END;
/

DECLARE
    v_gpa NUMBER;
BEGIN
    v_gpa := calculate_gpa(20251);
    DBMS_OUTPUT.PUT_LINE('Test 3 Passed: Student 20251 GPA is ' || v_gpa);
END;
/