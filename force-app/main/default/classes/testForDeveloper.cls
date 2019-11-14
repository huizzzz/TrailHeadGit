public class testForDeveloper {
    public ApexPages.StandardSetController ssc  { get; private set; }     // standardSetController ページングで使用
    private static final Integer LIMIT_ROWS_PER_PAGE = 300;
    public testForDeveloper(){
        String testName = Userinfo.getUserId();
        System.debug('testName' +testName);
        String testName2 = AppLauncher.CommunityLogoController.getCommunityName();
        System.debug('testName2' +testName2);
        //ApexPages.StandardSetController ssc = new ApexPages.StandardSetController();
        string testUrl = apexpages.currentPage().getParameters().put('id','1234567');
        system.debug('testUrl'+testUrl);
        
    }
    /*private void init(){
        String queryStr =
        'Select' +
        ' Id,JisuiSelectFlg__c,OrdersQuantity__c,Katashiki__c,OrdersAmount__c,OrderBenefit__c,OrdersDate_tuika__c,'+
        'SalesDate_tuika__c,BudgetAccuracy__c,OrdersAccuracy__c,Nounyusaki__c,FreeSpace__c,BudgetStatus__c,BRSelectList__c,isStockedFlg__c,addFixed__c,'+
        'HSL_SupportStartMonth__c,HSL_SupportEndMonth__c,HSL_isMaintainanceFlg__c,HSL_ProductSort__c,Shokusei__c,Opportunity__c,'+
        'CAS_Phase__c,CAS_GenkouMaker__c,CAS_GenkouSouchi__c,CAS_HouseOrCollaboration__c,CAS_Keijo__c,sinchokuYosan__c,CAS_Supplier__c,CAS_TeianMaker__c,CAS_TeianSouchi__c,CAS_NounyuuMaker__c,CAS_NounyuuSouchi__c,CAS_Kubun__c'+ // 2017/09/19 toshima add CAS使用項目
        ' from T_BudgetResults__c'+
        ' where'+
        ' RecordType.Name =:Yosan' +
        ' AND HeaderBudgetResults__c = null'+
        ' AND Opportunity__c =: Oppid' +
        ' AND HSL_OrdersBudget__c = null'+ // 2017/09/05 toshima add HSLの保守案件の案分で作成した予実は表示しないようにする
        ' order by createdDate asc';
         List<Account> tmpAllList = new List<Account>();
        ssc = new Apexpages.StandardSetController( Database.getQueryLocator(queryStr));
        ssc.setPageSize(LIMIT_ROWS_PER_PAGE);
        //ssc.setPageSize(10);
        tmpAllList = ssc.getRecords().deepClone();
        String url = apexpages.currentPage().getParameters().get('id');

    }*/
    public static void testNameSpace(){
        String myString = 'StringToBlob';
        Blob myBlob = Blob.valueof(myString);
        Integer size = myBlob.size();
        system.debug('size' + size);
        
        String pdfContent = 'This is a test string';
        Account a = new account(name = 'test');
        insert a;
        Attachment attachmentPDF = new Attachment();
        attachmentPdf.parentId = a.id;
        attachmentPdf.name = a.name + '.pdf';
        attachmentPdf.body = blob.toPDF(pdfContent);
        insert attachmentPDF;
        system.debug('attachmentPDF' + attachmentPDF);
    }
    
    public static void testBusinessHoursClass(){   
        // Get the default business hours
        BusinessHours bh = [SELECT Id FROM BusinessHours WHERE IsDefault=true];
        
        // Create Datetime on May 28, 2019 at 1:06:08 AM in the local timezone.
        Datetime targetTime = Datetime.newInstance(2019, 5, 28, 1, 6, 8);
        
        // Find whether the time is within the default business hours
        Boolean isWithin= BusinessHours.isWithin(bh.id, targetTime);
        
        // if it is within the business hours. The returned time will be in the local time zone
        Datetime nextStart = BusinessHours.nextStartDate(bh.id, targetTime);
        system.debug('nextStart' + nextStart);
    }
    
    public static void testAppMenuClass(){ 
        List<AppMenuItem> ami = [select id from AppMenuItem];
        List<Id> ids = new List<Id>();
        if(ami.size() > 0){
            for(AppMenuItem temp : ami){
                String idTemp = temp.id;
                ids.add(idTemp);
            }
        }
        AppLauncher.AppMenu.setOrgSortOrder(ids);
    }
    
    public static void testPattern(String value){
        Boolean result = Pattern.matches('[^ -~｡-ﾟ]+', value);
        system.debug('result' + result);
        Pattern p = Pattern.compile('[^ -~｡-ﾟ]+');
        system.debug('p' + p);
        result = Pattern.compile('[^ -~｡-ﾟ]+').matcher(value).matches();
        system.debug('result' + result);
    }
    
    public static void testStringCls(){
        String test = 'this is a test string for method String.abbreviate(5)';
        String testabbreviate = 'this is a test string for method String.abbreviate(5)';
        system.debug('testabbreviate_bef' +testabbreviate);
        testabbreviate = testabbreviate.abbreviate(5).capitalize();
        system.debug('testabbreviate_aft' +testabbreviate);
        String testcenter = test.center(10);
        system.debug('testcenter' +testcenter);
    }
}