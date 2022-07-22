public class IncreaseRateTriggerHandler {
	
    //Exercise 6
    public static void newIncreaseRate(List<Increase_Rate__c> newList){
        for(Increase_Rate__c newIncRate: newList){
           List<Increase_Rate__c> ExistingIncRate = [
               SELECT Start_Effective_Date__c, End_Effective_Date__c 
               FROM Increase_Rate__c 
               WHERE Increase_type__c = :newIncRate.Increase_type__c 
               AND Category__c = :newIncRate.Category__c 
               AND Active__c = :newIncRate.Active__c
           ];
           for(Increase_Rate__c checkIncRate : ExistingIncRate){
               if(((checkIncRate.Start_Effective_Date__c <= newIncRate.Start_Effective_Date__c 
                    && checkIncRate.End_Effective_Date__c >= newIncRate.Start_Effective_Date__c) 
                   || (checkIncRate.Start_Effective_Date__c <= newIncRate.End_Effective_Date__c 
                       && checkIncRate.End_Effective_Date__c >= newIncRate.End_Effective_Date__c)) 
                  && checkIncRate.Id <> newIncRate.Id){
                   newIncRate.addError('An existing increase rate record cover the same dates');
               }
           }
       }
    }
}