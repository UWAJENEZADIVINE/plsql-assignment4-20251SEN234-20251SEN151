SET SERVEROUTPUT ON;

BEGIN
    register_student(-10, 'Invalid Student', 'fail@auca.ac.rw');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
END;
/

DECLARE
    v_gpa NUMBER;
BEGIN
    v_gpa := calculate_gpa(88888);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Caught Expected Error: ' || SQLERRM);
END;
/