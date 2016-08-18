public class TrailheadDataHandler {
	
    private String runCalloutRequest(String trailheadId){
   		
        String rawHtml;
        
        HttpRequest req = new HttpRequest(); 
        
        //Set HTTPRequest Method
        req.setMethod('GET');
        //Set HTTPRequest header properties
        req.setHeader('content-type', 'text/html');
      
        req.setEndpoint('https://trailhead.salesforce.com/users/profiles/'+trailheadId);
       
        Http http = new Http();
        
        try {
            
            //Execute web service call here		
            HTTPResponse res = http.send(req);	
            
            //Helpful debug messages
            System.debug(res.toString());
            System.debug('STATUS:'+res.getStatus());
            System.debug('STATUS_CODE:'+res.getStatusCode());
            System.debug(res.getBody());
            
            rawHtml = res.getBody();
            
        } catch(System.CalloutException e) {
            //Exception handling goes here....
        }	
        return rawHtml;
    }
       
	   
	public List<String> parse(String html){
		List<String>  res = new List<String> ();
		

		String badgeStart = '<div class=\'stats_number\'>';
		String badgeEnd = '</div>';
		
		String scoreStart = '<span class=\'trailhead-total-points\'>\n<i class=\'icon-star\'></i>\n<b>';
		String scoreEnd = '</b>';
		
		String badge = html.substringBetween(badgeStart, badgeEnd);
		String score = html.substringBetween(scoreStart, scoreEnd);

		res.add(badge);
		res.add(score);
		System.debug(badge);
		System.debug(score);
		return res;
	}   
	
	
	public void getInternsData(List<String> internsIds){
		Map<String, List<String>> internsData = new Map<String, List<String>>();
		
		for(String internId : internsIds){
			internsData.put(internId, parse(runCalloutRequest(internId)));
		}
		updateInternData(internsData);

		System.debug(internsData);

	} 

	public void updateInternData(Map<String, List<String>> internsData){
		List<Participant__c> participantsList = [SELECT Id, Name, trailheadId__c FROM Participant__c WHERE trailheadId__c IN :internsData.keySet()];
		List<ChallengeToParticipant__c> ChallengeToParticipantList = [SELECT Id, Badges__c, ChallengeId__c, isNew__c, ParticipantId__c, Score__c, startBadges__c, startScore__c FROM ChallengeToParticipant__c];

		for(ChallengeToParticipant__c junctionList : ChallengeToParticipantList){
			for(Participant__c part: participantsList){
				if(junctionList.ParticipantId__c == part.Id){
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