({
    onSearch : function(component) {
        // Create the action
        var boatTypId = component.get("v.boatTypeId");
        var action = component.get("c.getBoats");
        action.setParams({ "boatTypeId": boatTypId});
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.Boats", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
})