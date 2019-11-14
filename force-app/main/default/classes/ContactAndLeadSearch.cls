public class ContactAndLeadSearch {
    
    public static List<List<sObject>> searchContactsAndLeads(String a){
        Contact con = new Contact(lastname = 'Smith');
        Lead le = new Lead(lastname = 'Smith',company='test2');
        insert con;
        insert le;
        system.debug('con'+con.LastName);
         system.debug('le'+le.LastName);
        List<List<sObject>> searchList =[find 'Smith' in all fields returning contact(lastname,firstname where lastname =:a or firstname =:a),lead(lastname,firstname where lastname =:a or firstname =:a) ];
        return searchList;
    }

}