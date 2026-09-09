-- ============================================================================
-- MADA | مَدى
-- Oracle Database / Oracle APEX
-- المرحلة الثانية: إدخال بيانات تجريبية مترابطة للمعرض
--
-- شغّل هذا الملف بعد نجاح MADA_Oracle_Create_Tables.sql فقط.
-- لا يعيد إنشاء الجداول، ولا يحذف أي بيانات.
-- صُممت الأوامر لتتجاوز السجل إذا كان موجوداً مسبقاً.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1) الأقسام DEPARTMENT
-- ---------------------------------------------------------------------------
INSERT INTO department (department_name, department_code)
SELECT 'هندسة البرمجيات', 'SE' FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM department WHERE department_code = 'SE'
);

INSERT INTO department (department_name, department_code)
SELECT 'علوم الحاسوب', 'CS' FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM department WHERE department_code = 'CS'
);

INSERT INTO department (department_name, department_code)
SELECT 'الهندسة الطبية الحيوية', 'BME' FROM dual
WHERE NOT EXISTS (
    SELECT 1 FROM department WHERE department_code = 'BME'
);

-- ---------------------------------------------------------------------------
-- 2) المستخدمون USER_ACCOUNT
-- كلمات المرور أدناه قيم تجريبية لملء العمود فقط وليست لتسجيل الدخول في APEX.
-- ---------------------------------------------------------------------------
INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'مسؤول منصة مدى', 'ADM001', 'admin@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'ADMIN', d.department_id
FROM department d
WHERE d.department_code = 'SE'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'admin@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'د. أحمد القيسي', 'DOC001', 'ahmed@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'DOCTOR', d.department_id
FROM department d
WHERE d.department_code = 'SE'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'ahmed@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'د. مها العريقي', 'DOC002', 'maha@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'DOCTOR', d.department_id
FROM department d
WHERE d.department_code = 'BME'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'maha@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'سارة محمد', '2026001', 'sara@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'STUDENT', d.department_id
FROM department d
WHERE d.department_code = 'SE'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'sara@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'ليان أحمد', '2026002', 'layan@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'STUDENT', d.department_id
FROM department d
WHERE d.department_code = 'SE'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'layan@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'ريم علي', '2026003', 'reem@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'STUDENT', d.department_id
FROM department d
WHERE d.department_code = 'CS'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'reem@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'خالد صالح', '2026004', 'khaled@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'STUDENT', d.department_id
FROM department d
WHERE d.department_code = 'CS'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'khaled@mada.edu'
  );

INSERT INTO user_account
    (full_name, university_id, email, password_hash, role, department_id)
SELECT 'نور حسين', '2026005', 'noor@mada.edu',
       'DEMO_HASH_NOT_FOR_LOGIN', 'STUDENT', d.department_id
FROM department d
WHERE d.department_code = 'BME'
  AND NOT EXISTS (
      SELECT 1 FROM user_account WHERE email = 'noor@mada.edu'
  );

-- ---------------------------------------------------------------------------
-- 3) المقررات COURSE
-- ---------------------------------------------------------------------------
INSERT INTO course (course_code, course_name, department_id, credit_hours)
SELECT 'OOP201', 'Object-Oriented Programming', d.department_id, 3
FROM department d
WHERE d.department_code = 'SE'
  AND NOT EXISTS (
      SELECT 1 FROM course WHERE course_code = 'OOP201'
  );

INSERT INTO course (course_code, course_name, department_id, credit_hours)
SELECT 'DB202', 'Database Systems', d.department_id, 3
FROM department d
WHERE d.department_code = 'SE'
  AND NOT EXISTS (
      SELECT 1 FROM course WHERE course_code = 'DB202'
  );

INSERT INTO course (course_code, course_name, department_id, credit_hours)
SELECT 'GP401', 'Graduation Project', d.department_id, 4
FROM department d
WHERE d.department_code = 'BME'
  AND NOT EXISTS (
      SELECT 1 FROM course WHERE course_code = 'GP401'
  );

