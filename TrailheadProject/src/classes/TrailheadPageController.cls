public class TrailheadPageController {
    public Boolean NoActualChallenge {get; set;}
    public Date actualDate = Date.today();
    public List<Challenge_Participant__c> ChallengeParticipantList {get; set;}
        
    public TrailheadPageController (){
        
    }
     
    private void getCurrentData(){
        List<Challenge_Participant__c> actualChallenges =  [SELECT Badges_Progress__c, Score_Progress__c, startScore__c, startBadges__c, Score__c, Badges__c, Intern_Name__r.trailheadId__c, Intern_Name__r.Name, Challenge_Name__r.Name, Challenge_Name__r.Final_Date__c FROM Challenge_Participant__c];    
        if(actualChallenges.size() != 0 && actualChallenges != null){
           ChallengeParticipantList  = actualChallenges;  
           NoActualChallenge = true;          
        }
    } 
     
    public void refresh(){
                List<Intern__c> interns = [SELECT Id, trailheadId__c FROM Intern__c];
                List<String> internsIds = new List<String>();
                
                for(Intern__c intern : interns){
                        internsIds.add(intern.trailheadId__c);
                }

                if(internsIds != null){
                        TrailheadDataHandler handler = new TrailheadDataHandler();
                        handler.getInternsData(internsIds);
                        this.getCurrentData();
                } 
    }
}