public class ConcertBookingController {
    public String searchConcert{get;set;}
    public String searchContactBooking{get;set;}
    
    //Concert
    public List<Concert__c> concertList{get;set;}
    public List<ConcertWrapper> concertWrapperList{get;set;}
    public List<ConcertWrapper> concertWrapperSelectedList{get;set;}
    
    //Contact
    public List<Contact> contactList{get;set;}
    public List<ContactWrapper> contactWrapperList{get;set;}
    public List<ContactWrapper> contactWrapperSelectedList{get;set;}
    
    //Booking
    public List<Concert_Booking__c> bookList{get;set;}
    public List<BookWrapper> bookWrapperList{get;set;}
    public List<BookWrapper> bookWrapperSelectedList{get;set;}
    
    //Display data:
    public ConcertBookingController(){
        //Concerts
        this.concertList = [SELECT Id, Name, Location__c, Concert_Date__c, Available_Tickets__c, Paid_Booking__c 
                            FROM Concert__c LIMIT 10];
        this.concertWrapperList = new List<ConcertWrapper>();
        for(Concert__c con : this.concertList){
            ConcertWrapper conWrapper = new ConcertWrapper(con);
            concertWrapperList.add(conWrapper);
        }
        
        //Contacts
        this.contactList = [SELECT Id, FirstName, LastName, Email FROM Contact LIMIT 10];
        this.contactWrapperList = new List<ContactWrapper>();
        for(Contact cont : this.contactList){
            ContactWrapper contWrapper = new ContactWrapper(cont);
            contactWrapperList.add(contWrapper);
        }
        
        //Booking
        this.bookList = [SELECT Id, Name, Concert__r.Name, Contact__r.Name, Status__c 
                         FROM Concert_Booking__c 
                         ORDER BY NAME ASC 
                         LIMIT 10 ];
        this.bookWrapperList = new List<BookWrapper>();
        for(Concert_Booking__c book : this.bookList){
            BookWrapper bookWrapper = new BookWrapper(book);
            bookWrapperList.add(bookWrapper);
        }
    }
    
    public void doSearchConcerts(){        
        String searchValue = '%' + searchConcert +'%';
        concertList = [SELECT Id, Name, Location__c, Concert_Date__c, Available_Tickets__c, Paid_Booking__c 
                       FROM Concert__c 
                       WHERE Name LIKE :searchValue
                       LIMIT 10];
        concertWrapperList = new List<ConcertWrapper>();
        for(Concert__c con : concertList){
            ConcertWrapper conWrapper = new ConcertWrapper(con);
            concertWrapperList.add(conWrapper);
        }
    }
    
    public void doSearchContactsBooking(){        
        String searchValue = '%' + searchContactBooking +'%';
        contactList = [SELECT Id, Name, FirstName, LastName, Email 
                       FROM Contact 
                       WHERE Name LIKE :searchValue LIMIT 10];
        bookList =[SELECT Id, Name, Concert__r.Name, Contact__r.Name, Status__c 
                   FROM Concert_Booking__c 
                   WHERE Contact__r.Name LIKE :searchvalue OR Concert__r.Name LIKE :searchValue
                   LIMIT 10];
        
        //Display Contact query result
        contactWrapperList = new List<ContactWrapper>();
        for(Contact cont : contactList){
            ContactWrapper contWrapper = new ContactWrapper(cont);
            contactWrapperList.add(contWrapper);
        }
        
        //Display Concert_Booking__c query result
        bookWrapperList = new List<BookWrapper>();
        for(Concert_Booking__c book : bookList){
            BookWrapper bookWrapper = new BookWrapper(book);
            bookWrapperList.add(bookWrapper);
        }
    }
    
    public void bookTicket(){ 
       contactWrapperSelectedList = new List<ContactWrapper>();
       concertWrapperSelectedList = new List<ConcertWrapper>();
        
        for(ContactWrapper contWrapper : contactWrapperList){
            if(contWrapper.checked){
				contactWrapperSelectedList.add(contWrapper);	                
            }
        }
        
        for(ConcertWrapper newCon : concertWrapperList){
            if(newCon.checked){
				concertWrapperSelectedList.add(newCon);	                
            }
        }
        system.debug('contactWrapperSelectedList::' + contactWrapperSelectedList);
        system.debug('concertWrapperSelectedList::' + concertWrapperSelectedList);
       
        //Create new booking
        Concert_Booking__c newBook = new Concert_Booking__c();
        newBook.Concert__c = concertWrapperSelectedList[0].concertRecord.Id;
        newBook.Contact__c = contactWrapperSelectedList[0].contactRecord.Id;
        newBook.Status__c = 'Pending';
        
        Insert newBook;
    }
    
    public void markAsPaid(){ 
        
    }
    
    public void cancelBooking(){ 

    }
    
    //Class Wrappers
    public class ConcertWrapper{
        public Concert__c concertRecord {get; set;}
        public Boolean checked {get; set;}
        
        public ConcertWrapper(Concert__c con){
            this.concertRecord = con;
            this.checked = false;
        }
    }
    
    public class ContactWrapper{
        public Contact contactRecord {get; set;}
        public Boolean checked {get; set;}
        
        public ContactWrapper(Contact cont){
            this.contactRecord = cont;
            this.checked = false;
        }
    }
    
    public class BookWrapper{
        public Concert_Booking__c bookRecord {get; set;}
        public Boolean checked {get; set;}
        
        public BookWrapper(Concert_Booking__c book){
            this.bookRecord = book;
            this.checked = false;
        }
    }
}