## Features

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

##### **Exam Creation and Management Responsibilities**
- Provide a user-friendly form for inputting exam details (subject, date, capacity, room).
- Store the new exam term in the database after validation, or descriptive error messages for any issues (e.g., room unavailability).
- Allow teachers to correct invalid inputs without re-entering everything
- Show the new exam in the exam list under the "Exams" tab for future management.

##### **Permissions and Security Responsibilities**
- Allow only authorized users (teachers) to create or manage exams.
- Ensure that only the teacher who created the exam can modify or delete it, unless overridden by an administrator.

**Components Involved**:
  - Term Request Processor
  - Term Creation Handler
  - Validation Handler1
  - Database Connector
  - SIS Integration Adapter

**Database Interaction**: Direct interaction with `ExamTermsDB` for storing and retrieving exam term data.

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

##### **Exam Registration Management Responsibilities**
- Ensure there are available spots in the selected exam term.
- Update the database to register the student for the selected exam term and decrement the available spot count.
- Prevent students from registering for multiple terms of the same exam or conflicting exams.

##### **User Feedback and Security Responsibilities**
- Display a confirmation message upon successful registration or an error message if registration fails.
- Dynamically update the number of available spots for each exam term as students register.
- Ensure that only authenticated and authorized students can view and register for exam terms.

**Components Involved**:
  - Registration Request Processor
  - Registration Handler
  - Registration Query Handler
  - Validation HandlerReg
  - Database ConnectorReg
  - SIS Integration AdapterReg

**Database Interaction**: Utilizes `ExamTermsDB` to manage registration data.


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

##### **Data Management Responsibilities**
- Provide a user-friendly interface for teachers to input or update grades/credits for students registered for the exam term.
- Validate entered grades/credits to ensure they are within valid ranges.
- Update the database with validated grades/credits for each student once all entries are confirmed.

##### **User Interaction Responsibilities**
- Display an organized view of registered students, allowing teachers to easily update grades.
- Provide confirmation messages upon successful saving of grades or detailed error messages if saving fails.
- Ensure that only authorized teachers can access the grade/credit awarding feature.

**Components Involved**:
  - Results Processor
  - Result Writer
  - Validation HandlerForResults
  - Database ConnectorResult
  - SIS Integration AdapterResult

**Database Interaction**: Interacts with `ResultsDB` for storing and retrieving grade data.

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

##### **Data display responsibilities**
- Show results in a clear table format.
- Offer filters (by exam date or subject) for teachers and students.
- Ensure grades, credits, and student names are properly formatted.

**Components Involved**:
  - Result Reader
  - Database ConnectorResult

**Database Interaction**: Queries `ResultsDB` to fetch and display results.

---

### Feature: Viewing Exams Student is Enrolled

As a student, I want to view the exams I am enrolled in so that I can track my upcoming exams and their details.

**Feature Breakdown:**
1. Student navigates to the "Exams" tab on the main page.
1. Student selects the "My Enrolled Exams" option.
1. Student retrieves the list of exams the student is currently enrolled in.
1. The student clicks on any exam entry to view more detailed information.
1. The system displays further details such as instructor’s contact information, exam format or room number

**Responsibilities:**

##### **Data Input Responsibilities**
- The student interacts with a clear navigation to access the "My Enrolled Exams" feature.
- Accurately retrieve the list of exams the student is enrolled in, based on the student’s ID or profile information.

##### **Data Processing Responsibilities**
- The system queries the database to retrieve all exams the student is registered for, filtering by their student ID.
- Ensure that only exams where the student is successfully enrolled are shown.
- Ensure the list is updated in real-time, reflecting any changes such as cancellations, rescheduled exams, or new enrollments.

**Components Involved**:
  - Registration Query Handler
  - Database ConnectorReg

**Database Interaction**: Retrieves data from `ExamTermsDB` related to student registrations.

