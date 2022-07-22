public with sharing class CodeAlongXMLController {

    @AuraEnabled
    public static List<sObject> getRecords(String searchInput, String objName){
        String search = '%' + searchInput + '%';
        String queryStr = 'SELECT Id, Name FROM ' + objName + ' WHERE Name LIKE :search LIMIT 10';
        return Database.query(queryStr);
    }

}
