public class DriversLicense {
    public static integer licenseNum = 0;
    
    public DriversLicense(){
       licenseNum++;
    }
    
    public string getFullname(string lastName, string firstName, string middleName){
        return 'FULLNAME: ' + lastName.toUpperCase() + ', ' + firstname.toUpperCase() + ' '+ middleName.toUpperCase();
    }
    
    public string getFullAddress(string no, string st, string city, string mun, string prov){
        return 'ADDRESS: ' + no + ' ' + st.toUpperCase() + ', ' + city.toUpperCase() + ', ' + mun.toUpperCase() + ', ' + prov.toUpperCase(); 
    }
    
    public string getOtherInfo(date bdate, string gender, string height, string weight, string nationality){
        return 'BIRTHDATE: ' + bdate + '\nGENDER: ' + gender + ' \n' + height + ' cm ' + weight + ' kg\nNATIONALITY: ' + nationality.toUpperCase();
    }
    
    public string getDLRestrix(string restrix, string conditions, string agy){
        return 'RESTRICTION: ' + restrix.toUpperCase() + '\nCONDITIONS: ' + conditions.toUpperCase() + '\nAGY: ' + agy.toUpperCase();
    }
    
    public datetime getExpiry(datetime regDate){
        return regDate.addYears(5);
    }
}