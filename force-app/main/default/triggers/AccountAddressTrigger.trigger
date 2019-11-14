trigger AccountAddressTrigger on Account (before insert,before update) {
    if(trigger.isBefore && trigger.isInsert){
        for(Account acc : Trigger.new){
            if(String.isNotBlank(acc.BillingPostalCode) && acc.Match_Billing_Address__c){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
    if(trigger.isBefore && trigger.isUpdate){
        for(Account acc : Trigger.new){
            if(String.isNotBlank(acc.BillingPostalCode) && acc.Match_Billing_Address__c){
                acc.ShippingPostalCode = acc.BillingPostalCode;
            }
        }
    }
 
}