@IsTest
public class AccountsControllerTest {
	@IsTest
    static void getAccountsTest(){
        test.startTest();
        List<Account> accLst = new List<Account>();
        Account acc = new Account(Name = 'test');
        insert acc;
        accLst.add(acc);
        AccountsController.getAccounts();
        AccountTriggerHandler.CreateAccounts(accLst);
        AccountTriggerHandler.AccInsert(accLst);
        test.stopTest();
    }
}