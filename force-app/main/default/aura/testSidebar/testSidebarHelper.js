({
	/*initHandler : function(component) {
        console.log('---initHandler() start!!!');

        
        var action = component.get("c.getListViewMultiMap");
        action.setCallback(this, function(response) {
            if (action.getState() == "SUCCESS") {
                var reLst = [];
                var result = response.getReturnValue();
                //component.set("v.title", url + result);
                for(var key in result){
                    reLst.push({value:result[key], key:key});
                }
                component.set('v.myList',reLst);
                console.log('title:', result);
            }
        });
        $A.enqueueAction(action);

    },*/
    initHandler : function(component) {
        console.log('---initHandler() start!!!');
        var action = component.get("c.getListViewLST");
        action.setCallback(this, function(response) {
            if (action.getState() == "SUCCESS") {
                var result = response.getReturnValue();
                //component.set("v.title", url + result);
                component.set('v.lvList',result);
                console.log('title:', result);
            }
        });
        $A.enqueueAction(action);

    },
})