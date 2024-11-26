## Level 2: Container

**Work distribution:**

Initial image created collaboratively. The majority of the code work done by @Stanislav Dochynets.
Descriptions added by @Tadeáš Tomiška.
    
### Description
The Exams Manager System contains the following containers:

- **User Interface** - A web-based interface for users to interact with the system.
- **Exam Terms Manager** - Handles creation, modification, and retrieval of exam schedules.
- **Registration Manager** - Manages student exam registrations, including cancellations and queries.
- **Results Manager** - Processes and stores exam results and credit records.
- **Exam Terms Database** - Stores data related to exam terms.
- **Results Database** - Stores data related to exam results.

Each manager container integrates with a respective database and communicates with the SIS system for data synchronization.

![](embed:L2)