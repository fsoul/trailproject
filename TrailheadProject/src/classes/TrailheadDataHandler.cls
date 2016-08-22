public class TrailheadDataHandler {
	
	public void getInternsData(List<String> internsIds){
		Map<String, List<String>> internsData = new Map<String, List<String>>();
		
		for(String internId : internsIds){
			internsData.put(internId, DataParser.parse(TrailheadDataCallout.runCalloutRequest(internId)));
		}
	
		updateInternData(internsData);
	} 

	public void updateInternData(Map<String, List<String>> internsData){
		List<Intern__c> participantsList = [SELECT Id, Name, trailheadId__c FROM Intern__c WHERE trailheadId__c IN :internsData.keySet()];
		List<Challenge_Participant__c> ChallengeToParticipantList = [SELECT Id, Badges__c, Challenge_Name__c, isNew__c, Intern_Name__c, Score__c, startBadges__c, startScore__c FROM Challenge_Participant__c];

		for(Challenge_Participant__c junctionList : ChallengeToParticipantList){
			for(Intern__c part: participantsList){
				if(junctionList.Intern_Name__c == part.Id){
					if(junctionList.isNew__c){
						junctionList.startBadges__c = Integer.valueOf(internsData.get(part.trailheadId__c)[0]);
						junctionList.startScore__c = Integer.valueOf(internsData.get(part.trailheadId__c)[1]);
						junctionList.isNew__c = false; 
					}else{
						junctionList.Badges__c = Integer.valueOf(internsData.get(part.trailheadId__c)[0]);
						junctionList.Score__c = Integer.valueOf(internsData.get(part.trailheadId__c)[1]);
					}
				}
			}
		}
		Database.update(ChallengeToParticipantList);
	}
}