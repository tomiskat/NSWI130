workspace "EXA2 Workspace" {

    model {
    
        # software systems
        
        examsManager = softwareSystem "Exams Manager" {
        
            dashboard = container "Dashboard" "Provides functionality for presenting exams information in a web browser."{
                userInterface = component "User Interface" "Provides a visual interface for teachers and students"
                examServiceClient = component "Exam Service Client" "Communicates with Exam Writer/Reader API"
                registrationServiceClient = component "Registration Service Client" "Communicates with Registration Reader/Writer API"
                resultServiceClient = component "Result Service Client" "Communicates with Result Reader/Writer API"
            }

            managedExamsReader = container "Managed Exams Reader" "Provides reading of a list of available exam dates that have been created by teachers"{
                examTermQueryHandler = component "Exam Term Query Handler" "Handles Requests to read information about exam dates"
                managedExamsReaderDatabaseConnector = component "Database Connector" "Communicates with examTermsDB to read existing terms"
            }
            examsWriter = container "Exams Writer" "Processes the creation of exam dates"{
                examTermHandler = component "Exam Term Handler" "Processes requests to create/edit/delete exam dates"
                examWriterSisAdapter = component "SIS Adapter" "Queries the SIS system to obtain date data"
                examWriterDatabaseConnector = component "Database Connector" "Communicates with examTermsDB to store or edit terms"
                validationServiceForExamsWriter = component "Validation Service for Exams Writer" "Validates exam term data before processing"
            }
            resultsWriter = container "Results Writer" "Stores test results and credit records"{
                resultHandler = component "Result Handler" "Processes and stores exam results and credit records"
                resultWriterDatabaseConnector = component "Database Connector" "Connects to resultsDB to write results"
                resultWriterSisAdapter = component "SIS Adapter" "Queries the SIS system to obtain data"
                validationServiceForResultsWriter = component "Validation Service for Results Writer" "Validates exam results and credit data before processing"
            }
            
            registeredExamsReader = container "Registered Exams Reader" "Provides a reading of the list of exam dates for which students are registered"{
                registrationQueryHandler = component "Registration Query Handler" "Handles requests to read registration terms."
                registeredExamsReaderDatabaseConnector = component "Database Connector" "Connects to examTermsDB to retrieve data about registrations"
            }
            registrationWriter = container "Registration Writer" "Manages student registration for exams"{
                registrationHandler = component "Registration Handler" "Processes requests for registration and cancellation of dates"
                registrationWriterDatabaseConnector = component "Database Connector" "Provides access to the examTermsDB database"
                registrationWriterSisAdapter = component "SIS Adapter" "Queries the SIS system to obtain registration data"
                validationServiceForRegistrationWriter = component "Validation Service for Registration Writer" "Validates registration data before processing"
            }
            resultsReader = container "Results Reader" "Provides reading of exam results"{
                resultQueryHandler = component "Result Query Handler" "Processes requests to read exam results"
                resultsReaderDatabaseConnector = component "Database Connector" "Connects to resultsDB to read results"
            }
            
            examTermsDB = container "Exam Terms Database" {
                tags "Database"
            }
            
            resultsDB = container "Exam Results Database" {
                tags "Database"
            }
        }
        
        sis = softwareSystem "SIS" {
            tags "SIS"
        }
        
        # actors
        
        teacher = person "Teacher"
        student = person "Student"
        
        ## relationships of examsManager containers
        
        teacher -> dashboard "Creates exam terms and awards grades/credits"
        student -> dashboard "Registers for exam terms and views exam results"
        
        dashboard -> managedExamsReader "Makes API calls to"
        dashboard -> examsWriter "Makes API calls to"
        dashboard -> resultsWriter "Makes API calls to"
        
        dashboard -> registeredExamsReader "Makes API calls to"
        dashboard -> registrationWriter "Makes API calls to"
        dashboard -> resultsReader "Makes API calls to"
        
        managedExamsReader -> examTermsDB "Reads from"
        examsWriter -> examTermsDB "Reads from and writes to"
        examsWriter -> sis "Makes API calls to read from"
        resultsWriter -> resultsDB "Reads from and writes to"
        
        registeredExamsReader -> examTermsDB "Reads from"
        registrationWriter -> examTermsDB "Reads from and writes to"
        registrationWriter -> sis "Makes API calls to read from"
        resultsReader -> resultsDB "Reads from"
        #resultsReader -> sis "Makes API calls to read from"

        userInterface -> examServiceClient "Makes API calls to create,read or modify exams"
        userInterface -> registrationServiceClient "Makes API calls to register/cancel exams"
        userInterface -> resultServiceClient "Makes API calls to view/write results"

        examTermHandler -> examWriterDatabaseConnector "Writes to examTermsDB"
        examTermHandler -> examWriterSisAdapter "Requests data from SIS"
        examWriterSisAdapter -> sis "Makes API calls"
        examWriterDatabaseConnector -> examTermsDB
        examTermHandler -> validationServiceForExamsWriter "Validates exam data"

        examServiceClient -> examTermHandler "Makes API calls to"

        registrationHandler -> registrationWriterDatabaseConnector "Writes to examTermsDB"
        registrationHandler -> registrationWriterSisAdapter "Requests data from SIS"
        registrationWriterSisAdapter -> sis
        registrationWriterDatabaseConnector -> examTermsDB
        registrationServiceClient -> registrationHandler "Makes API calls to"
        registrationHandler -> validationServiceForRegistrationWriter "Validates registration data"

        resultHandler -> resultWriterDatabaseConnector "Writes to resultsDB"
        resultWriterDatabaseConnector -> resultsDB
        resultServiceClient -> resultHandler "Makes API calls to"
        resultHandler -> resultWriterSisAdapter "Requests data from SIS"
        resultHandler -> validationServiceForResultsWriter "Validates result and credit data"
        resultWriterSisAdapter -> sis

        resultServiceClient -> resultQueryHandler "Makes API calls to"
        resultQueryHandler -> resultsReaderDatabaseConnector "Reads from resultsDB to fetch exam results and credits"
        resultsReaderDatabaseConnector -> resultsDB

        registrationServiceClient -> registrationQueryHandler "Makes API calls to"
        registeredExamsReaderDatabaseConnector -> examTermsDB 
        registrationQueryHandler -> registeredExamsReaderDatabaseConnector "Reads from examTermsDB to fetch registered exams"

        examServiceClient -> examTermQueryHandler "Makes API calls to"
        examTermQueryHandler -> managedExamsReaderDatabaseConnector "Reads from examTermsDB to fetch available exam terms"
        managedExamsReaderDatabaseConnector -> examTermsDB



        teacher -> userInterface
        student -> userInterface

        
        # examsManager -> sis "Makes API calls to read from"
        
        ### relationships of managedExamsReader components
        
        ### relationships of examsWriter components
        
        ### relationships of resultsWriter components
        
        ### relationships of registeredExamsReader components
        
        ### relationships of registrationWriter components
        
        ### relationships of resultsReader components

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
        component Dashboard "userInterface"{
            include *
            autolayout lr
        }

        component examsWriter "examsWriter"{
            include *
            autolayout lr
        }
        component registrationWriter "registrationWriter"{
            include *
            autolayout lr
        }

        component resultsWriter "resultsWriter"{
            include *
            autolayout lr
        }

        component resultsReader "resultsReader"{
            include *
            autolayout lr
        }

        component registeredExamsReader "registeredExamsReader"{
            include *
            autolayout lr
        }

        component managedExamsReader "managedExamsReader"{
            include *
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
        }
    }

    configuration {
        scope softwaresystem
    }

}
