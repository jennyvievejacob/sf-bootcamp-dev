public class NewVFPageController {
    public Account acct {get;set;}
    public List<Opportunity> oppList;
    
    public NewVFPageController(ApexPages.StandardController stdCtrl){
        this.acct = (Account)stdCtrl.getRecord();
        /*this.oppList = [SELECT Id, Name, StageName, Amount, CloseDate 
                          FROM Opportunity 
                          WHERE AccountId = :this.acct.Id AND Amount >= 500000];*/
    }
    
    public List<Opportunity> getOppList(){
        return [SELECT Id, Name, StageName, Amount, CloseDate 
                FROM Opportunity 
                WHERE AccountId = :acct.Id AND Amount >= 500000];
    }
    
}