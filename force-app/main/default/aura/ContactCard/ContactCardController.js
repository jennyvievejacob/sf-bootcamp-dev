({
	handleShowDetails : function(component, event, helper) {
		var showDetailState = component.get("v.showDetails");
        component.set("v.showDetails", !showDetailState);
	},
    handleApplicationEvent : function(component, event, helper) {
		var showDetailState = component.get("showAllDetails");
        component.set("v.showDetails", showDetailState);
	},
})