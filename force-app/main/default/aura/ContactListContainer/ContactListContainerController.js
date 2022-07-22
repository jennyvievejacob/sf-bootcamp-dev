({
    doInit : function(component, event, helper) {
        helper.getDataContacts(component);
    },
    getContact : function(component, event, helper) {
        var action = component.get("c.getFilteredContacts");
        var searchString = component.get("v.searchString");
        if(searchString == ' '){
            searchString = 'j'
        }
        action.setParams({
            searchKey : searchString,
            numOfRecords : 5
        })
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.contactList", response.getReturnValue())
                response.getReturnValue().forEach( element => {
                    console.log(element.Name);
                })
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
    },
    handleShowForm : function(component, event, handler){
        console.log('handleShowForm');
        component.set("v.showHideForm", true);
    },
    onRecordSave : function(component, event, handler){
        console.log('onRecordSave');
        helper.getDataContacts(component);
        component.set("v.showHideForm",false)
    },
    handleShowAll : function(component, event, handler){
        console.log('handleShowAll');
        var appEvent = $A.get("e.c:ShowAllDetails");
        appEvent.setParams({
            "showAllDetails" : true});
        appEvent.fire();
    },
    handleHideAll : function(component, event, handler){
        console.log('handleHideAll');
        var appEvent = $A.get("e.c:ShowAllDetails");
        appEvent.setParams({
            "showAllDetails" : false});
        appEvent.fire();
    }
})