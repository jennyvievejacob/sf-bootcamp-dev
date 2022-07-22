public class ContactController {
    @AuraEnabled
    public static List<Contact> getContacts(){
        return [SELECT FirstName, LastName, Name, Phone, Email FROM Contact ORDER BY CreatedDate DESC LIMIT 10];
    }
    
    @AuraEnabled
    public static List<Contact> getFilteredContacts(String searchKey, Integer numOfRecords){
        searchKey= '%' + searchKey + '%';
        return [SELECT Firstname, Lastname, Name 
                FROM Contact 
                WHERE Name 
                LIKE :searchKey LIMIT :numOfRecords];
    }
    
    @AuraEnabled
    public static Contact saveContact(Contact con){
        insert con;
        return con;
    }
    
    @AuraEnabled
    public static Contact insertContact(Id acctId, String fName, String lName){
        system.debug('SAVE CONTACT');
        system.debug('ACCOUNT ID: ' + acctId);
        Contact con = new Contact();
        con.AccountId = acctId;
        con.FirstName = fName;
        con.LastName = lName;
        
        INSERT con;
        
        system.debug('CONTACT: ' + con);
        return con;
    }
    
    @AuraEnabled
    public static Account getAccount(Id acctId){
        system.debug('accId: ' + acctId);
        return [Select Id, Name FROM Account WHERE Id = :acctId];
    }
}