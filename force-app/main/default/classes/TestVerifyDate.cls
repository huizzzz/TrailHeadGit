@isTest
public class TestVerifyDate {
    @isTest static void testCheckDates01() {
        Date testDate = VerifyDate.CheckDates(Date.today(),date.today()+1);
    }
    
    @isTest static void testCheckDates02() {
        Date testDate = VerifyDate.CheckDates(Date.today(),date.today()+31);
    }
}