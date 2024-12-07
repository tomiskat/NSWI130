## Security

The system should be secure, with secure authentication and authorization protocols in place and sensitive data encrypted to protect against unauthorized access or attacks.

### Scenario

| Key                | Value                                                     |
|--------------------|-----------------------------------------------------------|
| Source of Stimulus | Student                                                   |
| Stimulus           | Trying to enroll subject without passed its prerequisites |
| Artifact           | Web application, Enrollment Manager [2 Containers]        |
| Environment        | Runtime                                                   |  
| Response           | Student request is denied                                 |
| Measure            | All similar requests are denied                           |

### Conclusion
❌

### Reason/Solution
Enrollment Processor component will call Prerequisites Validator component to check if student passed 
prerequisites. If not, it will deny student request.

![](embed:enrollmentManager_component_diagram)