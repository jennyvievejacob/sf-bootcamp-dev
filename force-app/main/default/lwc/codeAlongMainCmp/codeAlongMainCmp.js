import { LightningElement } from 'lwc';

export default class CodeAlongMainCmp extends LightningElement {
    showForm = false;
    contactId;

    handleContactSelection(e){
        console.log(e.detail.contactId);
        console.log(e.detail.contactName);
        this.showForm = true;
        this.contactId = e.detail.contactId;
    }

    handleSave(){
        this.showForm = false;
    }
}