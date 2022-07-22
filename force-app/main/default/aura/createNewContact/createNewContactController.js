({
    saveContact : function(component, event, helper) {
        var acctId = component.get("v.recordId");
        var fname = component.get("v.fname");
        var lname = component.get("v.lname");
        
        //call action
        var action = component.get("c.insertContact");
        action.setParams({
            acctId: acctId,
            fName: fname,
            lName: lname
        })
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                console.log("Contact inserted");
                //Clear fields
                component.set("v.fname",'');
                component.set("v.lname",'');
                //Show Toast
                var toastEvent = $A.get("e.force:showToast");
                toastEvent.setParams({
                    "message": "Contact has been created successfully",
                    type: "success"
                });
                toastEvent.fire();
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
    clearFields : function(component, event, helper) {
        component.set("v.fname",'');
        component.set("v.lname",'');
    },
    doInit : function(component, event, handler){
        var accId = component.get("v.recordId");
        console.log("accID: " + accId);
        
        //call action
        var action = component.get("c.getAccount");
        action.setParams({
            acctId: accId
        })
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var accName = response.getReturnValue().Name;
                console.log("accName: " + accName);
                //Display account name to account name field
                component.set("v.acctName", accName);
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
    }
})