-- ---------------------------------------------------------------------------
-- 4) تكليفات التدريس COURSE_ASSIGNMENT
-- ---------------------------------------------------------------------------
INSERT INTO course_assignment (doctor_id, course_id, semester, academic_year)
SELECT u.user_id, c.course_id, 'FIRST', 2026
FROM user_account u
CROSS JOIN course c
WHERE u.email = 'ahmed@mada.edu'
  AND c.course_code = 'OOP201'
  AND NOT EXISTS (
      SELECT 1
      FROM course_assignment ca
      WHERE ca.doctor_id = u.user_id
        AND ca.course_id = c.course_id
        AND ca.semester = 'FIRST'
        AND ca.academic_year = 2026
  );

INSERT INTO course_assignment (doctor_id, course_id, semester, academic_year)
SELECT u.user_id, c.course_id, 'SECOND', 2025
FROM user_account u
CROSS JOIN course c
WHERE u.email = 'ahmed@mada.edu'
  AND c.course_code = 'DB202'
  AND NOT EXISTS (
      SELECT 1
      FROM course_assignment ca
      WHERE ca.doctor_id = u.user_id
        AND ca.course_id = c.course_id
        AND ca.semester = 'SECOND'
        AND ca.academic_year = 2025
  );

INSERT INTO course_assignment (doctor_id, course_id, semester, academic_year)
SELECT u.user_id, c.course_id, 'FIRST', 2026
FROM user_account u
CROSS JOIN course c
WHERE u.email = 'maha@mada.edu'
  AND c.course_code = 'GP401'
  AND NOT EXISTS (
      SELECT 1
      FROM course_assignment ca
      WHERE ca.doctor_id = u.user_id
        AND ca.course_id = c.course_id
        AND ca.semester = 'FIRST'
        AND ca.academic_year = 2026
  );

-- ---------------------------------------------------------------------------
-- 5) المشاريع PROJECT
-- ---------------------------------------------------------------------------
INSERT INTO project
    (title, summary, problem_statement, solution_description,
     project_type, academic_status, workflow_status, is_featured,
     nomination_reason, nominated_by, created_at, published_at)
SELECT 'MADA | مَدى',
       'منصة جامعية تحفظ أفضل المشاريع الطلابية وتعرض أثرها عبر السنوات.',
       'المشاريع المميزة تختفي غالباً بعد التسليم أو التخرج.',
       'أرشيف جامعي انتقائي يربط المشروع بفريقه وتقنياته وتطويراته المستقبلية.',
       'COURSE', 'COMPLETED', 'PUBLISHED', 1,
       'فكرة قابلة للتطبيق وتخدم طلاب الجامعة.',
       u.user_id, TIMESTAMP '2026-08-20 10:00:00',
       TIMESTAMP '2026-09-01 12:00:00'
FROM user_account u
WHERE u.email = 'ahmed@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project WHERE title = 'MADA | مَدى'
  );

INSERT INTO project
    (title, summary, problem_statement, solution_description,
     project_type, academic_status, workflow_status, is_featured,
     nomination_reason, nominated_by, created_at, published_at)
SELECT 'Smart Hospital',
       'نظام لإدارة المرضى والمواعيد والسجلات الطبية داخل المستشفى.',
       'تشتت بيانات المرضى وصعوبة متابعة المواعيد والسجلات.',
       'قاعدة بيانات مركزية وواجهات منظمة للعمليات اليومية.',
       'COURSE', 'COMPLETED', 'PUBLISHED', 1,
       'تكامل جيد بين قاعدة البيانات وتحليل احتياجات المستشفى.',
       u.user_id, TIMESTAMP '2025-04-10 09:00:00',
       TIMESTAMP '2025-06-15 11:00:00'
FROM user_account u
WHERE u.email = 'ahmed@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project WHERE title = 'Smart Hospital'
  );

INSERT INTO project
    (title, summary, problem_statement, solution_description,
     project_type, academic_status, workflow_status, is_featured,
     nomination_reason, nominated_by, created_at, published_at)
