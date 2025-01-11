## Modifiability

The degree to which the system can be modified or changed without affecting its overall functionality.
This might include factors such as the modularity and flexibility of the design, the use of industry-standard 
technologies and practices, and the availability of documentation and other resources to support changes.

### Type
**Design-time**

### Authors
- Tadeáš Tomiška
- Adam Bruzl
- Stanislav Dochynets

### Scenario

| Key                | Value                                                                    |
|--------------------|--------------------------------------------------------------------------|
| Source of Stimulus | Study department                                                         |
| Stimulus           | Add new subject enrollment rule (etc. limit number of enrolled subjects) |
| Artifact           | Enrollment Manager [Container]                                           |
| Environment        | Runtime                                                                  |
| Response           | Rule successfully added                                                  |
| Measure            | Change affects only 1 container                                          |

### Conclusion
✅

### Reason/Solution
Modifying subject enrollment rule requires change only in Enrollment Manager container

