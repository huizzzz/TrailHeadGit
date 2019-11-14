trigger ClosedOpportunityTrigger on Opportunity (before insert,before update) {

    if(trigger.isbefore && trigger.isInsert){
        List<Task> childTasks = new List<Task>();
        for(Opportunity opp : trigger.new){
            if(opp.StageName.equals('Closed Won') ){
                childTasks.add(new Task(subject = 'Follow Up Test Task'
                                        , WhatId = opp.Id)
                              );
            }
        }
        if(childTasks.size() > 0){
            insert childTasks;
        }
    }
    if(trigger.isbefore && trigger.isUpdate){
        List<Task> childTasks = new List<Task>();
        for(Opportunity opp : trigger.new){
            if(opp.StageName.equals('Closed Won') ){
                childTasks.add(new Task(subject = 'Follow Up Test Task'
                                        , WhatId = opp.Id)
                              );
            }
        }
        if(childTasks.size() > 0){
            insert childTasks;
        }
    }
}