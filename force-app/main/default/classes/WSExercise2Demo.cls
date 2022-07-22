@RestResource(urlMapping='/WSExercise2Demo')
global class WSExercise2Demo {
    
	@HttpPost
    global static void doPost(){
        //create vars to hold data
        string fname, lname, email, phone, response;
       
        //retrieve data
        //request if data is from the sender
        String body = RestContext.request.requestBody.toString();
        
        //type class =  JSOn data -> object data 
        JSONData jd = (JSONData) Json.deserialize(body, JsonData.class);
        fname = jd.firstname;
        lname = jd.lastname;
        email = jd.email;
        phone = jd.phone;
        
        //check for duplicates
        List<Contact> getCon = [SELECT id, Phone 
                                FROM Contact 
                                WHERE firstname =:fname 
                                AND lastname = :lname 
                                AND email =:email
                                limit 1];
        
        if(getCon.size() > 0){
            //check phone already exist
            if(getcon[0].phone != phone){
                //update record
                getcon[0].phone = phone;
                update getCon;
                response = 'Contact with Id :' + getcon[0].Id + ' was updated!';
            }else{
                //duplicate found
                response = 'This contact already exists with Id :' + getcon[0].Id;
            }
        }
        else{
            //insert
            Contact newCon = new Contact();
            newCon.firstname = fname;
            newCon.lastname = lname;
            newCon.email = email;
            newCon.phone = phone;
            insert newCon;
            
            response = 'Inserted with Id :' + newCon.Id;
        }
        
        Restcontext.response.responseBody = blob.valueof(response);
    }
    
    public class JSONData{
        public string firstName;
        public string lastName;
        public string email;
        public string phone;
    }
}