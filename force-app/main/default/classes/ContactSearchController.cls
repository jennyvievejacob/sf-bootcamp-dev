public class ContactSearchController {
    public String searchText{get;set;}
    public List<Contact> contactList{get;set;}
    public List<ContactWrapper> contactWrapperList{get;set;}
    public List<ContactWrapper> contactWrapperSelectedList{get;set;}
    
    public ContactSearchController(){
        this.contactList = [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];
        this.contactWrapperList = new List<ContactWrapper>();
        for(Contact cont : this.contactList){
            ContactWrapper contWrapper = new ContactWrapper(cont);
            contactWrapperList.add(contWrapper);
        }
    }
    
    public void doInit(){        
        //this.contactList = [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];
    }
    
    public void doSearchContacts(){        
        String searchValue = '%' + searchText +'%';
        contactList = [SELECT Id, FirstName, LastName, Email FROM Contact WHERE Name LIKE :searchValue LIMIT 10];
        contactWrapperList = new List<ContactWrapper>();
        for(Contact cont : contactList){
            ContactWrapper contWrapper = new ContactWrapper(cont);
            contactWrapperList.add(contWrapper);
        }
    }
    
    public void doSearchSelectedContacts(){ 
        contactWrapperSelectedList = new List<ContactWrapper>();
        for(ContactWrapper contWrapper : contactWrapperList){
            if(contWrapper.checked){
                contactWrapperSelectedList.add(contWrapper);	                
            }
        }
        system.debug('contactWrapperSelectedList::' + contactWrapperSelectedList);
    }
    
    public class ContactWrapper{
        public Contact contactRecord {get; set;}
        public Boolean checked {get; set;}
        
        public ContactWrapper(Contact cont){
            this.contactRecord = cont;
            this.checked = false;
        }
    }
}