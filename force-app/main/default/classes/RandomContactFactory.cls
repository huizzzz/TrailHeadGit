public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(integer i,String s){
        List<Contact> con = new List<Contact>();
        for(integer a = 0 ; a < i; a++){
            Contact contact = new Contact(firstname = String.valueOf(a),lastname = s);
            con.add(contact);
        }
        return con;
    }
}