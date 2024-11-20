workspace "EXA2 Workspace" {

    model {

        # software systems

        examsManager = softwareSystem "Exams Manager" {

             userInterface = container "User Interface" "Provides a visual interface for teachers, students, and statisticians" "" "WEB" {
                tags "UI"
            }

            examTermsManager = container "Exam Terms Manager" "Manages creation, modification, and reading of exam dates." {
                termRequestProcessor = component "Term Requests Processor" "The main component that receives and processes requests related to exam schedules"
                termCreationService = component "Term Creation Service" "Processes requests for creating and updating terms."
                termRetrievalService = component "Term Retrieval Service" "Provides access to schedules, allowing users to read available schedules from the database"
                databaseConnector = component "Database Connector" "Communicates with the examTermsDB database and provides an interface for reading, writing, and modifying exam schedule data."
                sisIntegrationAdapter = component "SIS Integration Adapter" "Integrates with the SIS system, sourcing supplementary information necessary for creating new schedules or synchronizing existing ones."
                validationService1 = component "Validation Service" "Validates schedule data before storing or updating it."
            }

            registrationManager = container "Exam Registration Manager" "Handles both reading and writing of student registrations for exams." {
                registrationRequestProcessor = component "Registration Request Processor" "Processes requests for reading and writing student exam registrations"
                registrationService = component "Registration Service" "Stores new registrations, processes cancellation requests, and all related operations"
                registrationQueryService = component "Registration Query Service" "Provides access to stored registrations, ensuring the reading of existing exam registration data"
                databaseConnectorReg = component "Database Connector" "Communicates with the examTermsDB database to access registration data"
                sisIntegrationAdapterReg = component "SIS Integration Adapter"
                validationServiceReg = component "Validation Service" "Validates registration data"
            }

            resultsManager = container "Results Manager" "Handles both reading and writing of exam results and credit records." {
                resultsProcessor = component "Results Processor" "Manages requests for creating, updating, and reading exam results"
                resultWriter = component "Result Writer" "Writes exam results and credits to the database"
                resultReader = component "Result Reader" "Provides access to stored exam results and credit information from the database"
                databaseConnectorResult = component "Database Connector" "Connects to the resultsDB database for reading and writing result data"
                sisIntegrationAdapterResult = component "SIS Integration Adapter"
                validationServiceForResults = component "Validation Service"
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

        termRequestProcessor -> termCreationService "Routes create/update requests to"
        termRequestProcessor -> termRetrievalService "Routes read requests"
        termCreationService -> validationService1 "Validates term data"
        termCreationService -> sisIntegrationAdapter "Synchronizes with SIS"
        termCreationService -> databaseConnector "Writes to examTermsDB"
        termRetrievalService -> databaseConnector "Reads from examTermsDB"
        sisIntegrationAdapter -> sis "API calls to SIS"
        databaseConnector -> examTermsDB

        userInterface -> termRequestProcessor "sends requests to"

        registrationRequestProcessor -> registrationService "Routes create/cancel registration requests"
        registrationRequestProcessor -> registrationQueryService "Routes read registration requests"
        registrationService -> validationServiceReg "Validates registration data"
        registrationService -> sisIntegrationAdapterReg "Synchronizes with SIS"
        registrationService -> databaseConnectorReg "Writes to examTermsDB"
        registrationQueryService -> databaseConnectorReg "Reads from examTermsDB"
        sisIntegrationAdapterReg -> sis "API calls to SIS"
        databaseConnectorReg -> examTermsDB

        userInterface -> registrationRequestProcessor "sends requests to"

        resultsProcessor -> resultWriter "Routes write requests to"
        resultsProcessor -> resultReader "Routes read requests to"
        resultWriter -> validationServiceForResults "Validates results data"
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
            deploymentNode "Database Server" "" "Ubuntu 18.04 LTS" {
                deploymentNode "Terms Database Server" "" "Oracle 19.1.0"{
                    containerInstance examTermsDB
                }
                deploymentNode "Results Database Server" "" "Oracle 19.1.0"{
                    containerInstance resultsDB
                }
            }
        }
        
        deploymentEnvironment "Production" {
            deploymentNode "User Device" "" "Device used by user"{
                containerInstance userInterface
            }
            deploymentNode "Aplication Server" {
                deploymentNode "Results Manager Server" "" "Ubuntu 18.04 LTS" {
                    containerInstance resultsManager
                }
                deploymentNode "Terms Manager Server" "" "Ubuntu 18.04 LTS" {
                    containerInstance examTermsManager
                }
                deploymentNode "Registration Manager Server" "" "Ubuntu 18.04 LTS" {
                    containerInstance registrationManager
                }
            }
            deploymentNode "Database Server" "" "Ubuntu 18.04 LTS" {
                deploymentNode "Terms Database Server" "" "Oracle 19.1.0"{
                    containerInstance examTermsDB
                }
                deploymentNode "Results Database Server" "" "Oracle 19.1.0"{
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

        component resultsManager "resultsReader" {
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
            termRequestProcessor -> termCreationService "Reroutes to"
            termCreationService -> validationService1 "Validates term data using"
            validationService1 -> termCreationService "Returns true if the input is valid"
            termCreationService -> sisIntegrationAdapter "Queries schedule data"
            sisIntegrationAdapter -> termCreationService "Returns schedule data"
            termCreationService -> databaseConnector "If the input is valid and there are no conflicts in schedules, writes new exam term to DB"
            termCreationService -> termRequestProcessor "Sends back an error or a success message"
            termRequestProcessor -> userInterface "Displays corresponding message using"
            
            autolayout lr
            
        }
        
        dynamic examTermsManager "examTermRetrieval" {
            
            userInterface -> termRequestProcessor "Submits request to read exams a user is signed up for to"
            termRequestProcessor -> termRetrievalService "Reroutes to"
            termRetrievalService -> databaseConnector "Queries exam terms data"
            databaseConnector -> termRetrievalService "Sends back exam terms data"
            termRetrievalService -> termRequestProcessor "Sends back exam terms data"
            termRequestProcessor -> userInterface "Displays exam terms using"
            
            autolayout lr
        }
        
        dynamic registrationManager "examTermRegistration" {
            
            userInterface -> RegistrationRequestProcessor "Submits request to read available exam terms to"
            RegistrationRequestProcessor -> registrationQueryService "Reroutes to"
            registrationQueryService -> databaseConnectorReg "Queries exam terms data"
            databaseConnectorReg -> registrationQueryService "Sends back exam terms data"
            registrationQueryService -> RegistrationRequestProcessor "Sends back exam terms data"
            RegistrationRequestProcessor -> userInterface "Displays available exam terms"
            userInterface -> RegistrationRequestProcessor "Submits request to register for a specific exam term"
            RegistrationRequestProcessor -> registrationService "Reroutes to"
            registrationService -> validationServiceReg "Validates registration data"
            registrationService -> databaseConnectorReg "If the input is valid, writes to DB"
            registrationService -> RegistrationRequestProcessor "Sends back an error or a success message"
            RegistrationRequestProcessor -> userInterface "Displays corresponding message using"
            
            autolayout lr
        }
        
        dynamic resultsManager "examResultsWriting" {
            
            userInterface -> resultsProcessor "Submits request to write exam results"
            resultsProcessor -> resultWriter "Reroutes to"
            resultWriter -> validationServiceForResults "Validates data using"
            validationServiceForResults -> resultWriter "Returns true if the input is valid"
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

        styles {
            element "Element" {
                background #1168bd
                color #ffffff
                shape RoundedBox
            }
            element "Person" {
                background #0a3b6b
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "SIS" {
                background #575c61
            }
            element "WEB" {
                shape WebBrowser
            }
        }
    }

    configuration {
        scope softwaresystem
    }
}
