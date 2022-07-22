public class AsynchronousExercise3SecondQueue implements Queueable{
    public List<Position__c> positionList = new List<Position__c>();
    
    public AsynchronousExercise3SecondQueue(List<Position__c> posList){
        this.positionList = posList;
    }
    
    public void execute(QueueableContext context) {
        List<Job_Application__c> jobList = new List<Job_Application__c>([SELECT Id, Stage__c, Position__c
                                                                         FROM Job_Application__c
                                                                         WHERE Position__c IN :this.positionList]);
        //empty map, populate during jobSorting
        Map<Id, List<Job_Application__c>> jobMap = new Map<Id, List<Job_Application__c>>();
        
        // sort jobApp based on Position__c
        for(Job_Application__c jobSort : jobList){
            //check if map contains key with Position__c
            if(jobMap.containsKey(jobSort.Position__c)){
                jobMap.get(jobSort.Position__c).add(jobSort);
            } else {
                jobMap.put(jobSort.Position__c, New List<Job_Application__c>());
                jobMap.get(jobSort.Position__c).add(jobSort);
                //jobMap.put(Position__c, new List<Job_Application__c> {jobSort});
            }
        }
        
        for(Position__c pos : positionList){
            integer numClosedAccepted = 0;
        	integer numClosedRejected = 0;
            
            if(jobMap.containsKey(pos.Id)){
                for(Job_Application__c jobApp : jobMap.get(pos.Id)){
                    if(jobApp.Stage__c == 'Closed - Accepted'){
                        numClosedAccepted++;
                    }
                    else if(jobApp.Stage__c == 'Closed - Rejected'){
                        numClosedRejected++;
                    }
                }
                pos.Number_of_Closed_Accepted__c = numClosedAccepted;
                pos.Number_of_Closed_Rejected__c = numClosedRejected;
            }
        }
        update positionList;
        
    }
}

//Execute
/*Map<Id, Position__c> mapPos = new Map<Id, Position__c>([SELECT Id, Closing_Date__c, Status__c, Number_of_Closed_Accepted__c, Number_of_Closed_Rejected__c FROM Position__c WHERE Closing_Date__c = TODAY);
System.enqueueJob(new AsynchronousExercise3(mapPos.keySet()));*/