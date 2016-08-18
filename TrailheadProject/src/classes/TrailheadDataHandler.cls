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
       
	   
	public Map<String, String> parse(String html){
		Map<String, String> res = new Map<String, String>();
		

		String badgeStart = '<div class=\'stats_number\'>';
		String badgeEnd = '</div>';
		
		String scoreStart = '<span class=\'trailhead-total-points\'>\n<i class=\'icon-star\'></i>\n<b>';
		String scoreEnd = '</b>';
		
		String badge = html.substringBetween(badgeStart, badgeEnd);
		String score = html.substringBetween(scoreStart, scoreEnd);

		res.put(badge, score);
		System.debug(badge);
		System.debug(score);
		return res;
	}   
	
	
	public Map<String, Map<String, String>> getInternsData(List<String> internsIds){
		Map<String, Map<String, String>> internsData = new Map<String, Map<String, String>>();
		
		for(String internId : internsIds){
			internsData.put(internId, parse(runCalloutRequest(internId)));
		}

		System.debug(internsData);

		return internsData;
	} 
    
}