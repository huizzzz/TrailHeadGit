trigger AccountTrigger on Account (before insert) {
    
    if(trigger.isBefore && trigger.isInsert){
        AccInsert();
        
        //AccountTriggerHandler.CreateAccounts(AccountTriggerHandler.accList);
        //AccountTriggerHandler.CreateAccounts(AccountTriggerHandler.accList2);
        //
        Map<String,String> canRead = AccountTriggerHandler.getValues();
        system.debug('canRead' + canRead);
    }
    
    public static void AccInsert(){
        List<Account> accList = new List<Account>();
        List<Account> accList2 = new List<Account>();
        
        if(trigger.new[0].name == 'test'){
            accList.add(trigger.new[0]);
        }
        system.debug('AccLi' + accList);
    }
    
    
}