({
	onBoatClick : function(component, event, helper) {
        var boat = component.get("v.boat");
		var bsEvt = component.getEvent("boatselect");
        var BoatSelectedEvt = $A.get('e.c:BoatSelected');
        bsEvt.setParams({"boatId" : boat.Id});
        BoatSelectedEvt.setParams({"boat" : boat});
        bsEvt.fire();
        BoatSelectedEvt.fire();
        
        var plotmapmarkerEvt = $A.get("e.c:PlotMapMarker");
        plotmapmarkerEvt.setParams({"sObjectId" : boat.Id,
                                    "lat" : boat.Geolocation__Latitude__s,
                                    "long" : boat.Geolocation__Longitude__s,
                                    "label" : boat.Name
        });
        plotmapmarkerEvt.fire(); 
	}
})