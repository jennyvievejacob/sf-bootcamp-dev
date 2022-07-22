public class Person {
	//public String lastName, firstName;
    //public Integer age;
    public static String sharedVar;
    public static Integer recordCount = 0;
    public String personId;
    
    public Person(){
        system.debug('This is a new person');
        this.personId = String.valueOf(recordCount);
        this.incrementRecordCount();
    }
    
    public String getFullname(String lastName, String firstName){
        system.debug(this);
        return lastName + ', ' + firstName; 
    }
    
    public Integer calculateAge(Integer birthYear){
        return Date.today().year() - birthYear;
    }
    
    public Boolean isJen(String firstName){
        if(firstName.contains('Jen')){
            return true;
        }
        return false;
    }
    
    public void incrementRecordCount(){
        recordCount++;
    }
    
    public static String helloWorld(){
        return 'Hello world!';
    }
    
    public void getAllAccount(){
        Account acc = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account LIMIT 1];
        system.debug('Account List: ' + acc.Name);
        system.debug('Account List Size: ' + acc.Contacts);
        
        List<Contact> contList = acc.Contacts;
        for(Contact cont: contList){
            system.debug(cont);
        }
    }

    public void groupByTest(){
        List<AggregateResult> agr = [SELECT Department__c, COUNT(Name) FROM Position__c GROUP BY Department__c];
        system.debug(agr);
        system.debug(agr.size());
    }

        
        
        
        
}