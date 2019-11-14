trigger MaintenanceRequest on Case (before update, after update) {
    // call MaintenanceRequestHelper.updateWorkOrders  
    if(Trigger.isBefore && Trigger.isUpdate){
        MaintenanceRequestHelper.updateWorkOrders(Trigger.new,Trigger.oldMap);
    }
}