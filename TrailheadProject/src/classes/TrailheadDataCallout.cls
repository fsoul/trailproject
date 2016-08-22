public class TrailheadDataCallout {
	
	public static String runCalloutRequest(String trailheadId){
   		
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

}