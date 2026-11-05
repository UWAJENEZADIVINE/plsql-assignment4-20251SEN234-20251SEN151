CREATE OR REPLACE FUNCTION calculate_gpa (
    p_student_id IN NUMBER
) RETURN NUMBER IS
    TYPE t_grade_list IS TABLE OF NUMBER;
    v_grades t_grade_list := t_grade_list();

    CURSOR c_grades IS
        SELECT grade FROM enrollment WHERE student_id = p_student_id;

    v_total NUMBER := 0;
    v_temp_grade NUMBER;
    v_dummy NUMBER;
BEGIN
    BEGIN
        SELECT 1 INTO v_dummy FROM student WHERE student_id = p_student_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'Student ID ' || p_student_id || ' does not exist.');
    END;

    OPEN c_grades;
    LOOP
        FETCH c_grades INTO v_temp_grade;
        EXIT WHEN c_grades%NOTFOUND;
        v_grades.EXTEND;
        v_grades(v_grades.LAST) := v_temp_grade;
    END LOOP;
    CLOSE c_grades;

    IF v_grades.COUNT = 0 THEN
        RETURN 0;
    END IF;

    FOR i IN 1 .. v_grades.COUNT LOOP
        v_total := v_total + v_grades(i);
    END LOOP;

    RETURN ROUND(v_total / v_grades.COUNT, 2);
END calculate_gpa;
/