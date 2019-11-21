public class AccountUtils {
    
    public static List<Account> accountsByState(String BillState){
        return (new list<Account> ([select id,name from account where BillingState =: BillState]));
    }
}