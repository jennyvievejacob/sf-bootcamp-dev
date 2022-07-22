public class AsynchronousExercise3 implements Queueable{
    public Set<Id> positionSet = new Set<Id>();
    
    public AsynchronousExercise3(Set<Id> posSet){
        this.positionSet = posSet;
    }
    
    public void execute(QueueableContext context) {
        List<Position__c> posList = [SELECT Id, Closing_Date__c, Status__c, Number_of_Closed_Accepted__c, Number_of_Closed_Rejected__c
                                     FROM Position__c 
                                     WHERE Id IN :this.positionSet AND Closing_Date__c = TODAY];
        
        for(Position__c pos : posList){
            pos.Status__c = 'Closed';
        }
        update posList;

		//call queueable job        
        system.enqueueJob(new AsynchronousExercise3SecondQueue(posList));
    }
}

//Execute
/*Map<Id, Position__c> mapPos = new Map<Id, Position__c>([SELECT Id, Closing_Date__c, Status__c, Number_of_Closed_Accepted__c, Number_of_Closed_Rejected__c FROM Position__c WHERE Closing_Date__c = TODAY);
System.enqueueJob(new AsynchronousExercise3(mapPos.keySet()));*/