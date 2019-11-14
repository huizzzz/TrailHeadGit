public class BoatSearchResults {

   @AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId){
        // Check to make sure all fields are accessible to this user
        String[] fieldsToCheck = new String[] {'Id', 'Name','BoatType__c'};
            
            Map<String,Schema.SObjectField> fieldDescribeTokens = Schema.SObjectType.Boat__c.fields.getMap();
        
        for(String field : fieldsToCheck) {
            if( ! fieldDescribeTokens.get(field).getDescribe().isAccessible()) {
                throw new System.NoAccessException();
            }
        }

		String query = 'select Id,Name,Description__c,Price__c,Length__c,Contact__r.Name,Contact__r.Email,Contact__r.HomePhone,BoatType__r.Name, Picture__c,Geolocation__Latitude__s,Geolocation__Longitude__s from Boat__c'; 
		query += boatTypeId == null || boatTypeId == 'All types' ?  '': ' WHERE BoatType__r.name = :boatTypeId';        
        // OK, they're cool, let 'em through
        return Database.query(query);
    }
    /*@AuraEnabled
    public static List<Boat__c> getBoats(String boatTypeId) {
        List<Boat__c> boats = new List<Boat__c>();
        if (String.isBlank(boatTypeId) || boatTypeId == 'All types') {
            boats = [select Id,Name,Description__c,Price__c,Length__c,Contact__r.Name,Contact__r.Email,Contact__r.HomePhone,BoatType__r.Name, Picture__c from Boat__c];
        } else{
            boats = [select Id,Name,Description__c,Price__c,Length__c,Contact__r.Name,Contact__r.Email,Contact__r.HomePhone,BoatType__r.Name, Picture__c from Boat__c where BoatType__r.name = :boatTypeId ];
            
        }
        return boats;
        
    }*/
    
}