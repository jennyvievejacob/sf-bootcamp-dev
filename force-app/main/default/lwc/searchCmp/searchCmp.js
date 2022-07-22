import { LightningElement, wire, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccountRecords from '@salesforce/apex/AccountController.getAccountList';

import ACCOUNT_NAME from '@salesforce/schema/Account.Name';
import ACCOUNT_NUM from '@salesforce/schema/Account.AccountNumber';
import ACCOUNT_SITE from '@salesforce/schema/Account.Site';
import TickerSymbol from '@salesforce/schema/Account.TickerSymbol';

export default class SearchCmp extends LightningElement {
    @api Account;

    showForm = false;
    accId;
    accList
    searchInput
    showTable=false;
    showNoResult=false;

    showCreateRec = false;
    showSearch = true;
    showCreateBtn = true;
    showBackBtn = false;
    showRecordView = false;

    @api newAccId;

    @wire(getAccountRecords, {searchInput: '$searchInput'}) 
    accountWired({data,error}){
        if(data){
            if (this.searchInput != '' && data.length === 0)
            {
                console.log("no match")
                this.accList = data;
                this.showTable = false;
                this.showNoResult=true;
            }
            else if(this.searchInput.length == 0 && data.length == 0){
                console.log("empty search")
                this.accList = data;
                this.showTable = false;
                this.showNoResult=false;
            }
            else {
                console.log("has data")
                this.accList = data;
                this.showTable = true;
            }
        } else
            console.log(error);  
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Account created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.newAccId = event.detail.id;
        this.dispatchEvent(evt);
        //show record view
        this.showRecordView = true;
        //hide record-edit form
        this.showCreateAcc = false;
    }

    handleSearch(event){
        this.searchInput = event.target.value;
    }

    handleViewDetails(e){
        console.log("handleViewDetails searchCmp");
        var selectedAccId = e.currentTarget.dataset.id;
        var selectedAccName = e.currentTarget.dataset.name;

        //send custom event
        //instantiate CustomEvent
        var selectedAccEvent = new CustomEvent('selected', {
            detail: {
                accId: selectedAccId,
                accName: selectedAccName
            }});
        //dispatch CustomEvent
        this.dispatchEvent(selectedAccEvent);
    }

    onClickCreateAccount(){
        console.log(this.newAccId);
        console.log("onClickCreateAccount");
        this.showSearch = false;
        this.showCreateAcc = true;
        this.showCreateBtn = false;
        this.showBackBtn = true;
    }

    onClickBack(){
        console.log("onClickBack");
        this.showSearch = true;
        this.showCreateAcc = false;
        this.showCreateBtn = true;
        this.showBackBtn = false;
    }
}