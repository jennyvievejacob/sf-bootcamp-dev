import { LightningElement, api } from 'lwc';
import getRecords from '@salesforce/apex/CodeAlongXMLController.getRecords'
export default class CodeAlongXML extends LightningElement {
    @api objectName;
    cardTitle;
    recordList = [];
    searchInput;
    get hasRecords(){ return this.searchInput != '' && this.recordList.length > 0 }
    connectedCallback(){
        this.cardTitle = this.objectName == 'Account' ? 'Account Search' : 'Contact Search';
    }
    handleSearch(event){
        this.searchInput = event.target.value;
        getRecords({
            searchInput: this.searchInput,
            objName: this.objectName
        })
        .then( records => {
            this.recordList = records;
        })
        .catch( error => {
            console.log(error);
        })
    }
}