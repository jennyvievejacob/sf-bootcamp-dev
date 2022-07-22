public class DemoWebServiceOutbound {
    
    public string endpoint {get;set;}
    public string method {get;set;}
    public string responsebody {get;set;}
    
    public string grant_type {get;set;}
    public string username {get;set;}
    public string password {get;set;}
    public string client_id {get;set;}
    public string client_secret {get;set;}
    
    //Outbound
    public PageReference runCallOut() {
        //https://www.zipcodeapi.com/rest/<api_key>/distance.<format>/<zip_code1>/<zip_code2>/<units>
        
        this.endpoint = 'https://www.zipcodeapi.com/rest/DemoOnly00WKMUV4KoDq5Vmr5nCT9AtuLWOha4onZYyQJWkxb1jGOrqoD3Pznczr/distance.json/32003/19008/km';
        this.method = 'GET';
        
        //+Send request
        http h = new http();
        HttpRequest hr = new HttpRequest();
        
        hr.setEndpoint(this.endpoint);
        hr.setMethod(this.method);
        
        //Get what was sent
        HttpResponse hResp = h.send(hr);
        //this.responsebody = hResp.getBody();
        //-Send request
        
        //Object data to JSON data 
        ZipCodeApi zca = (ZipCodeApi) Json.deserialize(hResp.getBody(), ZipCodeApi.class);
        this.responsebody = string.valueof(zca.distance);
        
        return NULL;
    }
    
    //Outbound
    public PageReference runGetToken() {
        this.grant_type = 'password';
        this.username = 'jennyvieve.jacob-tk9c@force.com';
        this.password = 'P@ss123456789*oJqy3rjLXnqIVhpEb9jiMgPfh';
        this.client_id = '3MVG9wt4IL4O5wvKefjHV.56NRA0u.alYQb73F0a71hQ69SL1tghHXfdIm8Pb7mveXVudwhtiu0u_6ux4dinM';
        this.client_secret = '9064C9F362F5BF9D3C691164574264B6527E428D9C8B99483B0F107AF4496E32';
        
        this.endpoint = 'https://login.salesforce.com/services/oauth2/token' +
            			'?grant_type=' + this.grant_type +
            			'&username=' + this.username +
            			'&password=' + this.password +
            			'&client_id=' + this.client_id +
            			'&client_secret=' + this.client_secret;
        
        this.method = 'POST';
        
        //Send data
        http h = new http();
        HttpRequest hr = new HttpRequest();
        
        //Set endpoint
        hr.setEndpoint(this.endpoint);
        hr.setMethod(this.method);
        
        //Get response
        HttpResponse hResp = h.send(hr);
        this.responsebody = hResp.getBody();
        
        return NULL;
    }
   
    public class ZipCodeApi{
        public double distance;
    }
    
    public class Body{
        public double distance;
    }
    

}