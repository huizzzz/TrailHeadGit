public class AddPrimaryContact implements Queueable{
    private Contact contact;
    private String st;
    
    public AddPrimaryContact(Contact record, String st) {
        this.contact = record;
        this.st = st;
    }
    public void execute(QueueableContext context) {
        list<Contact> cons = new list<Contact>();
        List<Account> accs = [select id from account where BillingState =: st limit 200];
        for(Account a : accs){
            Contact cont = contact.clone(false,false,false,false);
            cont.AccountId = a.id;
            cons.add(cont);
        }
        insert cons;
    }

}