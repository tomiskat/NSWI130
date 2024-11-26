## Dynamic

**Work distribution:**

Created by @Adam Bruzl

### Exam Term Creation
The user interface sends a request to create a new exam term. This request is routed to the term creation handler,
which validates the input. Once validated, the system checks for conflicts with existing schedules, and if valid, 
writes the new exam term to the database. The response, either success or error, is sent back to the user interface.
![](embed:examTermCreation)

### Exam Term Retrieval
The user interface requests a list of exam terms that the user is enrolled in. This request is routed to the term 
retrieval handler, which queries the exam terms database and retrieves the relevant data. The handler then sends
the data back to the user interface for display.
![](embed:examTermRetrieval)

### Exam Term Registration
The user interface sends a request to view available exam terms, which is routed to the registration query handler.
After the handler retrieves the data from the database, it displays the available terms. Once the user selects a 
term, the registration request processor routes the registration data to the registration handler. The handler 
validates the data, writes it to the database, and returns a response (success or error) to the user interface.
![](embed:examTermRegistration)

### Exam Results Writing
The user interface sends a request to write exam results to the system. The results processor routes this to the
result writer, which validates the data before writing it to the results database. Upon successful validation and 
writing, the system sends a response back to the user interface indicating success or failure.
![](embed:examResultsWriting)

### Exam Results Reading
The user interface requests to view the exam results. The request is sent to the results processor, which routes
it to the result reader. The reader queries the results database for the requested data and returns the exam results
to the results processor, which then displays them on the user interface.
![](embed:examResultsReading)

