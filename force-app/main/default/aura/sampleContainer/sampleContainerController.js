({
	handleClick : function(cmp, event, helper) {
		var fName = cmp.get("v.fName");
        var lName = cmp.get("v.lName");
        cmp.set("v.fullname", fName + ' ' + lName);
        alert(fName + ' ' + lName);
	}
})