# Implementation and Performance Notes - Assignment IV

## 1. Records Implementation
- **User-Defined Records:** Implemented via `TYPE t_student_rec IS RECORD (...)` inside `register_student.sql`.
- **`%ROWTYPE` Records:** Utilized `enrollment%ROWTYPE` within the associative array in `batch_update_grades.sql`.

## 2. Collections Implementation
- **Associative Arrays:** Used in `batch_update_grades` (`INDEX BY PLS_INTEGER`).
- **Nested Tables:** Used in `calculate_gpa` via `t_grade_list` with dynamic `.EXTEND()` calls.

## 3. Cursors & Bulk Processing Performance
- **Implicit & Explicit Cursors:** Implemented across procedures and functions using attributes like `SQL%FOUND`, `SQL%ROWCOUNT`, and manual `OPEN`/`FETCH`/`CLOSE` control loops.
- **Bulk Processing:** `BULK COLLECT` and `FORALL` minimize context switching between the PL/SQL and SQL engines, optimizing efficiency, with `SAVE EXCEPTIONS` handling partial batch execution errors safely.