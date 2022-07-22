@isTest
private class IncreaseRateTriggerTest {

    @isTest
    private static void newIncreaseRate(){
        //Arrange
        Increase_Type__c it = new Increase_Type__c();
        it.Name = 'Test';
        Insert it;
            
		Increase_Rate__c ir = new Increase_Rate__c();  
        ir.Active__c = true;
        ir.Increase_Type__c = it.Id;
        ir.Start_Effective_Date__c = date.parse('07/01/2022');
        ir.End_Effective_Date__c = date.parse('07/31/2022');
        ir.Category__c = 'Increase Category 1';
        ir.Increase_Rate__c = 0.10;
		Insert ir;
        
        //Act
        Test.startTest();
        
        try {
            Increase_Rate__c ir2 = new Increase_Rate__c();  
            ir2.Active__c = true;
            ir2.Increase_Type__c = it.Id;
            ir2.Start_Effective_Date__c = date.parse('07/15/2022');
            ir2.End_Effective_Date__c = date.parse('07/20/2022');
            ir2.Category__c = 'Increase Category 1';
            ir2.Increase_Rate__c = 0.10;
            Insert ir2;
        
        Test.stopTest();
        } catch (Exception e){
            //Assert
            system.assertEquals(true, e.getMessage().contains('existing increase'));
        }        
    }
}