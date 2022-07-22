@RestResource(urlMapping='/DemoWebService')
global class DemoWebService {
    
    @HttpGet
    global static void doGet(){
        RestContext.response.responseBody = Blob.valueOf('Hello world');
    }
    
    //Inbound
    @HttpPost 
    global static void doPost(){
        //retrieve body from data
        system.debug(RestContext.request.requestBody.toString());
        system.debug(RestContext.request.params);
        
        //retrieve query params from data
        Map<String, String> getParams = RestContext.request.params;
        system.debug('Name: ' + getParams.get('name'));
        
        //retrieve JSON body
        String body = RestContext.request.requestBody.toString();
        JsonBodySample jbs = (JsonBodySample) Json.deserialize(body, JsonBodySample.class);
        system.debug('Firstname: ' + jbs.firstname);
        system.debug('Age: ' + jbs.age);
        
        //print multilevel address
        //system.debug('Street: ' + jbs.address.street);
        
        //print array
        //system.debug('Item is: ' + jbs.items[1]);
        
        //Insert new contact
        Contact newCon = new Contact();
        newCon.FirstName = jbs.firstname;
        newCon.LastName = jbs.lastname;
        insert newCon;
               
        //data to ARC
        RestContext.response.responseBody = Blob.valueOf('Post Method');
    }
    
    //Wrapper to receive JSON data 
    public class JsonBodySample{
        public string firstname;
        public string lastname;
        public integer age;
        public newAddress address;
        //array
        public List<string> items;
        
    }
    
    //Wrapper for multilevel address
    public class newAddress{
        public string street;
        public string city;
        public integer zipcode;
        
    }
    
    @HttpDelete 
    global static void doDelete(){
        
    }
    
    @HttpPatch 
    global static void doPatch(){
        
    }
    
    @HttpPut 
    global static void doPut(){
        
    }
 
    
}