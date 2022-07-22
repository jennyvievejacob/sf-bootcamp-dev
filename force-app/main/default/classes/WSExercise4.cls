public class WSExercise4 {
    public string endpoint {get;set;}
    public string method {get;set;}
    public string response {get;set;}
    
    //vars to get token
    public string grant_type {get;set;}
    public string username {get;set;}
    public string password {get;set;}
    public string client_id {get;set;}
    public string client_secret {get;set;}
    
    //values from UI
    public string fname {get;set;}
    public string lname {get;set;}
    public string accName {get;set;}
   
    //hold wrapper values
    public string access_token, instance_url, id, token_type, issued_at,signature, bootcampid;
    
   	//get token
    public PageReference getToken(){
        this.grant_type = 'password';
        this.username = 'sfdc%2Bdevtrainer052022%40simplus.com';
        this.password = 'pass12345**';
        this.client_id = '3MVG9wt4IL4O5wvKaK_EyEPgREqQgLeiVoGqjfVLNUC8mkWHd7vRczd89M6_PN3QbYgyoqGN2y.A4F4nQ3PQ4';
        this.client_secret = '707AF061C25EF17B7A9DEFA07F053B23152C7C681F9796732ADB88002B1AE61E';
        
        //set params
        this.endpoint = 'https://login.salesforce.com/services/oauth2/token' +
            			'?grant_type=' + this.grant_type +
            			'&username=' + this.username +
            			'&password=' + this.password +
            			'&client_id=' + this.client_id +
            			'&client_secret=' + this.client_secret;
        this.method = 'POST';

        //First call out to get access token
        http h = new http();
        HttpRequest hr = new HttpRequest();   
        
        //Set endpoint
        hr.setEndpoint(this.endpoint);
        hr.setMethod(this.method);
        
        HttpResponse hResp = h.send(hr); //Send callout
        system.debug(this.response = hResp.getBody()); //Get response
        
        //Deserialize JSON
        AccessToken at = (AccessToken) JSON.deserialize(hResp.getBody(), AccessToken.class);
        this.access_token = at.access_token;
        this.instance_url = at.instance_url;
        this.token_type = at.token_type;
        this.id = at.id;
        this.issued_at = at.issued_at;
        this.signature = at.signature;
        
        return null;
    }
    
    public HttpResponse saveAccount(){
        //call to get token
        this.getToken();
        
        string mapSaveAcc = '/services/apexrest/AccountWebservice';    
        
        this.endpoint = this.instance_url + mapSaveAcc;
        this.method = 'POST';
        system.debug(endpoint);
        
        //Set request body
        JSONBody jb = new JSONBody();
        jb.firstname = this.fname;
        jb.lastname = this.lname;
        jb.account.name = this.accName;
        
       	//serialize json body, JSON => Object
       	String reqjson = JSON.serialize(jb);
        system.debug(reqjson);
        
        //Send request
        http h = new http();
        HttpRequest hr = new HttpRequest();
        
        hr.setEndPoint(this.endpoint);
        hr.setMethod(this.method);
        system.debug('token_type: ' + this.token_type);
        system.debug('access_Token: ' + this.access_Token);
        hr.setHeader('Authorization', this.token_type + ' ' + this.access_Token);
        hr.setHeader('Content-Type', 'application/json');
        hr.setHeader('Accept', 'application/json');
        hr.setBody(reqjson);
        
        HttpResponse hResp = h.send(hr);
        this.response = hResp.getBody();
        
        return hResp;
    }
    
    public class JSONBody{
        public string firstname {get;set;}
        public string lastname {get;set;}
        public JSONAccount account = new JSONAccount();
    }
    
    public class JSONAccount{
        public string name {get;set;}
    }
    
    public class AccessToken{
        public string access_token {get;set;}
        public string instance_url {get;set;}
        public string id {get;set;}
        public string token_type {get;set;}
        public string issued_at {get;set;}
        public string signature {get;set;}
    }
    
}