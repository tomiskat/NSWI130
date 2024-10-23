workspace "EXA2 Workspace" {

    model {
    
        # software systems
        
        examsManager = softwareSystem "Exams Manager" {
        
            dashboard = container "Dashboard" "Provides functionality for presenting exams information in a web browser."

            managedExamsReader = container "Managed Exams Reader"
            examsWriter = container "Exams Writer"
            resultsWriter = container "Results Writer"
            
            registeredExamsReader = container "Registered Exams Reader"
            registrationWriter = container "Registration Writer"
            resultsReader = container "Results Reader"
            
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
        resultsReader -> sis "Makes API calls to read from"
        
        
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