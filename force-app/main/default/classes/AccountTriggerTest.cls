@isTest
public class AccountTriggerTest {
	
    //+Exercise 2 - Good 
    @isTest
    private static void newAccountSalesRepTestGood(){
        //Arrange
               
       	//Act
       	Test.startTest();
        
       	Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;
        
    	Test.stopTest();
        
       	//Assert
        system.assertEquals(acc.Sales_Rep__c, acc.OwnerId);
    }
   
    @isTest
    private static void updateSalesRepTestGood(){
        //Arrange
        Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;
               
       	//Act
       	Test.startTest();
        
       	Account acct = new Account();
        acct.Id = acc.Id;
        acct.Name = 'Test New';
        acct.Sales_Rep__c = null;
        update acct;
        
    	Test.stopTest();
        
       	//Assert
       	Account accList = [SELECT Id, OwnerId, Sales_Rep__c FROM Account where Id = :acct.Id];
        system.assertEquals(accList.OwnerId, accList.Sales_Rep__c, 'Error');
    }
    //-Exercise 2
    
    //+Exercise 3 
    @isTest
    private static void newAccExpired(){
        //Arrange
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();

		//Act        
        Account acc = new Account();
        acc.Name = 'Test Account';
        acc.Subscription_Status__c = 'Expired';
        acc.RecordTypeId = recordTypeId;
        Insert acc;
        
        //Assert
        List<Case> caseRec = [SELECT Id FROM Case];
        System.assertEquals(1, caseRec.size());
    }
    
    @isTest
    private static void updateAccountExpired(){
        //Arrange
        Id recordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Customer').getRecordTypeId();
        
        Account newAcc = new Account();
        newAcc.Name = 'Test Account';
        newAcc.RecordTypeId = recordTypeId;
        newAcc.Subscription_Status__c = 'Active';
        Insert newAcc;
        
        //Act
        Test.startTest();
        
        Account updateAcc = new Account();
        updateAcc.Subscription_Status__c = 'Expired';
        updateAcc.Id = newAcc.Id;
        Update updateAcc;
        
        Test.stopTest();
        
        //Assert
        List<Case> caseRec = [SELECT Id FROM Case];
        System.assertEquals(1, caseRec.size());
    }
    //-Exercise 3
    
    //+Exercise 4
    @isTest
    private static void accountIncreaseRateTest(){
        //Arrange
        Increase_Type__c incType = new Increase_Type__c();
        incType.Name = 'Increase 1';
        Insert incType;
       
        Account acc = new Account();
        acc.Name = 'Test Acc';
        acc.Increase_Type__c = incType.Id;
        acc.Effective_Date__c = date.parse('06/05/2022');
        Insert acc;
        
        Increase_Rate__c incRate = new Increase_Rate__c();
        incRate.Active__c = true;
        incRate.Increase_Type__c = incType.Id;
        incRate.Start_Effective_Date__c = date.parse('06/01/2022');
        incRate.End_Effective_Date__c = date.parse('06/15/2022');
        incRate.Category__c = 'Increase Category 1';
        incRate.Increase_Rate__c = 0.25;
        insert incRate;
        
        Increase_Rate__c incRate2 = new Increase_Rate__c();
        incRate2.Active__c = true;
        incRate2.Increase_Type__c = incType.Id;
        incRate2.Start_Effective_Date__c = date.parse('06/16/2022');
        incRate2.End_Effective_Date__c = date.parse('06/30/2022');
        incRate2.Category__c = 'Increase Category 2';
        incRate2.Increase_Rate__c = 0.50;
        insert incRate2;
        
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Increase_Rate__c = 0.50;
        
        //Act
        Test.startTest();
        acc.Effective_Date__c = date.parse('06/17/2022');
        update acc;
        Test.stopTest();
            
        //Assert
        system.assertNotEquals(0.50, acc.Increase_Rate__c);
        
        system.debug('INC RATE: ' + acc.Increase_Rate__c);
    }
    //-Exercise 4
    
}