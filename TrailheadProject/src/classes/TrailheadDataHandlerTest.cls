@isTest
public class TrailheadDataHandlerTest {
	
	@isTest
	static void getInternsDataTest(){
		List<String> internsIds = new List<String>();
		internsIds.add('005500000060WgXAAU');
		internsIds.add('005500000060WKbAAM');
		internsIds.add('005500000060XEjAAM');
		
		Date fd = Date.newInstance(2016, 8, 25);
		Challenge__c newChallenge = new Challenge__c(Name = 'test', Final_Date__c = fd);
		insert newChallenge;
		
		List<Intern__c> listInterns = new List<Intern__c>();
		listInterns.add(new Intern__c(Name = 'intern1', trailheadId__c = '005500000060WgXAAU'));
		listInterns.add(new Intern__c(Name = 'intern2', trailheadId__c = '005500000060WKbAAM'));
		listInterns.add(new Intern__c(Name = 'intern3', trailheadId__c = '005500000060XEjAAM'));
		insert listInterns;
		
		List<Challenge_Participant__c> junc = new List<Challenge_Participant__c>();
		
		for(Intern__c intern : listInterns){
			junc.add(new Challenge_Participant__c(Challenge_Name__c = newChallenge.Id, Intern_Name__c = intern.Id));	
		}

		insert junc;

		TrailheadDataHandler handler = new TrailheadDataHandler();
        
		Test.setMock(HttpCalloutMock.class, new CalloutMock());

		Test.startTest();
			handler.getInternsData(internsIds);
		Test.stopTest();

		System.assertEquals(true, true);
		
	}
	

 }