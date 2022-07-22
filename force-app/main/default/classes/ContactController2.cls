public with sharing class ContactController2 {
    
    public class AccountContactWrapper{
        @AuraEnabled public Account acc;
        @AuraEnabled public Contact con;
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String searchInput){
        String searchString;
        if(!String.isBlank(searchInput)){
            searchString = '%' + searchInput + '%';
        }
        return [SELECT ID, NAME, EMAIL,PHONE FROM Contact WHERE Name LIKE :searchString ORDER BY CreatedDate ASC LIMIT 10];
    }

    @AuraEnabled
    public static AccountContactWrapper getAccountAndContact(){
        Account acc = [SELECT Id , Name FROM ACCOUNT LIMIT 1];
        Contact con = [SELECT Id, Name FROM Contact LIMIT 1];
        AccountContactWrapper accConWrap = new AccountContactWrapper();
        accConWrap.acc = acc;
        accConWrap.con = con;
        return accConWrap;
    }
}
