global class ProjectCalloutServiceMock implements HttpCalloutMock{
    
    // test GET warehouse call
    global HTTPResponse respond(HTTPRequest request) {
      
        // Create a fake response
        // Retrieving the token
        ServiceTokens__c serviceToken = ServiceTokens__c.getvalues('ProjectServiceToken');
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setHeader( 'token', serviceToken.Token__c);
        // NOTE: might be better to create a static final string constant for the setBody() method
        
        response.setStatusCode(201);
        return response; 
    }
}