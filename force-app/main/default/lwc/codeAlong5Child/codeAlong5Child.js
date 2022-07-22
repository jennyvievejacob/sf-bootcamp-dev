import { LightningElement, api } from 'lwc';

export default class CodeAlong5Child extends LightningElement {
    _val1
    @api

    get val1(){
        return this._val1;
    }

    set val1(val){
        this._val1 = val + 4
    }
    
    @api val2
    @api val3
    get val4(){
        return this.val3 + this.val2
    }

}