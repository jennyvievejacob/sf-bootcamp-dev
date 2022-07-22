trigger AccountTrigger on Account (before insert, before update, after insert) {
    
    system.debug('Entered AccountTrigger');
    
    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        system.debug('T1');
        AccountTriggerHandler.onBeforeInsert(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isInsert){
        system.debug('T2');
        AccountTriggerHandler.newCustomerAccountExpired(Trigger.new);
       // WSExercise3.saveAccount(Trigger.new);
    } 
    else if (Trigger.isBefore && Trigger.isUpdate){
        system.debug('T3');
        AccountTriggerHandler.updatedToExpiredCustomer(Trigger.new, Trigger.oldMap); 
        AccountTriggerHandler.accountIncreaseRate(Trigger.new, Trigger.oldMap);
    }
    /*(else if (Trigger.isBefore && Trigger.isUpdate){
        system.debug('T4');
        AccountTriggerHandler.accountIncreaseRate(Trigger.new, Trigger.oldMap);
    }*/
}