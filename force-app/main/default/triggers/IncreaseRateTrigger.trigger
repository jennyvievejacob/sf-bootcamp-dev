trigger IncreaseRateTrigger on Increase_Rate__c (before insert, before update) {

    //Exercise 6
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){ 
        IncreaseRateTriggerHandler.newIncreaseRate(Trigger.new);
    }
}