trigger ProjectTrigger on Project__c (after update) {
    //Call the Billing Service callout logic here
    if(!system.isFuture()){
        BillingCalloutService.callBillingService(trigger.new,trigger.oldMap);
    }
}