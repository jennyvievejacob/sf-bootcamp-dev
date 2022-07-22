import { LightningElement, api, wire } from 'lwc';

export default class MainCmpExercise extends LightningElement {
    showForm = false;
    @api accId

    handleAccountSelection(e){
        //show view form
        console.log(e.detail.accId);
        console.log(e.detail.accName);
        this.showForm = true;
        this.accId = e.detail.accId;
    }

    showSearchCmp(){
        this.showForm = false;
    }
}