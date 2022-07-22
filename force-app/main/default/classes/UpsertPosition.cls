public class UpsertPosition { 
    public string name1 = 'Sherlock Holmes';
    public string name2 = 'John Smith';
    
    public void insertNewPos(){
        Position__c newPos = new Position__c(Name='Software Engineer II');
        insert newPos;
    }
    
    public void insertApp1(){
        Applicant__c app1 = new Applicant__c();
        app1.Name = this.name1;
        insert app1;
    }
    
    public void insertApp2(){
        Applicant__c app2 = new Applicant__c();
        app2.Name = this.name2;
        insert app2;
    }
    
    public string getPosId(){
        Position__c p = [SELECT Id FROM Position__c WHERE Name ='Software Engineer II'];
        return p.Id;
    }
    
    public string getApp1(){
        Applicant__c p = [SELECT Id FROM Applicant__c WHERE Name ='Sherlock Holmes'];
        return p.Id;
    }
    
    public string getApp2(){
        Applicant__c p = [SELECT Id FROM Applicant__c WHERE Name ='John Smith'];
        return p.Id;
    }
    
    public void insertJobApps(){
        
        Job_Application__c ja1 = new Job_Application__c();
        ja1.Name = 'S343-851';
        ja1.Position__c = getPosId();
        ja1.Applicant__c = getApp1();
        insert ja1;
    }
    
    public void insertJobApps2(){
        Job_Application__c ja1 = new Job_Application__c();
        ja1.Name = 'S343-853';
        ja1.Position__c = getPosId();
        ja1.Applicant__c = getApp2();
        insert ja1;
    }
    
}