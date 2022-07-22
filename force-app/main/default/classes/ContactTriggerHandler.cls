public class ContactTriggerHandler {
    
    //Exercise 1.1
    public static void onBeforeInsert(List<Contact> newList){
    	for(Contact con: newList) { 
            con.Description = 'Contact created successfully by using ContactBeforeInsert trigger.';
        }
    }
    
    public static void onBeforeUpdate(List<Contact> newList, Map<Id, Contact> oldMap){
    	for(Contact con: newList) {  
            if(con.MobilePhone == '123' && oldMap.get(con.Id).MobilePhone == '555'){
                con.AddError('Invalid phone');
            }
        }
    }
    
    //Exercise 1.2
    public static void onBeforeUpdate2(List<Contact> newList, Map<Id, Contact> oldVal){
        for(Contact con: newList) {  
            if(con.lastName != oldVal.get(con.Id).lastName){
                con.Description = 'Contact updated successfully by ' + UserInfo.getName();
            }
        }
    }
    
    //Exercise 1.3
    public static void onBeforeDelete(List<Contact> newList){
        for(Contact con: newList){
            if(con.AccountId != null){
                con.AddError('Hey! You are not authorized to perform this action');
            }   
        }
    }
    
    //+Exercise 5
    public static void setPrimaryContact(List<Contact> newCon){
        for(Contact updateContact : newCon){
            List<Contact> conList = [SELECT Id, Primary__c, Name
                                     FROM Contact
                                     WHERE AccountId = :updateContact.AccountId];
            for(Contact removePrimary : conList){
                if(removePrimary.Primary__c == true){
                    removePrimary.Primary__c = false;
                    update removePrimary;
                }
            }
            updateContact.Primary__c = true;
        }
    }
    
    public static void setAccountContact(List<Contact> newContactList){
        for (Contact contactUpdate: newContactList){
            Account conAccRecord = [SELECT Id, Contact__c 
                                    FROM Account 
                                    WHERE Id = :contactUpdate.AccountId];
            conAccRecord.Contact__c = contactUpdate.Id;
            update conAccRecord;
        }
    }
    //-Exercise 5
    
}