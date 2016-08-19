public class TrailheadDataHandler {

   private String runCalloutRequest(String trailheadId){
   		
        String rawHtml;
        
        HttpRequest req = new HttpRequest(); 
        
        req.setMethod('GET');
        req.setHeader('content-type', 'text/html');
        req.setEndpoint('https://trailhead.salesforce.com/users/profiles/'+trailheadId);
       
        Http http = new Http();
        
        try {		
            HTTPResponse res = http.send(req);	
            
            rawHtml = res.getBody();
            
        } catch(System.CalloutException e) {
            System.debug(e);
        }	
        return rawHtml;
    }
       
	   
	public List<String> parse(String html){
		List<String>  res = new List<String> ();
			
		String badgeStart = '<div class=\'row\'>\n<div class=\'span2 user_stats\' data-target=\'#page2\' data-toggle=\'tab\' rel=\'badges\'>\n<a>\n<div class=\'stats_number\'>';
		String badgeEnd = '</div>';
		
		String scoreStart = '</div>\n<div class=\'span4 pull-right trailhead-points\'>\n<span class=\'trailhead-total-points\'>\n<i class=\'icon-star\'></i>\n<b>';
		String scoreEnd = '</b>';
		
		String badge = html.substringBetween(badgeStart, badgeEnd);
		String score = html.substringBetween(scoreStart, scoreEnd);

		res.add(badge);
		res.add(score);

		return res;
	}   
	
	
	public void getInternsData(List<String> internsIds){
		Map<String, List<String>> internsData = new Map<String, List<String>>();
		
		for(String internId : internsIds){
			internsData.put(internId, parse(runCalloutRequest(internId)));
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