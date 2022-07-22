@isTest
public class WS1Test {
    @isTest
    static void doPostContactFoundTest(){
        //Arrange
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/WSExercise1';
        req.httpMethod = 'POST';
        
        List<Contact> conList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.firstname ='Jen';
        con1.lastname = 'Jacob';
        conList.add(con1);
        
        insert conList;
        
        req.requestBody = blob.valueOf(json.serialize(conList));
        
        //submit request        
        RestContext.request = req;
        RestContext.response = res;
        
        //Act
        //call callout
        Test.startTest();
        WSExercise1.doPost();
        Test.stopTest();
        
        //Assert
        system.assertNotEquals(null, res.responsebody.toString());
    }
    
    @isTest
    static void doPostNoContactFoundTest(){
        //Arrange
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/WSExercise1';
        req.httpMethod = 'POST';
        
        List<Contact> conList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.firstname ='Jen';
        con1.lastname = 'Jacob';
        conList.add(con1);
        
        req.requestBody = blob.valueOf(json.serialize(conList));
        
        //submit request        
        RestContext.request = req;
        RestContext.response = res;
        
        //Assert
        //call callout
        Test.startTest();
        try{
            WSExercise1.doPost();
        } catch (Exception e){
            //Assert
            system.assertEquals('No Contact Found!', e.getMessage());
        }
        Test.stopTest();
    }
}