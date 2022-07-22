import { LightningElement, api } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import CON_FNAME from '@salesforce/schema/Contact.FirstName';
import CON_LNAME from '@salesforce/schema/Contact.LastName';
import CON_NICKNAME from '@salesforce/schema/Contact.Nickname__c';

export default class CodeAlong2 extends LightningElement {
    //declare global var
    contactObject = CONTACT_OBJECT.objectApiName; //=="Contact"
    fname = CON_FNAME.fieldApiName; //== "FirstName"
    lname = CON_LNAME.fieldApiName; //== "LastName"
    nickname = CON_NICKNAME.fieldApiName; 
    
    @api contactId;

    //showForm = false;

    handleAutoCreate(){
        createRecord({
            apiName: this.contactObject,
            fields: {
                [this.fname]: "Jen",
                [this.lname]: "Jacob",
                [this.nickname]: 'Jen'
            }
          })                                               
          .then(res => {
            console.log(res);
          })
          .catch(error => {
            console.log(error);
          })
    }

    connectedCallback(){
      console.log('created');
    }

    renderedCallback(){
      console.log("rendered");
    }

    disconnectedCallback(){
      console.log("disconnect");
    }

    /*handleCreateContact(){
        this.showForm = true;
    }
    */

    handleSuccess(){
      this.dispatchEvent(new CustomEvent('savecontact'));
    }
}