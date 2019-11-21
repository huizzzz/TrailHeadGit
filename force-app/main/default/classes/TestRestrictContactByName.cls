@isTest
public class TestRestrictContactByName {
    @isTest static void TestRestrictContactByName() {
        // Test data setup
        // Create an account with an opportunity, and then try to delete it
        Contact con = new Contact(LastName='INVALIDNAME');
        
        
        // Perform test
        Test.startTest();
        try{
            insert con;
        }catch(exception e){
            
        }
        
        Test.stopTest();
        // Verify 
        // In this case the deletion should have been stopped by the trigger,
        // so verify that we got back an error.
       
    }
    
}