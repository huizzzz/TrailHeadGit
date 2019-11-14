@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String AccId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [SELECT id,name,(select id from contacts)
                        FROM Account
                        WHERE Id = :AccId];
        return result;
    }
}