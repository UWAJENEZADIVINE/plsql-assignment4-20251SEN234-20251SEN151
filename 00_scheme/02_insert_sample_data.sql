INSERT INTO student VALUES (20251, 'Uwajeneza Divine', 'uwajenezadivine608@gmail.com', 'ACTIVE');
INSERT INTO student VALUES (20252, 'Mugisha Eric', 'eric.mugisha@auca.ac.rw', 'ACTIVE');
INSERT INTO student VALUES (20253, 'Ineza Keza', 'ineza.keza@auca.ac.rw', 'ACTIVE');

INSERT INTO course VALUES ('INSY8311', 'Database Development with PL/SQL', 4);
INSERT INTO course VALUES ('PROG8121', 'Advanced Programming', 3);

INSERT INTO enrollment VALUES (101, 20251, 'INSY8311', 85.00, '2026-Q1');
INSERT INTO enrollment VALUES (102, 20252, 'PROG8121', 78.00, '2026-Q1');
INSERT INTO enrollment VALUES (103, 20253, 'INSY8311', 90.00, '2026-Q1');
COMMIT;