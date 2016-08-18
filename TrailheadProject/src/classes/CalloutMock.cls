@isTest
global class CalloutMock implements HttpCalloutMock {
 
    global HTTPResponse respond(HTTPRequest request) {
 
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'text/html');
        response.setBody('<li class=\'user_name\'>Dmutry Marchenkov</li></ul><ul class=\'forums-profile sidebar action-links unstyled\'></ul><div class=\'mobile-social-icons\'></div></div></div></span></div><div class=\'span9\' id=\'profile_questions_container\'><div class=\'profile-content-section\'><meta content=\'en\' name=\'locale\'><div class=\'row trailhead_profile\'><div class=\'span9\' id=\'user_stats\'><div class=\'row\'><div class=\'span2 user_stats\' data-target=\'#page2\' data-toggle=\'tab\' rel=\'badges\'><a><div class=\'stats_number\'>98</div><div class=\'stats_text\'>Trailhead <br /> Badges</div></a></div><div class=\'hidden span2 user_stats\' data-target=\'#page4\' data-toggle=\'tab\' rel=\'event_badges\'><a><div class=\'stats_number\'>0</div><div class=\'stats_text\'>Community <br /> Badges</div></a></div><div class=\'span4 pull-right trailhead-points\'><span class=\'trailhead-total-points\'>\n<i class=\'icon-star\'></i><b>86975</b>Trailhead Points Earned!</span><span class=\'community-total-points hidden\'></span></div></div></div></div><div class=\'row\'><div class=\'tab-content span9\'><div class=\'tab-pane\' id=\'page1\'><div class=\'row incomplete-challenges\'><div class=\'span9\'><h3>In Progress Modules</h3><hr><div class=\'row module\'><div class=\'span10\'><a href="/module/lightning_app_builder"><img class=\'badge-img pull-left\' src=\'https://developer.salesforce.com/resource/images/trailhead/badges/modules/trailhead_module_lightning_app_builder.png\'></a><a href="/module/lightning_app_builder"><h2>Lightning App Builder</h2></a></div><div class=\'span2\'></div></div><div class=\'row module\'><div class=\'span10\'><a href="/module/identity_external"><img class=\'badge-img pull-left\' src=\'https://developer.salesforce.com/resource/images/trailhead/badges/modules/trailhead_module_salesforce_identity_for_customers.png\'></a><a href="/module/identity_external"><h2>Identity for Customers</h2></a></div><div class=\'span2\'></div>');
        response.setStatusCode(200);
       
        return response;
    }
}