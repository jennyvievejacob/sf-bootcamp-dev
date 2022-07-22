@isTest
public class SampleWSTest {
	@isTest
    static void doPostTest(){
        //Arrange
        //prep data or details
        //do or call the functionality
        //assertion of return
        
        //Act
        //creation of records if needed
        //prep for the deets of the request
        //call the http callout
        
        //Assert
        //perform assert via the response
        
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/DemoWebService';
        req.httpMethod ='POST';
        
        DemoWebService.JsonBodySample jsonBody = new DemoWebService.JsonBodySample();
        jsonBody.firstname = 'firstname';
        jsonBody.lastname = 'lastname';
        jsonBody.age = 23;
        req.requestbody = blob.valueof(json.serialize(jsonBody));
        
        //submit request        
        RestContext.request = req;
        RestContext.response = res;
        
        //call callout
		DemoWebService.doPost();
        

    }
}