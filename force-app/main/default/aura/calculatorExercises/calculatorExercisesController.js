({
    getContact : function(component, event, helper) {
        var action = component.get("c.getFilteredContacts");
        var searchString = component.get("v.searchString");
        action.setParams({
            searchKey: searchString,
            numOfRecords: 10
        })
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                component.set("v.contactList", response.getReturnValue())
            }
            else if(state === "ERROR"){
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
})