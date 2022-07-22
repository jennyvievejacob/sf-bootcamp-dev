public class AccountTriggerHandler {
    
    //Exercise 2    
    public static void onBeforeInsert(List<Account> newList){
        for(Account acc : newList){
            acc.Sales_Rep__c = acc.OwnerId;
        }
    }
    
    //+ Exercise 3
    public static void newCustomerAccountExpired(List<Account> newList){
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        List<Case> caseList = new List<Case>();
        Set<id> accIds = new Set<Id>();
        
    	for(Account acc: newList) { 
            accIds.add(acc.Id);
            if(acc.RecordTypeId == recordTypeId && acc.Subscription_Status__c == 'Expired'){
                Case newCase = new Case();
                newCase.Subject = 'Follow up Subscription Renewal';
                newCase.Status = 'New';
                newCase.Origin = 'Web';
                newCase.AccountId = acc.Id;
                newCase.OwnerId = acc.OwnerId;
                
                caseList.add(newCase);
            }
        }
        if(caseList != null){
            insert caseList;
        }
    }
    
    public static void updatedToExpiredCustomer(List<Account> newList, Map<Id, Account> oldAccMap){
        system.debug('1');
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        List<Case> caseList = new List<Case>();
        
        for(Account acc: newList){          
             system.debug('2');
            if(acc.RecordTypeId == recordTypeId && oldAccMap.get(acc.Id).Subscription_Status__c == 'Active' && acc.Subscription_Status__c == 'Expired'){ 
                 system.debug('3');
                Case newCase = new Case();
                
                newCase.Subject = 'Follow up Subscription Renewal';
                newCase.Status = 'New';
                newCase.Origin = 'Web';
                newCase.AccountId = acc.Id; 
                newCase.OwnerId = acc.OwnerId;
                
                caseList.add(newCase);
            }
        }
        if(caseList != null){
            insert caseList;
        }
    }
    //- Exercise 3
    
    //Exercise 4
    public static void accountIncreaseRate(List<Account> newList, Map<Id, Account> oldAccMap){
        Set<Id> increaseTypeSet = new Set<Id>();
        Set<Id> relatedOppSet = new Set<Id>();
        
        for(Account acc: newList){
            if(acc.Increase_Type__c != oldAccMap.get(acc.Id).Increase_Type__c || 
               acc.Effective_Date__c != oldAccMap.get(acc.Id).Effective_Date__c) {
                system.debug('isUpdate = TRUE');
                   
                increaseTypeSet.add(acc.Increase_Type__c);
                relatedOppSet.add(acc.Id);
            }
        }
        
        Map<Id, Increase_Type__c> child = 
        new Map<Id, Increase_Type__c>([SELECT Id, (SELECT Id, Increase_Type__c, Category__c, Active__c, Start_Effective_Date__c, End_Effective_Date__c, Increase_Rate__c 
                                       FROM Increase_Rates__r WHERE Active__c = TRUE) 
                                       FROM Increase_Type__c
                                       WHERE Id = :increaseTypeSet]);
        
        List<Opportunity> oppList = new List<Opportunity>(
            [SELECT Id, AccountId, Increase_Rate__c
             FROM Opportunity
             WHERE AccountId = :relatedOppSet AND StageName NOT IN ('Closed Won')]
        );
        
        for(Account acc: newList){
            for(Increase_Rate__c rate : (List<Increase_Rate__c>)child.get(acc.Increase_Type__c).Increase_Rates__r){
                if(acc.Effective_Date__c >= rate.Start_Effective_Date__c
                   && acc.Effective_Date__c <= rate.End_Effective_Date__c
                   && acc.Category__c.equals(rate.Category__c)){
                       acc.Increase_Rate__c = rate.Increase_Rate__c;
                       for(Opportunity opp : oppList){
                           opp.Increase_Rate__c = rate.Increase_Rate__c;
                       }
                   }
            }
        }
        
    	Update oppList;
    }
}