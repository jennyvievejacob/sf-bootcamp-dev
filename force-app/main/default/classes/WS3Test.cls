@isTest
public class WS3Test implements HttpCalloutMock {
    public string type;
    public WS3Test(final string type){
        this.type = type;
    }
    
	//Outbound WS testing
    public HTTPResponse respond(HTTPRequest request){
        HttpResponse response = new HttpResponse();
        
        response.setHeader('Content-Type', 'application-json');
        
        if(type == 'PositiveScenario'){
        	response.setBody('{"BootcampId" : "A-0001"}');
			response.setStatusCode(200);
        } else if(type == 'ErrorScenario'){
        	response.setBody('{"Error" : "Invalid Data"}');
			response.setStatusCode(400);
        }
        
        return response;
    }
    
    @isTest
    static void testOK(){
         Test.startTest();
        
        //set up mock up response
        Test.setMock(HttpCalloutMock.class, new WS3Test('PositiveScenario'));
        
        // call class 
        WSExercise3 controller = new WSExercise3();
        HttpResponse res = controller.saveAccount();
        system.assertEquals(200, res.getStatusCode());
        
        List<Contact> getCon = [Select Id From Contact];
        system.assertEquals(true, getCon.size() > 0 );
        
        Test.stopTest();
    }
    
    @isTest 
    static void testError(){
        Test.startTest();
        
        //set up mock up response
        Test.setMock(HttpCalloutMock.class, new WS3Test('ErrorScenario'));
        
        // call class 
        WSExercise3 controller = new WSExercise3();
        HttpResponse res = controller.saveAccount();
        if(res == null) {
            system.assertEquals(400, res.getStatusCode());
        }
        
        Test.stopTest();
    }
}