SELECT 'Smart Hospital Mobile',
       'تطوير محمول للمشروع الأصلي يتيح للمريض إدارة مواعيده.',
       'حاجة المرضى إلى الوصول للخدمات دون الحضور للمستشفى.',
       'تطبيق Flutter مرتبط بخدمات المستشفى وقاعدة بياناته.',
       'COURSE', 'IN_DEVELOPMENT', 'PUBLISHED', 0,
       'يمثل مثالاً واضحاً على استمرار أثر مشروع سابق.',
       u.user_id, TIMESTAMP '2026-02-12 09:30:00',
       TIMESTAMP '2026-07-05 13:00:00'
FROM user_account u
WHERE u.email = 'ahmed@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project WHERE title = 'Smart Hospital Mobile'
  );

INSERT INTO project
    (title, summary, problem_statement, solution_description,
     project_type, academic_status, workflow_status, is_featured,
     nomination_reason, nominated_by, created_at, published_at)
SELECT 'AI ECG Arrhythmia Detector',
       'نظام ذكاء اصطناعي يساعد في تصنيف اضطرابات نظم القلب من إشارات ECG.',
       'تحليل تسجيلات القلب الطويلة يستهلك وقتاً وقد تفوت بعض الحالات.',
       'نموذج تعلم عميق يصنف النبضات ويعرض النتائج للطبيب.',
       'GRADUATION', 'COMPLETED', 'PUBLISHED', 1,
       'مشروع متعدد التخصصات وله قيمة طبية وتقنية.',
       u.user_id, TIMESTAMP '2026-01-20 08:00:00',
       TIMESTAMP '2026-06-20 14:00:00'
FROM user_account u
WHERE u.email = 'maha@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project WHERE title = 'AI ECG Arrhythmia Detector'
  );

-- ---------------------------------------------------------------------------
-- 6) تفاصيل مشاريع المقررات COURSE_PROJECT_DETAILS
-- ---------------------------------------------------------------------------
INSERT INTO course_project_details (project_id, assignment_id)
SELECT p.project_id, ca.assignment_id
FROM project p
JOIN course_assignment ca ON ca.academic_year = 2026
JOIN course c ON c.course_id = ca.course_id AND c.course_code = 'OOP201'
JOIN user_account u ON u.user_id = ca.doctor_id AND u.email = 'ahmed@mada.edu'
WHERE p.title = 'MADA | مَدى'
  AND ca.semester = 'FIRST'
  AND NOT EXISTS (
      SELECT 1 FROM course_project_details d WHERE d.project_id = p.project_id
  );

INSERT INTO course_project_details (project_id, assignment_id)
SELECT p.project_id, ca.assignment_id
FROM project p
JOIN course_assignment ca ON ca.academic_year = 2025
JOIN course c ON c.course_id = ca.course_id AND c.course_code = 'DB202'
JOIN user_account u ON u.user_id = ca.doctor_id AND u.email = 'ahmed@mada.edu'
WHERE p.title = 'Smart Hospital'
  AND ca.semester = 'SECOND'
  AND NOT EXISTS (
      SELECT 1 FROM course_project_details d WHERE d.project_id = p.project_id
  );

INSERT INTO course_project_details (project_id, assignment_id)
SELECT p.project_id, ca.assignment_id
FROM project p
JOIN course_assignment ca ON ca.academic_year = 2026
JOIN course c ON c.course_id = ca.course_id AND c.course_code = 'OOP201'
JOIN user_account u ON u.user_id = ca.doctor_id AND u.email = 'ahmed@mada.edu'
WHERE p.title = 'Smart Hospital Mobile'
  AND ca.semester = 'FIRST'
  AND NOT EXISTS (
      SELECT 1 FROM course_project_details d WHERE d.project_id = p.project_id
  );

-- ---------------------------------------------------------------------------
-- 7) تفاصيل مشروع التخرج GRADUATION_PROJECT_DETAILS
-- ---------------------------------------------------------------------------
INSERT INTO graduation_project_details
    (project_id, supervisor_id, graduation_year, project_stage, defense_date)
