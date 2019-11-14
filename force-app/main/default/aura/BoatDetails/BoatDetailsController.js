({
    onBoatSelected : function(component, event, helper){
        var boat = event.getParam("boat");
        component.set("v.boat", boat);
        component.set("v.id", boat.id);
        //var service = component.find("service");
        //service.reloadRecord() ;
        console.log("v.boat"+component.get("v.boat"));
    },
    onRecordUpdated : function(component, event, helper) {
        
    },
    onBoatReviewAdded : function(component, event, helper) {
        console.log('Event received');
        component.find("details").set("v.selectedTabId", "boatreviewtab");	 
        //component.find("BoatReviews").refresh();	 
        debugger
        var BRcmp = component.find("BRcmp");
        console.log(BRcmp);
        var auraMethodResult = BRcmp.refresh();	 
    }
})