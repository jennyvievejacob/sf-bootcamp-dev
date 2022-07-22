({
    onSave : function(component, event, helper) {
        var action = component.get("c.saveContact");
        var contact = component.get("v.con");
        action.setParams({
            con : contact
        })
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                console.log(response.getReturnValue());
                var cmpEvent = component.getEvent("refreshList");
                console.log('event fired')
                cmpEvent.fire();
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})