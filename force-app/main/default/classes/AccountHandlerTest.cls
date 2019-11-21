@isTest
public class AccountHandlerTest {
	static TestMethod void Acc_UnitTest(){
        test.startTest();
        AccountHandler.insertNewAccount('Name');
        test.stopTest();
    }
    
    static TestMethod void Acc_UnitTestErr(){
        test.startTest();
        String Err = 'ok';
        try{
            AccountHandler.insertNewAccount('');
            Err = 'NG';
        }catch(Exception e){
                system.assertEquals(Err, 'NG');
            }
        
        test.stopTest();
    }
}