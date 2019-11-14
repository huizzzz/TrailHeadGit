@isTest
public class DailyLeadProcessorTest {
    
    public static String CRON_EXP = '0 0 1 * * ?';
    static testMethod void testScheduledJob() {
        List<Lead> leads = new List<Lead>();
        
        for (Integer i=0;i<200;i++) {
            leads.add(new Lead(LastName = 'Lead' + i,Company = 'Tokyo'));
        }
        insert leads;
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new DailyLeadProcessor());         
        // Stopping the test will run the job synchronously
        Test.stopTest();
        System.assertEquals(200, [select count() from lead where leadsource = 'Dreamforce']);
        
    }
}