SELECT p.project_id, u.user_id, 2026, 'DEFENDED', DATE '2026-06-15'
FROM project p
CROSS JOIN user_account u
WHERE p.title = 'AI ECG Arrhythmia Detector'
  AND u.email = 'maha@mada.edu'
  AND NOT EXISTS (
      SELECT 1
      FROM graduation_project_details d
      WHERE d.project_id = p.project_id
  );

-- ---------------------------------------------------------------------------
-- 8) أعضاء المشاريع PROJECT_MEMBER
-- ---------------------------------------------------------------------------
INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Team Lead', 'تحليل النظام وتصميم قاعدة البيانات'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'MADA | مَدى' AND u.email = 'sara@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Developer', 'تصميم واجهات Oracle APEX'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'MADA | مَدى' AND u.email = 'layan@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Documentation', 'كتابة المحتوى وتجهيز العرض'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'MADA | مَدى' AND u.email = 'reem@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Database Developer', 'تصميم قاعدة بيانات المستشفى'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital' AND u.email = 'khaled@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Java Developer', 'برمجة وظائف النظام الأساسية'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital' AND u.email = 'layan@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Mobile Developer', 'تطوير تطبيق Flutter'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital Mobile' AND u.email = 'reem@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Backend Developer', 'ربط التطبيق بخدمات البيانات'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital Mobile' AND u.email = 'khaled@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'AI Developer', 'تدريب نموذج تصنيف إشارات القلب'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'AI ECG Arrhythmia Detector' AND u.email = 'noor@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

INSERT INTO project_member
    (project_id, student_id, member_role, contribution_description)
SELECT p.project_id, u.user_id, 'Data Analyst', 'معالجة البيانات وتقييم النموذج'
FROM project p CROSS JOIN user_account u
WHERE p.title = 'AI ECG Arrhythmia Detector' AND u.email = 'sara@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_member pm
      WHERE pm.project_id = p.project_id AND pm.student_id = u.user_id
  );

-- ---------------------------------------------------------------------------
-- 9) التقنيات TECHNOLOGY
-- ---------------------------------------------------------------------------
INSERT INTO technology (technology_name, category)
SELECT 'Java', 'Programming Language' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'Java');

INSERT INTO technology (technology_name, category)
SELECT 'Oracle Database', 'Database' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'Oracle Database');

INSERT INTO technology (technology_name, category)
SELECT 'Oracle APEX', 'Low-Code Platform' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'Oracle APEX');

INSERT INTO technology (technology_name, category)
SELECT 'Python', 'Programming Language' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'Python');

INSERT INTO technology (technology_name, category)
SELECT 'TensorFlow', 'Artificial Intelligence' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'TensorFlow');

INSERT INTO technology (technology_name, category)
SELECT 'Flutter', 'Mobile Development' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'Flutter');

INSERT INTO technology (technology_name, category)
SELECT 'Firebase', 'Cloud Backend' FROM dual
WHERE NOT EXISTS (SELECT 1 FROM technology WHERE technology_name = 'Firebase');

-- ---------------------------------------------------------------------------
-- 10) تقنيات كل مشروع PROJECT_TECHNOLOGY
-- ---------------------------------------------------------------------------
INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'قاعدة البيانات الأساسية للمنصة'
FROM project p CROSS JOIN technology t
WHERE p.title = 'MADA | مَدى' AND t.technology_name = 'Oracle Database'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'بناء واجهات نسخة المعرض'
FROM project p CROSS JOIN technology t
WHERE p.title = 'MADA | مَدى' AND t.technology_name = 'Oracle APEX'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'برمجة النظام المكتبي'
FROM project p CROSS JOIN technology t
WHERE p.title = 'Smart Hospital' AND t.technology_name = 'Java'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'تخزين سجلات المستشفى'
FROM project p CROSS JOIN technology t
WHERE p.title = 'Smart Hospital' AND t.technology_name = 'Oracle Database'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'واجهة تطبيق الهاتف'
FROM project p CROSS JOIN technology t
WHERE p.title = 'Smart Hospital Mobile' AND t.technology_name = 'Flutter'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'خدمات التطبيق السحابية'
FROM project p CROSS JOIN technology t
WHERE p.title = 'Smart Hospital Mobile' AND t.technology_name = 'Firebase'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'معالجة إشارات ECG والبيانات'
FROM project p CROSS JOIN technology t
WHERE p.title = 'AI ECG Arrhythmia Detector' AND t.technology_name = 'Python'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

