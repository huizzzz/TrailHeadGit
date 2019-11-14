({
	onInit : function(component) {
        var boat = component.get("v.boat");
        var action = component.get("c.getAll");
        action.setParams({ "boatId": boat.Id});
        console.log(boat.Id);
		action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.boatReviews", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
})