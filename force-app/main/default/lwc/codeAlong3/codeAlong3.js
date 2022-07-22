import { LightningElement, wire } from 'lwc';
import getContactRecords from '@salesforce/apex/ContactController2.getContactList';

export default class CodeAlong3 extends LightningElement {
    searchInput
    showNoResult=true;
    contactList

    //|| this.searchInput !== '' || !data || data !== ""

    @wire(getContactRecords, {searchInput: '$searchInput'}) 
    contactList({data,error}){
        if(this.searchInput == '' 
           || !data
           || data == []
           || data.length === 0){
                this.showNoResult = true;
                console.log("null: "+data);
        }
        else {
            this.showNoResult = true;
            console.log("null: "+data);
            this.showNoResult = false;
            this.contactList = data;
        }
            
    }
    
    handleSearch(event){
        this.searchInput = event.target.value;
    }

    handleViewDetails(e){
        var selectedContactId = e.currentTarget.dataset.id;
        var selectedContactName = e.currentTarget.dataset.name;

        //send custom event
        //instantiate CustomEvent
        var selectedContactEvent = new CustomEvent('selected', {
            detail: {contactId: selectedContactId,
            contactName: selectedContactName}});
        //dispatch CustomEvent
        this.dispatchEvent(selectedContactEvent);
    }
}