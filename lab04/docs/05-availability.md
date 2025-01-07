## Availability

The degree to which the system is available to users when needed. This might include factors such as the reliability of the hardware and software components, the use of redundant or backup systems to ensure availability in the event of failures, and the use of load balancing and other techniques to ensure that the system can handle high levels of demand.

### Type
**Run-time**

### Authors
- Tadeáš Tomiška
- Adam Bruzl
- Stanislav Dochynets

### Scenario

| Key                | Value                                                     |
|--------------------|-----------------------------------------------------------|
| Source of Stimulus | Student                                                   |
| Stimulus           | Trying to enroll subject without passed its prerequisites |
| Artifact           | Web application, Enrollment Manager [2 Containers]        |
| Environment        | Runtime                                                   |  
| Response           | Student request is immediately denied                     |
| Measure            | Low latency                                               |

### Conclusion
❌

### Reason/Solution
Enrollment Processor component will call Prerequisites Validator component to check if student passed
prerequisites. If not, it will deny student request.

![](embed:enrollmentManager_component_diagram)