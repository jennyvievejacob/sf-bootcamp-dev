@isTest
private class ContactTriggerTest {
    
    //Exercise 1.1
	@isTest
    private static void onBeforeInsertTest(){
        //Arrange
        Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;
        
        //Act
        Test.startTest();
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=1; i < 15; i++){
            Contact con = new Contact();            
            con.FirstName = 'Test First ' + i;
            con.Lastname = 'Test Last ' + i; 
            con.AccountId = acc.id;
            conList.add(con);
        }
        Insert conList;
        Test.stopTest();
        
        //Assert
    	List<Contact> conRec = [SELECT Id, Description FROM Contact WHERE Id IN :conList];
        for(Contact c : conRec){
            System.assertEquals('Contact created successfully by using ContactBeforeInsert trigger.', c.Description, 'Error');
        }
    }
    
    //Exercise 1.1
    //Bad flow
    @isTest
    private static void beforeUpdateNegTest(){
      	//Arrange
        Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Test First';
        con.Lastname = 'Test Last';
        con.AccountId = acc.Id;
        Insert con;
        
        //Act
        Test.startTest();
        con.FirstName = 'New FirstName';
        Update con;
        Test.stopTest();
        
        //Assert
        Contact conRec = [Select Id, Description FROM Contact WHERE Id = :con.Id];
        System.assertEquals('Contact created successfully by using ContactBeforeInsert trigger.', conRec.Description, 'Error');
    }    
    
    //Exercise 1.2
    @isTest
    private static void onBeforeUpdate2(){
        //Arrange
        Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;
        
        Contact con = new Contact();            
        con.FirstName = 'Test First';
        con.Lastname = 'Test Last'; 
        con.AccountId = acc.id;
        Insert con;
        
        //Act
        Test.startTest();
        con.LastName = 'New LastName';
        Update con;
        Test.stopTest();
        
        //Assert
        Contact conRec = [Select Id, Description FROM Contact WHERE Id = :con.Id];
        system.assertEquals('Contact updated successfully by ' + UserInfo.getName(), conRec.Description, 'Error');
    }
    
    //Exercise 1.3
    @isTest
    private static void onBeforeDeleteTest(){
        //Arrange
        Account acc = new Account();
        acc.Name = 'Test Account';
        Insert acc;
        
        Contact con = new Contact();
        con.FirstName = 'Test First';
        con.Lastname = 'Test Last';
        con.AccountId = acc.Id;
        Insert con;
        
        //Act
        Test.startTest();
        
        try{
            delete con;
        } catch (DMLException e) {
            //Assert
            Contact conRec = [SELECT id From contact where id= :con.Id];
            system.assert(e.getMessage().contains('Hey! You are not authorized to perform this action'));
        }
        Test.stopTest();
    }
    
    //Exercise 5
    @isTest
    private static void setPrimaryContactTest(){
        //Arrange
        Account acc = new Account();
        acc.Name = 'Test';
        Insert acc;
        
        Contact newCon = new Contact();
        newCon.firstname = 'Test';
        newcon.lastname = 'Test';
        newcon.Primary__c = true;
        newcon.AccountId = acc.Id;
        Insert newCon;
        
        //Act
        Test.startTest();
        Contact newCon2 = new Contact();
        newCon2.firstname = 'Test';
        newCon2.lastname = 'Test';
        newcon2.Primary__c = true;
        newCon2.AccountId = acc.Id;
        Insert newCon2;
        Test.stopTest();
        
        //Assert
        Contact checkPrimary = [Select Id, Primary__c from Contact where Id = :newcon.Id];
        Account checkAcc = [Select Id, Contact__c from Account where Id = :acc.Id];
        
        system.debug(checkPrimary.primary__c);
        system.assertEquals(false, checkPrimary.Primary__c);
        system.assertEquals(newCon2.id, checkAcc.Contact__c);
    }
}