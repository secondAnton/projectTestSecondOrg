public class TwilioSMSHelper {
    private static Set<Id> alreadyProcessedAccount = new Set<Id>();
    public static Set<Id> accountSMSIdSet = new Set<Id>();
    private static SettingsTwilio__c twilioSettings = SettingsTwilio__c.getValues('Twilio');
    private static AccountStatus__c accountStatus = AccountStatus__c.getValues('Client Status');
    
    public static void handleTrigger(List<Account> updatedAccountRecords, System.TriggerOperation triggerEvent) {
        for (Account account : updatedAccountRecords) {
            if (!alreadyProcessedAccount.contains(account.Id)) {
                alreadyProcessedAccount.add(account.Id);
                if (isSMSRequired(account)) {
                     accountSMSIdSet.add(account.Id);
                     account.Is_Gold_SMS_sended__c = true;
                }
                else {
                     system.debug('NO SMS Send Action');
                }
            }
        }
        sendSMS(accountSMSIdSet);
    }
    
    @future(Callout = true)
    public static void sendSMS(Set<Id> setAccountId) {
        List<Account> accountSendSMSList = getAccounts(setAccountId);
        
        for(Account account : accountSendSMSList) {
            Http http = new Http();
        	HTTPResponse response = http.send(getHttpRequest(account));
        	system.debug(response.getBody());        
            if(response.getStatusCode()==201) {
        		system.Debug('Message sending Successful');  
            }
        	else {            
            	system.Debug('Message sending Unsuccessful');
        	}        
        }
    }
    
    private static List<Account> getAccounts(Set<Id> setAccountId) {
        return [SELECT Phone, Is_Gold_SMS_sended__c 
                FROM Account 
                WHERE Id IN : setAccountId];
    }
    
    private static HttpRequest getHttpRequest(Account account) {
        String toPhoneNumber = account.Phone;     
        String twilioAccount = twilioSettings.ACCOUNT_SID__c;
        String twilioToken = twilioSettings.AUTH_TOKEN__c;
        String twilioPhoneNumber = twilioSettings.Phone_Number__c;
        String smsText = twilioSettings.SMS_Text__c;
        String VERSION  = twilioSettings.VERSION__c; 
        String firstPartURL = twilioSettings.Twilio_URL_First_Part__c;
        String secondPartURL = twilioSettings.Twilio_URL_Second_Part__c;
       
        HttpRequest request = new HttpRequest(); 
        request.setEndpoint(firstPartURL + twilioAccount + secondPartURL);
        request.setMethod('POST');
        request.setHeader('X-Twilio-Client', 'salesforce-' + VERSION);        
        request.setHeader('User-Agent', 'twilio-salesforce/' + VERSION);       
        request.setHeader('Accept', 'application/json');        
        request.setHeader('Accept-Charset', 'utf-8'); 
        request.setHeader('Authorization','Basic '+EncodingUtil.base64Encode(Blob.valueOf(twilioAccount + ':' + twilioToken))); 
        request.setBody('To='+EncodingUtil.urlEncode(toPhoneNumber, 'UTF-8') + '&From=' + EncodingUtil.urlEncode(twilioPhoneNumber, 'UTF-8') + '&Body=' + smsText);
        return request;
    }
	
    @TestVisible
    private static Boolean isSMSRequired(Account account) {
        Boolean isSMSRequired = false;
        
        if (account.Customer_Status__c == accountStatus.GOLD_STATUS__c && !account.Is_Gold_SMS_sended__c && !String.isBlank(account.Phone)) {
            isSMSRequired = true;
        }
        return isSMSRequired;
    }
}