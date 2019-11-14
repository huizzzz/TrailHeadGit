public class AccountHandler {

    public static Account insertNewAccount(String Name){
        try{
            Account acc = new Account(name = Name); 
            insert acc;
            return acc;
        }catch(DmlException e){
            System.debug('A DML exception has occurred: ' + e.getMessage());
            return null;
        }
        
    }
}