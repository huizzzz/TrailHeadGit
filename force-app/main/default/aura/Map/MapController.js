({
    jsLoaded: function(component) {
        component.set("v.jsLoaded", true);
    },
    onPlotMapMarker: function(component, event, helper) {
        //update the boat's location 
        console.log('the application map event was handled');
        var lat = event.getParam("lat");
        var long = event.getParam("long");
        console.log("lat", lat);
        console.log("long", long);
        var location = component.get("v.location");
        console.log("location", location);
        location.lat = lat;
        location.long = long;
        component.set("v.location", location);
    }
})