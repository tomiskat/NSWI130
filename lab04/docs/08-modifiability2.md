## Modifiability 2

The degree to which the system can be modified or changed without affecting its overall functionality.
This might include factors such as the modularity and flexibility of the design, the use of industry-standard 
technologies and practices, and the availability of documentation and other resources to support changes.

### Scenario

| Key                | Value                                      |
|--------------------|--------------------------------------------|
| Source of Stimulus | Study department                           |
| Stimulus           | Add prerequisite to subject                |
| Artifact           | Enrollment Database [Container]            |
| Environment        | Runtime (subjects enrollment is disabled)  |
| Response           | Subject prerequisite is successfully added |
| Measure            | Change affects only 1 container            |

### Conclusion
✅

### Reason/Solution
Changing prerequisite requires change only in Enrollment Database container
