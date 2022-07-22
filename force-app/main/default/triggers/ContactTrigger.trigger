trigger ContactTrigger on Contact (after insert, before insert, before update, before delete) {
    
    if(Trigger.isBefore && Trigger.isInsert){
        ContactTriggerHandler.onBeforeInsert(Trigger.new); //Exercise 1.1
        ContactTriggerHandler.setPrimaryContact(Trigger.new); //Exercise 5
        
    }
    if(Trigger.isAfter && Trigger.isInsert){
        //ContactTriggerHandler.setAccountContact(Trigger.new); //Exercise 5
    }
    //Exercise 1.2
	else if (Trigger.isBefore && Trigger.isUpdate){
        ContactTriggerHandler.onBeforeUpdate(Trigger.new, Trigger.oldMap);
        ContactTriggerHandler.onBeforeUpdate2(Trigger.new, Trigger.oldMap);
    }
    //Exercise 1.3
    else if (Trigger.isBefore && Trigger.isDelete){
        ContactTriggerHandler.onBeforeDelete(Trigger.old);
    }
}