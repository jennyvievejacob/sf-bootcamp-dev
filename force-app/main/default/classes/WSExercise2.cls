@RestResource(urlMapping='/WSExercise2')
global class WSExercise2 {
    
    @HttpPost 
    global static void doPost(){
        //create vars to hold data from arc
        string fname, lname, email, phone, response;
        
        //retrieve JSON body
        String body = RestContext.request.requestBody.toString();
        
        NewContact d = (NewContact) Json.deserialize(body, NewContact.class);
        fname = d.firstname;
        lname = d.lastname;
        email = d.email;
        phone = d.phone;
        
        //Check for duplicate record
        List<Contact> contactList = [SELECT Id, FirstName, LastName, Email, Phone 
                                     FROM Contact
                                     WHERE Firstname = :fname
                                     AND Lastname = :lname
                                     AND Email = :email];
        
        if(contactList.size() > 0){
            //check if phone already exist
            if(contactList[0].phone != phone){
                //update record
                contactList[0].phone = phone;
                update contactList;
                response = 'Contact with Id :' + contactList[0].Id + ' was updated!';
            }
            else{
                //duplicate found
                response = 'This contact already exist Id :' + contactList[0].Id;
            }
        }
        else{
            //insert new acc
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
    
    //Wrapper to receive JSON data 
    public class NewContact{
        public string firstname;
        public string lastname;
        public string email;
        public string phone;
    }
}