## Availability

The degree to which the system is available to users when needed. This might include factors such as the reliability of the hardware and software components, the use of redundant or backup systems to ensure availability in the event of failures, and the use of load balancing and other techniques to ensure that the system can handle high levels of demand.

### Scenario

| Key                | Value                                                                   |
|--------------------|-------------------------------------------------------------------------|
| Source of Stimulus | Student                                                                 |
| Stimulus           | First phase of enrolling subject - student want to see subjects         |
| Artifact           | Web Application, Enrollment Manager, Enrollment Database [3 Containers] |
| Environment        | High workload (Start of semester, all students want to enroll subjects) |
| Response           | Subjects are displayed to user                                          |
| Measure            | low latency                                                             |

### Conclusion
⚠️

### Reason/Solution
System uses same database to store enrollments data and subjects data. Dividing database into 2 databases with
subjects and enrollments would reduce number of operations in each database to half.

![](embed:StudentEnrollmentProcess)