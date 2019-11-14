public class AccountProcessor {
    @future(callout=true)
    public static void countContacts(List<Id> AccIds){
        List<Account> accs = [select id,Number_of_Contacts__c,(select id from contacts ) from account where id in :AccIds ];
        for(Account acc : accs){
            acc.Number_of_Contacts__c = acc.contacts.size();
        }
        update accs;
    }

}