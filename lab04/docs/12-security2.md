## Security 2

The system should be secure, with secure authentication and authorization protocols in place and sensitive data encrypted to protect against unauthorized access or attacks.

### Scenario

| Key                | Value |
|--------------------|-------|
| Source of Stimulus | Unauthorized user |
| Stimulus           | Attempts to access restricted enrollment data through URL manipulation |
| Artifact           | Web application, USRLOG module |
| Environment        | Normal operational conditions |
| Response           | Access is denied, and the attempt is logged for review |
| Measure            | No sensitive data is exposed |

### Conclusion
✅

### Reason/Solution
System successfully blocked the unauthorized access attmept and logged it for auditing.
