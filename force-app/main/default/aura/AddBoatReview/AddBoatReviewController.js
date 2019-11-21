({
	doInit : function(component, event, helper) {
		helper.onInit(component);
	},
    onRecordUpdated : function (component, event , helper ) {
        var eventParams = event.getParams();
        if(eventParams.changeType === "CHANGED") {
            var resultsToast = $A.get("e.force:showToast");
            if(resultsToast) {
                resultsToast.setParams({
                    "title": "Saved",
                    "message": "The record was saved."
                });
                resultsToast.fire();
            } else {
                alert("The record was saved");
            }
        }
    },
    onSave : function(component, event, helper) {
        component.find("service").saveRecord(function(saveResult) {
            if (saveResult.state === "SUCCESS" || saveResult.state === "DRAFT") {
                
                // record is saved successfully
                var resultsToast = $A.get("e.force:showToast");
                if(resultsToast) {
                    resultsToast.setParams({
                        "title": "Saved",
                        "message": "Boat Review Created."
                    });
                    resultsToast.fire();
                } else {
                    alert("Boat Review Created");
                }            
                var newBoatReviewAddedEvent = component.getEvent("BoatReviewAdded");
                newBoatReviewAddedEvent.fire();
                helper.onInit(component);
            } else if (saveResult.state === "INCOMPLETE") {
                // handle the incomplete state
                console.log("User is offline, device doesn't support drafts.");
            } else if (saveResult.state === "ERROR") {
                // handle the error state
                console.log('Problem saving contact, error: ' + 
                            JSON.stringify(saveResult.error));
            } else {
                console.log('Unknown problem, state: ' + saveResult.state +
                            ', error: ' + JSON.stringify(saveResult.error));
            }
        });
    },
    onBoatSelected : function(component, event, helper){
        var boat = event.getParam("boat");
        component.set("v.boat", boat);
        console.log("v.boat"+component.get("v.boat"));
        helper.onInit(component);
        //var service = component.find("service");
        //service.reloadRecord() ;
    },
})