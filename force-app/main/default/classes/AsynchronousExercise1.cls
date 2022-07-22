public class AsynchronousExercise1 implements Database.Batchable<sObject> {
    //start
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator(
            [SELECT Id, Number_Of_Closed_Accepted__c, Number_Of_Closed_Rejected__c, 
                 (SELECT Id, Position__c, Stage__c
                  FROM Job_Applications__r 
                  WHERE Stage__c = 'Closed - Accepted' OR Stage__c = 'Closed - Rejected') 
             FROM Position__c 
             WHERE Closing_Date__c = TODAY]
        );
    }
    
    //execute
    public void execute(Database.BatchableContext BC, List<Position__c> scope){
        List<Position__c> posList = new List<Position__c>();        
        
        for(Position__c pos : scope){
            integer numClosedAccepted = 0;
        	integer numClosedRejected = 0;
            
            pos.Status__c = 'Closed';
            
            for(Job_Application__c jobApp : pos.Job_Applications__r){
                if(jobApp.Stage__c == 'Closed - Accepted'){
                    numClosedAccepted++;
                }
                else if(jobApp.Stage__c == 'Closed - Rejected'){
                    numClosedRejected++;
                }
            }
            pos.Number_of_Closed_Accepted__c = numClosedAccepted;
            pos.Number_of_Closed_Rejected__c = numClosedRejected;
            
            posList.add(pos);
        }
        update posList;
    }
    
    //finish
    public void finish(Database.BatchableContext BC){
        
    }
}

/*AsynchronousExercise1 ex1 = new AsynchronousExercise1();
Database.executeBatch(ex1);*/