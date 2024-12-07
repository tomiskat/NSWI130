## Testability

The system should be easy to test for correctness and performance, with automated testing tools and practices in place and a testable design that allows for thorough testing.

### Scenario

| Key                | Value                                                    |
|--------------------|----------------------------------------------------------|
| Source of Stimulus | Developer                                                |
| Stimulus           | Get statistical request for test data                    |
| Artifact           | Statistics Log Database [Container]                      |
| Environment        | System testing                                           |
| Response           | Component will store data, create report and delete data |
| Measure            | Only 1 container is affected                             |

### Conclusion
✅ 

### Reason/Solution
Testing will use only 1 container