INSERT INTO project_technology (project_id, technology_id, usage_note)
SELECT p.project_id, t.technology_id, 'بناء نموذج التصنيف العميق'
FROM project p CROSS JOIN technology t
WHERE p.title = 'AI ECG Arrhythmia Detector' AND t.technology_name = 'TensorFlow'
  AND NOT EXISTS (
      SELECT 1 FROM project_technology pt
      WHERE pt.project_id = p.project_id AND pt.technology_id = t.technology_id
  );

-- ---------------------------------------------------------------------------
-- 11) الملفات والروابط PROJECT_FILE
-- الروابط تجريبية ويمكن استبدالها لاحقاً بروابط المشروع الحقيقية.
-- ---------------------------------------------------------------------------
INSERT INTO project_file
    (project_id, uploaded_by, file_name, file_type, file_url,
     access_level, file_size_kb)
SELECT p.project_id, u.user_id, 'MADA_Project_Report.pdf', 'REPORT',
       'https://example.com/mada-report.pdf', 'PUBLIC', 2450
FROM project p CROSS JOIN user_account u
WHERE p.title = 'MADA | مَدى' AND u.email = 'sara@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_file f
      WHERE f.project_id = p.project_id AND f.file_name = 'MADA_Project_Report.pdf'
  );

INSERT INTO project_file
    (project_id, uploaded_by, file_name, file_type, file_url,
     access_level, file_size_kb)
SELECT p.project_id, u.user_id, 'Smart_Hospital_Demo', 'DEMO_LINK',
       'https://example.com/smart-hospital', 'PUBLIC', NULL
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital' AND u.email = 'khaled@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_file f
      WHERE f.project_id = p.project_id AND f.file_name = 'Smart_Hospital_Demo'
  );

INSERT INTO project_file
    (project_id, uploaded_by, file_name, file_type, file_url,
     access_level, file_size_kb)
SELECT p.project_id, u.user_id, 'Mobile_App_Screens', 'IMAGE_LINK',
       'https://example.com/smart-hospital-mobile', 'PUBLIC', NULL
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital Mobile' AND u.email = 'reem@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_file f
      WHERE f.project_id = p.project_id AND f.file_name = 'Mobile_App_Screens'
  );

INSERT INTO project_file
    (project_id, uploaded_by, file_name, file_type, file_url,
     access_level, file_size_kb)
SELECT p.project_id, u.user_id, 'ECG_AI_Research.pdf', 'REPORT',
       'https://example.com/ecg-ai-report.pdf', 'PUBLIC', 3860
FROM project p CROSS JOIN user_account u
WHERE p.title = 'AI ECG Arrhythmia Detector' AND u.email = 'noor@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM project_file f
      WHERE f.project_id = p.project_id AND f.file_name = 'ECG_AI_Research.pdf'
  );

-- ---------------------------------------------------------------------------
-- 12) جوازات المشاريع PROJECT_PASSPORT
-- ---------------------------------------------------------------------------
INSERT INTO project_passport
    (project_id, working_features, incomplete_parts,
     source_code_availability, accepts_continuation, future_ideas)
SELECT p.project_id,
       'عرض المشاريع والفريق والتقنيات وجواز المشروع.',
       'رفع الملفات الحقيقي ونظام التنبيهات مؤجلان.',
       'ON_REQUEST', 1,
       'إضافة بحث ذكي وتوصية بمشاريع مشابهة.'
