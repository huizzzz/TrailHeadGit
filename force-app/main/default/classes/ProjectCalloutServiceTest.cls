@isTest
private class ProjectCalloutServiceTest {
    //Implement mock callout tests here
    public static final Integer BULK_COUNT = 100;
    @testSetup
    public static void setupData() {
        ServiceTokens__c newServiceToken = new ServiceTokens__c();
        newServiceToken.Name = 'ProjectServiceToken';
        newServiceToken.Token__c = 'TestingPurpose';
        insert newServiceToken;
    }
    
    @isTest
    public static void testProjectCalloutSuccess() {
        List<Account> accts = new List<Account>();
        for(integer i = 0 ;i <= 5; i++){
            Account acc = new Account(name = 'Account' + String.valueOf(i));
            accts.add(acc);
        }
        insert accts;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Account a : accts){
            Opportunity opp = new Opportunity();
            opp.AccountId = a.id;
            opp.NAME = 'Opportunity' + a.Name.Replace('Account','');
            opp.CLOSEDATE = system.today();
            opp.AMOUNT = 1;
            opp.StageName = 'Closed Won';
            opps.add(opp);
        }
        insert opps;
        
        ///List<Opportunity> OppLst = [select id from opportunity];
        List<id> oppIds = new List<id>();
        for(Opportunity opp : opps){
            Id oppId = opp.id;
            oppIds.add(oppId);
        }
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMock()); 
        ProjectCalloutService.postOpportunityToPMS(oppIds);
        
        Test.stopTest();
        
    }
    
    @isTest
    public static void testProjectCalloutFailure() {
        List<Account> accts = new List<Account>();
        for(integer i = 0 ;i <= 5; i++){
            Account acc = new Account(name = 'Account' + String.valueOf(i));
            accts.add(acc);
        }
        insert accts;
        
        List<Opportunity> opps = new List<Opportunity>();
        for(Account a : accts){
            Opportunity opp = new Opportunity();
            opp.AccountId = a.id;
            opp.NAME = 'Opportunity' + a.Name.Replace('Account','');
            opp.CLOSEDATE = system.today();
            opp.AMOUNT = 1;
            opp.StageName = 'Closed Won';
            opps.add(opp);
        }
        insert opps;
        
        ///List<Opportunity> OppLst = [select id from opportunity];
        List<id> oppIds = new List<id>();
        for(Opportunity opp : opps){
            Id oppId = opp.id;
            oppIds.add(oppId);
        }
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ProjectCalloutServiceMockFailure()); 
        ProjectCalloutService.postOpportunityToPMS(oppIds);
        
        Test.stopTest();
        
    }
}