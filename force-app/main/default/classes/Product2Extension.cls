public class Product2Extension {

    public List<ProductWrapper> productsToInsert {get;set;}

    public Product2Extension(ApexPages.StandardController controller){
        productsToInsert = new List<ProductWrapper>();
        addRows();
    }

    public void AddRows(){
        for ( Integer i=0; i<Constants.DEFAULT_ROWS; i++ ){
            productsToInsert.add( new ProductWrapper());
        }
    }
    
    public List<SelectOption> GetFamilyOptions(){
        List<SelectOption> FamilyOptions = new List<SelectOption>();
        FamilyOptions.add(new SelectOption(Constants.SELECT_ONE,Constants.SELECT_ONE));
        For(Schema.PicklistEntry pe : Constants.PRODUCT_FAMILY){
            FamilyOptions.add(new SelectOption(pe.getLabel(),pe.getValue()));
        }
        return FamilyOptions;
    }

    public List<ChartHelper.ChartData> GetInventory(){
        return ChartHelper.GetInventory();
    }

    public PageReference Save(){
        SavePoint sp = Database.setSavepoint();
        try {
            Map<integer,product2> productMap = new Map<integer,product2>();
            Map<Integer, PriceBookEntry> priceBookEntries = new Map<Integer, PriceBookEntry>();    
            Integer index = 0;
            if(productsToInsert.size() > 0){
                for(ProductWrapper pw : productsToInsert){
                    if(String.isNotBlank(pw.productRecord.Name) && pw.pricebookEntryRecord.UnitPrice!=null && 
                       pw.productRecord.Initial_Inventory__c!=null && pw.productRecord.isActive && 
                       pw.productRecord.Initial_Inventory__c != 0 && pw.pricebookEntryRecord.UnitPrice!=0){
                           productMap.put(index,pw.productRecord);
                           priceBookEntries.put(index, pw.pricebookEntryRecord);
                           index++; 
                       }
                }
                if(productMap.size() > 0){
                    insert productMap.Values();
                    for(integer i : productMap.keySet()){
                        priceBookEntries.get(i).Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
                        priceBookEntries.get(i).Product2Id = productMap.get(i).id;
                        priceBookEntries.get(i).isActive = true;
                    }
                    
                    insert priceBookEntries.Values();
                }      
            }
            //If successful clear the list and display an informational message
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,productMap.size()+' Inserted'));
            productsToInsert.clear();   //Do not remove
            addRows();  //Do not remove
        } catch (Exception e){
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.ERROR,Constants.ERROR_MESSAGE));
            Database.rollback(sp);
        }
        return null;
    }
    
    public class ProductWrapper{
        public Product2 productRecord{get; set;}
        public PriceBookEntry pricebookEntryRecord{get; set;}
        
        public ProductWrapper() {
            productRecord = new Product2(Initial_Inventory__c =0);
            pricebookEntryRecord = new PricebookEntry(Unitprice=0.0);
        }
    }

}