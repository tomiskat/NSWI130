# EXAMS2 - lab02

## CORE

### Feature: Exam managment
As a teacher, I want to create and manage exams and everything regarding them so that I can conduct exams at suitable times, locations, etc.

**Feature breakdown:**
1. Teacher opens "Exams" tab on main page.
1. Selects "New exam" option, which opens page for creating new exam.
1. Select viable exam parameters (subject, date, time, capacity, room).
1. Selects "Create new exam term".
1. System creates new exam.
1. If action was unsuccessfull, system displays an error message and returns teacher to step 3.
    
**Responsibilities:**

##### **Data Input Responsibilities**
- Provide a user-friendly form to input exam details (subject, date, capacity, room).
- Ensure input parameters are valid

##### **Data Processing Responsibilities**
- After validation, the system stores the new exam term in the database. (If there is some problem (e.g., room is unavailable, time conflicts, etc.), the system should provide descriptive error messages and allow teachers to correct input without re-entering everything


##### **Data Display Responsibilities**
- After creation, show the new exam in the exam list under the "Exams" tab for future management.
- Allow real-time updates if exam parameters (date, room, etc.) are changed or canceled later.


##### **Permissions and Security Responsibilities**
- Only authorized users (teachers) can create or manage exams.
- Ensure that only the teacher who created the exam can modify or delete it, unless overridden by an administrator.

---

### Feature: Registering for exam terms
As a student, I want to register for exam terms so that I can secure my spot for the exam at a convenient time.

**Feature breakdown:**
1. Student opens "Exams" tab on main page.
1. Student views available exam terms.
1. Student registers for a chosen term.
1. System confirms registration and reserves a spot for the student.
1. If action was unsuccessful, system displays an error message.

**Responsibilities:**

##### **Data Input Responsibilities**
- Present the available exam terms in a clear format, with key details such as subject, date, time, room, and remaining capacity.
- Verify that the student is eligible to register for the chosen exam (e.g., student is enrolled in the course, has met prerequisites, and has not already registered for another exam for that subject).
- Ensure there is still room in the selected exam term by verifying the available spots before allowing registration.
- Ensure that the selected exam time does not conflict with other registered exams or course schedules of the student.

##### **Data Processing Responsibilities**
- Once eligibility is confirmed, update the database to register the student for the selected exam term and decrement the available spot count for that exam.
- Prevent students from registering for multiple terms of the same exam or exams that conflict in time.

##### **Data Display Responsibilities**
- Display a confirmation message to the student that they have successfully registered, including details of the exam (e.g., date, time, room).
- As students register, the system should update the number of available spots for each exam term dynamically.
- If registration fails (e.g., due to capacity issues, schedule conflicts, or eligibility), provide a clear and actionable error message explaining the reason for failure.

##### **Permissions and Security Responsibilities**
- Ensure only authenticated and authorized students can view and register for exam terms.

---

### Feature: Awarding credits/grades
As a teacher, I want to award students their credits/grades after they have successfully passed the exam so that they can progress in their studies.

**Feature breakdown:**
1. Teacher opens "Exams" tab on main page.
1. Teacher views a list of managed exam terms.
1. Selects "Award grades/credits" button assigned to desired exam term.
1. Views a spreadsheet of registered students.
1. Awards grades to the students.
1. Presses "Save" button.
1. System validates grade values.
1. If values are valid, system saves them, otherwise returns teacher to step 5. 
1. System records the credits/grades for each student in their academic profile.

**Responsibilities:**

##### **Data Input Responsibilities**
- Provide a user-friendly interface (e.g., a spreadsheet format) where the teacher can input or update grades/credits for each student registered for the exam term.
- Ensure that entered grades/credits are within valid ranges (e.g., grades from 0 to 100 or predefined letter grades), and that input is correctly formatted (e.g., no missing or invalid entries).
- If invalid values are detected (e.g., grades out of range), the system should highlight the invalid fields and prompt the teacher to correct them before saving.

##### **Data Processing Responsibilities**
- Once all grades are validated, the system updates the database with the new grades/credits for each student

##### **Data Display Responsibilities**
- Provide an organized view of all students registered for the exam term, allowing teachers to easily see and update grades for each student.
- Once grades are successfully saved, the system should display a confirmation message. If saving fails (e.g., due to validation issues), the system should display a detailed error message and return the teacher to the input stage (step 5).

#### **Permissions and Security Responsibilities**
- Ensure that only authorized teachers can access the "Award grades/credits" feature and view/edit grades for the exams they manage.


---

### Feature: Viewing results
As a student or teacher, I want to view the exam results so that I can track academic performance or verify grading.

**Feature breakdown:**
1. The user navigates to the "Exams" tab on the main page and selects "View Results"
1. Student selects a specific course or exam term to view results, while a teacher selects a term to view grades they have submitted
1. The system retrieves the exam results for the selected course/term.
1. The system displays the results: students see their grades, teachers see the list of students and their grades.
1. If results are unavailable, the system displays an error message.

**Responsibilities:**

##### **Data retrieval responsibilities**
- Query the database for the exam results.
- Verify the correctness of the query result (The student can only see their own results)
- Update the results in real-time if grades change.

#### **Data display responsibilities**
- Show results in a clear table format.
- Offer filters (by exam date or subject) for teachers and students.
- Ensure grades, credits, and student names are properly formatted.

---

## OPTIONAL

### Feature: Communication with registered students
As a teacher or student, I want to communicate regarding the exam, so that I can ask questions or provide necessary information.

---

### Feature: Statistical reports and history
As a manager or teacher, I want to generate statistical reports based on historical data, so that I can evaluate performance trends over time.

---
### Feature: Automatic notification
As a student, I want to be automatically notified about changes regarding my exams, so that I have the current information.

---
### Feature: Cancelling all exam terms on a given day
As a faculty board, we want to be able to cancel all exam terms scheduled on a specific day, so that we can quickly respond to unexpected events, such as floods or school shootings.
