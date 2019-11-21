public class BoatSearchFormAuraCtrl {
    
    @AuraEnabled
    public static List<BoatType__c> getBoatTypes(){
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {'Id', 'Name'};
            
            Map<String,Schema.SObjectField> fieldDescribeTokens = Schema.SObjectType.BoatType__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }
        
        // OK, they're cool, let 'em through
        return [SELECT Id, Name FROM BoatType__c ORDER BY Name];
    }
    
    @AuraEnabled
    public static String getBoatTypeId(String boatTypeName){
        // OK, they're cool, let 'em through
        String BoatTypeId = [SELECT Id FROM BoatType__c where name =:boatTypeName limit 1].id;
        system.debug('zh'+BoatTypeId);
        return BoatTypeId;
        
    }
}