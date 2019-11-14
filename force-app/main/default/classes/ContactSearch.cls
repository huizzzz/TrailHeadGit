public class ContactSearch {
    public static List<contact> searchForContacts(String a,String b){
        List<contact> contactTest = [select id,name from contact where 	lastname=:a and MailingPostalCode =: b];
        return contactTest;
    }

}