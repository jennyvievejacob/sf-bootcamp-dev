@RestResource(urlMapping='/WSExercise1')
global class WSExercise1 {

    //Inbound
    @HttpPost 
    global static void doPost(){
        //retrieve JSON body
        String body = RestContext.request.requestBody.toString();
        
        List<Contact> conList = (List<contact>) Json.deserialize(body, List<Contact>.class);
        //Print to check
        system.debug(conList);
        
        List<String> nameList = new List<String>();
        for(Contact data : conList){
            String name = data.firstname + ' ' + data.lastname;
            nameList.add(name);
        }
        
        //Search related info
        List<Contact> queryContact = [SELECT FirstName, LastName, Position__c, Account.Phone, Account.Name
                                      FROM Contact
                                      WHERE Name IN :nameList];
        
        List<OutputWrapper> out = new List<OutputWrapper>();
        //Loop thru query result and store required fields' values in the wrapper class
        for(Contact c: queryContact){
            out.add(new OutputWrapper(c.position__c, c.LastName, c.FirstName, c.Account.Phone, c.Account.Name));
        }
        
        //Send response back to ARC
        if(queryContact.size() > 0){
        	RestContext.response.responseBody = Blob.valueOf(json.serialize(out));
        }
        else{
            RestContext.response.responseBody = Blob.valueOf('No contact found!');
        }
    }
    
    public class OutputWrapper{
        public string position;
        public string lastName;
        public string firstname;
        public string companyContact;
        public string company;
        
        public OutputWrapper(String position, String lastName, String firstname, String companyContact, String company){
            this.position = position;
            this.lastName = lastName;
            this.firstname = firstname;
            this.companyContact = companyContact;
            this.company = company;
        }
    }
}