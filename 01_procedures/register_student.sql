CREATE OR REPLACE PROCEDURE register_student (
    p_student_id IN NUMBER,
    p_full_name  IN VARCHAR2,
    p_email      IN VARCHAR2
) AS
    TYPE t_student_rec IS RECORD (
        id     student.student_id%TYPE,
        name   student.full_name%TYPE,
        mail   student.email%TYPE
    );
    v_new_student t_student_rec;
    e_invalid_id EXCEPTION;
BEGIN
    IF p_student_id <= 0 THEN
        RAISE e_invalid_id;
    END IF;

    v_new_student.id := p_student_id;
    v_new_student.name := p_full_name;
    v_new_student.mail := p_email;

    INSERT INTO student (student_id, full_name, email, status)
    VALUES (v_new_student.id, v_new_student.name, v_new_student.mail, 'ACTIVE');

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Success: Inserted ' || SQL%ROWCOUNT || ' student row(s).');
    END IF;

    COMMIT;
EXCEPTION
    WHEN e_invalid_id THEN
        RAISE_APPLICATION_ERROR(-20001, 'Student ID must be greater than zero.');
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20002, 'Student email or ID already exists.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Unexpected error: ' || SQLERRM);
END register_student;
/