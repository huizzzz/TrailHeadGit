public class AccountTriggerHandler {
    public static List<Account> accList;
    public static List<Account> accList2;
    
    public static void CreateAccounts (List<Account> AccLi){
        system.debug('AccLi.size()' + AccLi.size());
        for(Account acc:AccLi){
            acc.ShippingState = acc.BillingState;
            //insert acc;
        }
    }

    public static void AccInsert(List<Account> newObjects){
        accList = new List<Account>();
        accList2 = new List<Account>();
        for(Account acc : newObjects){
            if(acc.name == 'test'){
                accList.add(acc);
            }else{
                accList2.add(acc);
            }
        }
    }
    
    
    public static Map<String, String> getValues(String objectType, String recordTypeId, String fieldName) {
    //Endpoint
        String endpoint = URL.getSalesforceBaseUrl().toExternalForm();
        endpoint += '/services/data/v46.0';
        endpoint += '/ui-api/object-info/{0}/picklist-values/{1}/{2}';
        endpoint = String.format(endpoint, new String[]{ objectType, recordTypeId, fieldName });
        EncodingUtil.urlEncode(endpoint,'UTF-8');
        
        //HTTP Request send
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'OAuth ' + UserInfo.getSessionId()); 
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        //Parse response
        Map<String,String> result = new Map<String,String>();
        Map<String,Object> root = (Map<String,Object>) JSON.deserializeUntyped(res.getBody());
        if(!root.containsKey('values')){ 
            return result; 
        }
        List<Object> pValues = (List<Object>)root.get('values');
        for(Object pValue : pValues){
            Map<String,Object> pValueMap = (Map<String,Object>)pValue;
            result.put((String)pValueMap.get('value'), (String)pValueMap.get('label'));
            System.debug(result);
        }
        
        return result;
    }
}