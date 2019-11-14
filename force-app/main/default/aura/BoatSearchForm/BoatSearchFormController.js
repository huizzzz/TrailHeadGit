({
    doInit : function (component, event, helper) {
        //component.set("v.showNewButton",$A.get("e.force:createRecord"));
        helper.loadBoatTypes(component);
    },
    New : function (component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "boat__c",
        });
        var BoatType = component.get("v.selectboatType");
        var action = component.get("c.getBoatTypeId");
        action.setParams({"boatTypeName": BoatType
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var BoatTypeId  = response.getReturnValue();
                if(! BoatTypeId == ""){
                    createRecordEvent.setParams({
                        "defaultFieldValues": {
                            'BoatType__c' : BoatTypeId
                        }
                    });
                }
                createRecordEvent.fire();
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    handleChange : function(component, event, helper){
        component.set("v.selectboatType", component.find("boatTypes").get("v.value"));
        //component.set("v.showNewButton",true);
    },
    onFormSubmit: function(component, event, helper) {
        var boatTypeId = component.get("v.selectboatType");
        var formSubmitevt = component.getEvent("formsubmit");
        formSubmitevt.setParams({"formData":
                                 {"boatTypeId" : boatTypeId}
                                });
        formSubmitevt.fire();
    },
})