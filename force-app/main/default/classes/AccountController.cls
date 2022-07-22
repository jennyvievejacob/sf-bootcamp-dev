public with sharing class AccountController {

    @AuraEnabled(cacheable=true)
    public static Account getAccountRecord(String searchInput) {
        return [SELECT Name, AccountNumber, Site FROM Account WHERE Id =:searchInput];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(String searchInput){
        String searchString;
        if(!String.isBlank(searchInput)){
            searchString = '%' + searchInput + '%';
        }
        return [SELECT Id, Name, AccountNumber, Site FROM Account WHERE Name LIKE :searchString LIMIT 10];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedContacts(String accId){
        return [SELECT Id, Name, Title, Phone, Email FROM Contact WHERE Account.Id = :accId];
    }

}
