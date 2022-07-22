@isTest
public class WS2Test {
	@isTest 
    static void doPostInsertTest(){
        //Arrange
        WSExercise2.NewContact jb = new WSExercise2.NewContact();
        jb.firstname = 'Jen';
        jb.lastname = 'Jacob';
        jb.email = 'jenjacob@email.com';
        jb.phone = '123456789';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/WSExercise2';
        req.httpMethod = 'POST';
        req.requestBody = blob.valueOf(system.json.serialize(jb));
        
        RestContext.request = req;
        RestContext.response = res;
        
        //Act
        Test.startTest();
        WSExercise2.doPost();
        Test.stopTest();
        
        //Assert
        system.debug(res.responseBody.toString());
        system.assertEquals(true,res.responseBody.toString().contains('Inserted'));
    }
    
    @isTest 
    static void doPostUpdateTest(){
        //Insert new contact
        Contact con = new Contact();
        con.firstname = 'Jen';
        con.lastname = 'Jacob';
        con.email = 'jenjacob@email.com';
        con.phone = '12345';
        Insert con;
        
        //Arrange
        WSExercise2.NewContact jb = new WSExercise2.NewContact();
        jb.firstname = 'Jen';
        jb.lastname = 'Jacob';
        jb.email = 'jenjacob@email.com';
        jb.phone = '123456';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/WSExercise2';
        req.httpMethod = 'POST';
        req.requestBody = blob.valueOf(system.json.serialize(jb));
        
        RestContext.request = req;
        RestContext.response = res;
        
        //Act
        Test.startTest();
        WSExercise2.doPost();
        Test.stopTest();
        
        //Assert
        system.debug(res.responseBody.toString());
        system.assertEquals(true,res.responseBody.toString().contains('updated'));
    }
    
    @isTest 
    static void duplicateRecordTest(){
        //Insert new contact
        Contact con = new Contact();
        con.firstname = 'Jen';
        con.lastname = 'Jacob';
        con.email = 'jenjacob@email.com';
        con.phone = '123456789';
        Insert con;
        
        //Arrange
        WSExercise2.NewContact jb = new WSExercise2.NewContact();
        jb.firstname = 'Jen';
        jb.lastname = 'Jacob';
        jb.email = 'jenjacob@email.com';
        jb.phone = '123456789';
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/WSExercise2';
        req.httpMethod = 'POST';
        req.requestBody = blob.valueOf(system.json.serialize(jb));
        
        RestContext.request = req;
        RestContext.response = res;
        
        //Act
        Test.startTest();
        WSExercise2.doPost();
        Test.stopTest();
        
        //Assert
       	system.debug(res.responseBody.toString());
        system.assertEquals(true,res.responseBody.toString().contains('already exist'));
    }
}