FROM project p
WHERE p.title = 'MADA | مَدى'
  AND NOT EXISTS (
      SELECT 1 FROM project_passport pp WHERE pp.project_id = p.project_id
  );

INSERT INTO project_passport
    (project_id, working_features, incomplete_parts,
     source_code_availability, accepts_continuation, future_ideas)
SELECT p.project_id,
       'إدارة المرضى والمواعيد والسجلات والتقارير.',
       'لا توجد نسخة هاتف في الإصدار الأصلي.',
       'ON_REQUEST', 1,
       'ربطه بتطبيق هاتف ولوحة تحليلات.'
FROM project p
WHERE p.title = 'Smart Hospital'
  AND NOT EXISTS (
      SELECT 1 FROM project_passport pp WHERE pp.project_id = p.project_id
  );

INSERT INTO project_passport
    (project_id, working_features, incomplete_parts,
     source_code_availability, accepts_continuation, future_ideas)
SELECT p.project_id,
       'تسجيل المريض واستعراض المواعيد والتنبيهات الأولية.',
       'الدفع الإلكتروني والاستشارة المرئية قيد التطوير.',
       'PRIVATE', 1,
       'إضافة استشارات عن بعد وربط الأجهزة القابلة للارتداء.'
FROM project p
WHERE p.title = 'Smart Hospital Mobile'
  AND NOT EXISTS (
      SELECT 1 FROM project_passport pp WHERE pp.project_id = p.project_id
  );

INSERT INTO project_passport
    (project_id, working_features, incomplete_parts,
     source_code_availability, accepts_continuation, future_ideas)
SELECT p.project_id,
       'معالجة الإشارة وتصنيف النبضات وعرض المقاييس.',
       'يحتاج إلى اختبار سريري خارجي قبل الاستخدام الطبي.',
       'ON_REQUEST', 1,
       'إضافة بيانات خارجية وتفسير قرارات النموذج للطبيب.'
FROM project p
WHERE p.title = 'AI ECG Arrhythmia Detector'
  AND NOT EXISTS (
      SELECT 1 FROM project_passport pp WHERE pp.project_id = p.project_id
  );

-- ---------------------------------------------------------------------------
-- 13) المراجعات REVIEW
-- ---------------------------------------------------------------------------
INSERT INTO review
    (project_id, reviewer_id, review_decision, comments, review_date, round_number)
SELECT p.project_id, u.user_id, 'APPROVED',
       'التوثيق واضح والفكرة مناسبة للعرض والنشر.',
       TIMESTAMP '2026-09-01 11:00:00', 1
FROM project p CROSS JOIN user_account u
WHERE p.title = 'MADA | مَدى' AND u.email = 'ahmed@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM review r
      WHERE r.project_id = p.project_id
        AND r.reviewer_id = u.user_id
        AND r.round_number = 1
  );

INSERT INTO review
    (project_id, reviewer_id, review_decision, comments, review_date, round_number)
SELECT p.project_id, u.user_id, 'APPROVED',
       'مشروع متكامل ويستحق الحفظ في المنصة.',
       TIMESTAMP '2025-06-14 10:00:00', 1
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital' AND u.email = 'ahmed@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM review r
      WHERE r.project_id = p.project_id
        AND r.reviewer_id = u.user_id
        AND r.round_number = 1
  );

INSERT INTO review
    (project_id, reviewer_id, review_decision, comments, review_date, round_number)
SELECT p.project_id, u.user_id, 'APPROVED',
       'تطوير جيد يوضح كيف يمتد أثر المشروع الأصلي.',
       TIMESTAMP '2026-07-04 12:00:00', 1
FROM project p CROSS JOIN user_account u
WHERE p.title = 'Smart Hospital Mobile' AND u.email = 'ahmed@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM review r
      WHERE r.project_id = p.project_id
        AND r.reviewer_id = u.user_id
        AND r.round_number = 1
  );

INSERT INTO review
    (project_id, reviewer_id, review_decision, comments, review_date, round_number)
