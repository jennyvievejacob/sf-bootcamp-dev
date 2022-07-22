import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_NUM from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_SITE from '@salesforce/schema/Account.Site';

import getAccountRecord from '@salesforce/apex/AccountController.getAccountRecord';
import getRelatedContacts from '@salesforce/apex/AccountController.getRelatedContacts';

export default class DetailsCmp extends LightningElement {
    accountName = ACCOUNT_NAME;
    accountNumber = ACCOUNT_NUM;
    accountSite = ACCOUNT_SITE;

    //views
    showEditForm = false;
    showViewForm = true;
    
    //buttons, fields
    showBackButton = true;
    showEditButton = true;
    showSearchBox = true;

    @api searchInput;
    record;
    //Var holding values from apex
    @api accId
    accName = '';
    accNum = '';
    accSite = '';
    //hold related contact data
    relatedContacts = [];

    //check if related contacts is has no data
    get hasRecords(){ 
        return this.relatedContacts.length > 0 
    }
    
    //Use wire to get data from apex
    @wire(getAccountRecord, {searchInput: '$searchInput'}) 
    //check data
    accRecord ({ error, data }) {
        if (data){
            console.log(data);
            this.record = data;
            //Assign values to vars
            this.accId = this.record.Id;
            this.accName = this.record.Name;
            this.accNum = this.record.AccountNumber;
            this.accSite = this.record.Site;
            //show edit form
            this.showEditForm = true;
        }
        else if (error) {
            console.log('Error: ', error);
            //hide form
            this.showEditForm = false;
        }
    }

    //get contact related list via accID
    @wire(getRelatedContacts, {accId: '$accId'}) 
    relContactList({data,error}){
        if(data){
            console.log("getRelatedContacts: "+data);
            this.relatedContacts = data;
        }
        else {
            console.log("error: "+error);
        }
    }

    handleSuccess(){
        console.log('handleSuccess clicked');
        this.dispatchEvent(new ShowToastEvent({
            message: "Account has been updated",
            variant: "success",
            }),  
        );   
        //hide edit form
        this.showEditForm = false;
        //show view form & back button
        this.showViewForm = true;
        this.showBackButton = true;
        this.showSearchBox = false;
    } 

    onKeyPressAccId(e){
        if(e.target.value !== "")
            this.searchInput = e.target.value;
        else
            this.showEditForm = false;
    }

    onClickBack(){
        //call to display search
        this.dispatchEvent(new CustomEvent('back'));
    }

    onClickEdit(){
        this.showEditForm = true;
        this.showViewForm = false;
    }
}