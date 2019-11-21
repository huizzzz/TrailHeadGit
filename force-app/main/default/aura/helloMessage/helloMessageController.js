({
	handleClick : function(component, event, helper) {
		var btnClick = event.getSource();
        var btnMessage = btnClick.get("v.label");
        component.set("v.message",btnMessage);
	}
})