SELECT p.project_id, u.user_id, 'APPROVED',
       'نتائج المشروع واعدة مع ضرورة توضيح أنه نموذج بحثي.',
       TIMESTAMP '2026-06-19 13:00:00', 1
FROM project p CROSS JOIN user_account u
WHERE p.title = 'AI ECG Arrhythmia Detector' AND u.email = 'maha@mada.edu'
  AND NOT EXISTS (
      SELECT 1 FROM review r
      WHERE r.project_id = p.project_id
        AND r.reviewer_id = u.user_id
        AND r.round_number = 1
  );

-- ---------------------------------------------------------------------------
-- 14) علاقة المشروع الأصلي بالتطوير PROJECT_RELATION
-- ---------------------------------------------------------------------------
INSERT INTO project_relation
    (parent_project_id, child_project_id, relation_type, relation_description)
SELECT parent_p.project_id, child_p.project_id, 'EXTENDS',
       'تطبيق الهاتف تطوير مباشر لنظام Smart Hospital الأصلي.'
FROM project parent_p
CROSS JOIN project child_p
WHERE parent_p.title = 'Smart Hospital'
  AND child_p.title = 'Smart Hospital Mobile'
  AND NOT EXISTS (
      SELECT 1 FROM project_relation pr
      WHERE pr.parent_project_id = parent_p.project_id
        AND pr.child_project_id = child_p.project_id
        AND pr.relation_type = 'EXTENDS'
  );

COMMIT;

-- ---------------------------------------------------------------------------
-- التحقق الأول: عدد السجلات في كل جدول بعد التنفيذ
-- ---------------------------------------------------------------------------
SELECT 'DEPARTMENT' AS table_name, COUNT(*) AS row_count FROM department
UNION ALL SELECT 'USER_ACCOUNT', COUNT(*) FROM user_account
UNION ALL SELECT 'COURSE', COUNT(*) FROM course
UNION ALL SELECT 'COURSE_ASSIGNMENT', COUNT(*) FROM course_assignment
UNION ALL SELECT 'PROJECT', COUNT(*) FROM project
UNION ALL SELECT 'COURSE_PROJECT_DETAILS', COUNT(*) FROM course_project_details
UNION ALL SELECT 'GRADUATION_PROJECT_DETAILS', COUNT(*) FROM graduation_project_details
UNION ALL SELECT 'PROJECT_MEMBER', COUNT(*) FROM project_member
UNION ALL SELECT 'TECHNOLOGY', COUNT(*) FROM technology
UNION ALL SELECT 'PROJECT_TECHNOLOGY', COUNT(*) FROM project_technology
UNION ALL SELECT 'PROJECT_FILE', COUNT(*) FROM project_file
UNION ALL SELECT 'PROJECT_PASSPORT', COUNT(*) FROM project_passport
UNION ALL SELECT 'REVIEW', COUNT(*) FROM review
UNION ALL SELECT 'PROJECT_RELATION', COUNT(*) FROM project_relation
ORDER BY table_name;

-- التحقق الثاني: ملخص المشاريع الذي يمكن استخدامه لاحقاً في صفحة APEX
SELECT
    p.project_id,
    p.title,
    p.project_type,
    p.academic_status,
    p.workflow_status,
    p.is_featured,
    NVL(m.team_members, 0) AS team_members,
    tech.technologies
FROM project p
LEFT JOIN (
    SELECT project_id, COUNT(*) AS team_members
    FROM project_member
    GROUP BY project_id
) m ON m.project_id = p.project_id
LEFT JOIN (
    SELECT pt.project_id,
           LISTAGG(t.technology_name, ', ')
               WITHIN GROUP (ORDER BY t.technology_name) AS technologies
    FROM project_technology pt
    JOIN technology t ON t.technology_id = pt.technology_id
    GROUP BY pt.project_id
) tech ON tech.project_id = p.project_id
ORDER BY p.is_featured DESC, p.title;

-- النهاية: أصبحت قاعدة البيانات جاهزة لبناء صفحات Oracle APEX الأساسية.
