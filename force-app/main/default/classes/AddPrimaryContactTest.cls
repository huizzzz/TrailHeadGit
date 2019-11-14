@isTest
public class AddPrimaryContactTest {
    @testSetup 
    static void setup() {
        List<Account> accsNY = new List<Account>();
        List<Account> accsCA = new List<Account>();
        
        for (Integer i=0;i<50;i++) {
            accsNY.add(new Account(name = 'AccountNY'+i,BillingState = 'NY'));
        }
        for (Integer i=0;i<50;i++) {
            accsCA.add(new Account(name = 'AccountCA'+i,BillingState = 'CA'));
        }
        
        insert accsNY;
        insert accsCA;
    }
    
    static testmethod void testQueueable() {
        // query for test data to pass to queueable class
        Contact con = new Contact(lastName = 'contact');
        insert con;
        // Create our Queueable instance
        AddPrimaryContact Apc = new AddPrimaryContact(con, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();        
        System.enqueueJob(Apc);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from contact where Account.BillingState = 'CA']);
    }
}