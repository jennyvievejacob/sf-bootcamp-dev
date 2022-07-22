import { LightningElement,track } from 'lwc';
import getAccountContact from '@salesforce/apex/ContactController2.getAccountAndContact'


export default class CodeAlong5 extends LightningElement {
    showComponent

    @track textValue = {firstName:'',lastName:''}
    pval1
    pval2
    pval3

    connectedCallback(){
        getAccountContact()
        .then(result =>{
            console.log(result)
        })
        .catch(error =>{
            console.log(error)
        })
    }

    handleChange(evt){
        this.showComponent = evt.target.checked
    }

    handleChange1(evt){
        this.pval1 = evt.target.value
    }

    handleChange2(evt){
        this.pval2 = evt.target.value
    }

    handleChange3(evt){
        this.pval3 = evt.target.value
    }
    
    handleInputChange(e){
        this.textValue.firstName = e.target.value
    }
}