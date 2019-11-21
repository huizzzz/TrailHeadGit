({  clickCreateItem : function(component, event, helper) {
        var isFormValid = component.find("campingItemForm").reduce(function(isValid, inputCmp){
        	inputCmp.showHelpMessageIfInvalid();    	
            return isValid && inputCmp.get("v.validity").valid;
        });
        
        if (isFormValid) {
            var newCampingItem = JSON.parse(JSON.stringify(component.get("v.newItem")));
            console.log(JSON.parse(JSON.stringify(newCampingItem)), JSON.stringify(newCampingItem));
            var campingItems = JSON.parse(JSON.stringify(component.get("v.items")));
            campingItems.push(newCampingItem);
            component.set("v.newItem",{'sobjectType':'Camping_Item__c',
                'Name': '',
                'Quantity__c': 0,
                'Price__c': 0,
                'Packed__c': false});
            component.set("v.items",campingItems);
        }
	},
  
  handleAddItem: function(component, event, helper) {
      //   var newItem = event.getParam("item");
      //helper.addItem(component, newItem);
      var action = component.get("c.saveItem");
      action.setParams({"item": newItem});
      action.setCallback(this, function(response){
          var state = response.getState();
          if (component.isValid() && state === "SUCCESS") {
              // all good, nothing to do.
              var items = component.get("v.items");
              items.push(response.getReturnValue());
              component.set("v.items", items);
          }
      });
      $A.enqueueAction(action);
  }
})