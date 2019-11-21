@isTest
public class AccountProcessorTest {
    @isTest
    public static void testCountContacts(){
        Account acc = new Account(name = 'testAcc');
        insert acc;
        Contact con = new Contact(Lastname = 'testContact', AccountId = acc.id);
        insert con;        
        Test.startTest();
        List<Id> AccIds = new List<Id>{acc.id};
        AccountProcessor.countContacts(AccIds);
        Test.stopTest();
    }
	
}