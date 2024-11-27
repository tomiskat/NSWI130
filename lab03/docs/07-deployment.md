## Deployment

**Work distribution:**

Created by @Jan Jevčák

### TestingDeployment
The system is deployed in a testing environment that includes the user device, several server nodes, and databases
running on Ubuntu 18.04 LTS. It simulates the production setup, with instances of the user interface, results 
manager , exam terms manager, registration manager, and databases (Oracle 19.1.0 for both terms and results). 
This setup ensures functionality and performance before the system moves to production.
![](embed:TestingDeployment)

### ProductionDeployment
In the production environment, the system is deployed similarly but focuses on stability, scalability, and security for live usage. The user device interfaces with application servers running in the AWS cloud environment. The results manager, terms manager, and registration manager as Amazon EC2 instances and the database server handling both terms and results databases as Amazon RDS instances.
![](embed:ProductionDeployment)
