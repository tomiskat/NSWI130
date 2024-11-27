workspace "EXA2 Workspace" {

    model {

        # software systems

        examsManager = softwareSystem "Exams Manager" {

             userInterface = container "User Interface" "Provides a visual interface to interact with the system" "" "MULTI-PLATFORM" {
                mobileApplication = component "Mobile Application" "mobile app"
                webApplication = component "Web Application" "web app"
             }


            examTermsManager = container "Exam Terms Manager" "Manages creation, modification, and reading of exam dates." {
                termRequestProcessor = component "Term Requests Processor" "The main component that receives and processes requests related to exam schedules"
                termCreationHandler = component "Term Creation Handler" "Processes requests for creating and updating terms."
                termRetrievalHandler = component "Term Retrieval Handler" "Provides access to schedules, allowing users to read available schedules from the database"
                databaseConnector = component "Database Connector" "Communicates with the examTermsDB database and provides an interface for reading, writing, and modifying exam schedule data."
                sisIntegrationAdapter = component "SIS Integration Adapter" "Integrates with the SIS system, sourcing supplementary information necessary for creating new schedules or synchronizing existing ones."
                validationHandler1 = component "Validation Handler" "Validates schedule data before storing or updating it."
            }

            registrationManager = container "Exam Registration Manager" "Handles both reading and writing of student registrations for exams." {
                registrationRequestProcessor = component "Registration Request Processor" "Processes requests for reading and writing student exam registrations"
                registrationHandler = component "Registration Handler" "Stores new registrations, processes cancellation requests, and all related operations"
                registrationQueryHandler = component "Registration Query Handler" "Provides access to stored registrations, ensuring the reading of existing exam registration data"
                databaseConnectorReg = component "Database Connector" "Communicates with the examTermsDB database to access registration data"
                sisIntegrationAdapterReg = component "SIS Integration Adapter"
                validationHandlerReg = component "Validation Handler" "Validates registration data"
            }

            resultsManager = container "Results Manager" "Handles both reading and writing of exam results and credit records." {
                resultsProcessor = component "Results Processor" "Manages requests for creating, updating, and reading exam results"
                resultWriter = component "Result Writer" "Writes exam results and credits to the database"
                resultReader = component "Result Reader" "Provides access to stored exam results and credit information from the database"
                databaseConnectorResult = component "Database Connector" "Connects to the resultsDB database for reading and writing result data"
                sisIntegrationAdapterResult = component "SIS Integration Adapter"
                validationHandlerForResults = component "Validation Handler"
            }

            examTermsDB = container "Exam Terms Database" {
                tags "Database"
            }

            resultsDB = container "Exam Results Database" {
                tags "Database"
            }

            !docs docs
        }

        sis = softwareSystem "SIS" {
            tags "SIS"
        }

        # Stakeholders
        teacher = person "Teacher"
        student = person "Student"
        statistician = person "Statistician" "Analyzes exam result data for trends and performance metrics"

        ## relationships of examsManager containers

        teacher -> userInterface "Creates exam terms and awards grades/credits"
        student -> userInterface "Registers for exam terms and views exam results"
        statistician -> userInterface "Accesses exam results and analyzes data"

        userInterface -> examTermsManager "Sends requests to"
        userInterface -> registrationManager "Sends requests to"
        userInterface -> resultsManager "Sends requests to"

        resultsManager -> resultsDB "reads from/writes to"
        registrationManager -> examTermsDB "reads from/writes to"
        examTermsManager -> examTermsDB "reads from/writes to"

        resultsManager -> sis
        registrationManager -> sis
        examTermsManager -> sis

        termRequestProcessor -> termCreationHandler "Routes create/update requests to"
        termRequestProcessor -> termRetrievalHandler "Routes read requests"
        termCreationHandler -> validationHandler1 "Validates term data"
        termCreationHandler -> sisIntegrationAdapter "Synchronizes with SIS"
        termCreationHandler -> databaseConnector "Writes to examTermsDB"
        termRetrievalHandler -> databaseConnector "Reads from examTermsDB"
        sisIntegrationAdapter -> sis "API calls to SIS"
        databaseConnector -> examTermsDB

        userInterface -> termRequestProcessor "sends requests to"

        registrationRequestProcessor -> registrationHandler "Routes create/cancel registration requests"
        registrationRequestProcessor -> registrationQueryHandler "Routes read registration requests"
        registrationHandler -> validationHandlerReg "Validates registration data"
        registrationHandler -> sisIntegrationAdapterReg "Synchronizes with SIS"
        registrationHandler -> databaseConnectorReg "Writes to examTermsDB"
        registrationQueryHandler -> databaseConnectorReg "Reads from examTermsDB"
        sisIntegrationAdapterReg -> sis "API calls to SIS"
        databaseConnectorReg -> examTermsDB

        userInterface -> registrationRequestProcessor "sends requests to"

        resultsProcessor -> resultWriter "Routes write requests to"
        resultsProcessor -> resultReader "Routes read requests to"
        resultWriter -> validationHandlerForResults "Validates results data"
        resultWriter -> sisIntegrationAdapterResult "Synchronizes with SIS"
        sisIntegrationAdapterResult -> sis "API calls to SIS"
        resultWriter -> databaseConnectorResult "Writes to resultsDB"
        resultReader -> databaseConnectorResult "Reads from resultsDB"
        databaseConnectorResult -> resultsDB

        userInterface -> resultsProcessor "sends requests to"
        
        deploymentEnvironment "Testing" {
            deploymentNode "User Device" "" "Device used by user"{
                containerInstance userInterface
            }
            deploymentNode "Results Manager Server" "" "Ubuntu 18.04 LTS" {
                containerInstance resultsManager
            }
            deploymentNode "Terms Manager Server" "" "Ubuntu 18.04 LTS" {
                containerInstance examTermsManager
            }
            deploymentNode "Registration Manager Server" "" "Ubuntu 18.04 LTS" {
                containerInstance registrationManager
            }
            deploymentNode "Database Server" "" "Oracle 19.1.0" {
                containerInstance examTermsDB
                containerInstance resultsDB
            }
        }
        
        deploymentEnvironment "Production" {
            deploymentNode "User Device" "" "Device used by user"{
                containerInstance userInterface
            }
            deploymentNode "Cloud Environmet" "" "AWS" {
                deploymentNode "Results Manager Server" "" "Amazon EC2 instance" {
                    containerInstance resultsManager
                }
                deploymentNode "Terms Manager Server" "" "Amazon EC2 instance" {
                    containerInstance examTermsManager
                }
                deploymentNode "Registration Manager Server" "" "Amazon EC2 instance" {
                    containerInstance registrationManager
                }
                deploymentNode "Database Server" "" "Amazon RDS instance" {
                    containerInstance examTermsDB
                    containerInstance resultsDB
                }
            }
        }
    }

    views {
        systemContext examsManager "L1" {
            include *
            autolayout lr
        }

        container examsManager "L2" {
            include *
            autolayout lr
        }

        component userInterface "userInterface" {
            include *
            autolayout lr
        }

        component resultsManager "resultsManager" {
            include *
            autolayout lr
        }

        component registrationManager "registrationManager" {
            include *
            autolayout lr
        }

        component examTermsManager "examTermsManager" {
            include *
            autolayout lr
        }
        
        deployment examsManager "Testing" "TestingDeployment" {
            include *
            autolayout lr
        }
        
        deployment examsManager "Production" "ProductionDeployment" {
            include *
            autolayout lr
        }
        
        dynamic examTermsManager "examTermCreation" {
            
            userInterface -> termRequestProcessor "Submits request to create new exam to"
            termRequestProcessor -> termCreationHandler "Reroutes to"
            termCreationHandler -> validationHandler1 "Validates term data using"
            validationHandler1 -> termCreationHandler "Returns true if the input is valid"
            termCreationHandler -> sisIntegrationAdapter "Queries schedule data"
            sisIntegrationAdapter -> termCreationHandler "Returns schedule data"
            termCreationHandler -> databaseConnector "If the input is valid and there are no conflicts in schedules, writes new exam term to DB"
            termCreationHandler -> termRequestProcessor "Sends back an error or a success message"
            termRequestProcessor -> userInterface "Displays corresponding message using"
            
            autolayout lr
            
        }
        
        dynamic examTermsManager "examTermRetrieval" {
            
            userInterface -> termRequestProcessor "Submits request to read exams a user is signed up for to"
            termRequestProcessor -> termRetrievalHandler "Reroutes to"
            termRetrievalHandler -> databaseConnector "Queries exam terms data"
            databaseConnector -> termRetrievalHandler "Sends back exam terms data"
            termRetrievalHandler -> termRequestProcessor "Sends back exam terms data"
            termRequestProcessor -> userInterface "Displays exam terms using"
            
            autolayout lr
        }
        
        dynamic registrationManager "examTermRegistration" {
            
            userInterface -> RegistrationRequestProcessor "Submits request to read available exam terms to"
            RegistrationRequestProcessor -> registrationQueryHandler "Reroutes to"
            registrationQueryHandler -> databaseConnectorReg "Queries exam terms data"
            databaseConnectorReg -> registrationQueryHandler "Sends back exam terms data"
            registrationQueryHandler -> RegistrationRequestProcessor "Sends back exam terms data"
            RegistrationRequestProcessor -> userInterface "Displays available exam terms"
            userInterface -> RegistrationRequestProcessor "Submits request to register for a specific exam term"
            RegistrationRequestProcessor -> registrationHandler "Reroutes to"
            registrationHandler -> validationHandlerReg "Validates registration data"
            registrationHandler -> databaseConnectorReg "If the input is valid, writes to DB"
            registrationHandler -> RegistrationRequestProcessor "Sends back an error or a success message"
            RegistrationRequestProcessor -> userInterface "Displays corresponding message using"
            
            autolayout lr
        }
        
        dynamic resultsManager "examResultsWriting" {
            
            userInterface -> resultsProcessor "Submits request to write exam results"
            resultsProcessor -> resultWriter "Reroutes to"
            resultWriter -> validationHandlerForResults "Validates data using"
            validationHandlerForResults -> resultWriter "Returns true if the input is valid"
            resultWriter -> databaseConnectorResult "If the input is valid, writes the results to DB"
            resultWriter -> resultsProcessor "Sends back an error or a success message"
            resultsProcessor -> userInterface "Displays corresponding message using"
            
            autolayout lr
        }
        
        dynamic resultsManager "examResultsReading" {
            
            userInterface -> resultsProcessor "Submits request to read exam results"
            resultsProcessor -> resultReader "Reroutes to"
            resultReader -> databaseConnectorResult "Queries exam results data"
            databaseConnectorResult -> resultReader "Sends back exam results data"
            resultReader -> resultsProcessor "Sends back exam results data"
            resultsProcessor -> userInterface "Displays exam results using"
            
            autolayout lr
        }

        theme default
    }

    configuration {
        scope softwaresystem
    }
}

