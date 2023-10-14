@isTest
private class TestTwilioSMSHelper {
    
    @testSetup static void setup() {
        SettingsTwilio__c twilioSettings = new SettingsTwilio__c();
        twilioSettings.Name = 'Twilio';
        twilioSettings.ACCOUNT_SID__c = 'AC91b3a7891d1045ca15c4bb8f6b4410c0';
        twilioSettings.AUTH_TOKEN__c = '205e7fabb797c64929c7174d8f13ce43';
        twilioSettings.Phone_Number__c = '14792268921';
        twilioSettings.SMS_Text__c = 'Now you have a GOLD status. Regards.';
        twilioSettings.Twilio_URL_First_Part__c = 'https://api.twilio.com/2010-04-01/Accounts/';
        twilioSettings.Twilio_URL_Second_Part__c = '/SMS/Messages.json';
        twilioSettings.VERSION__c = '3.2.0';
        insert twilioSettings;
        
        AccountStatus__c accountStatus = new AccountStatus__c();
        accountStatus.Name = 'Client Status';
        accountStatus.BRONZE__c = 25000;
        accountStatus.BRONZE_STATUS__c = 'BRONZE';
        accountStatus.GOLD__c = 50000;
        accountStatus.GOLD_STATUS__c = 'GOLD';
        accountStatus.SILVER__c = 10000;
        accountStatus.SILVER_STATUS__c = 'SILVER';
        insert accountStatus;
    }
    
    @isTest 
    static void noSMS() {
        Account testAccount = new Account();
        testAccount.Name = 'TestAccount';
        testAccount.Phone = '12345678';
        insert testAccount;  
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'TestOpportunity';
        opportunity.AccountId = testAccount.Id;
        opportunity.Amount = 51000;
        opportunity.StageName = 'Negotiation/Review';
        opportunity.CloseDate = Date.today();
        insert opportunity;
        
        Account accountAfter = [SELECT Id, Customer_Status__c, Is_Gold_SMS_sended__c, Phone, Annual_Revenue_Spend__c
                           		FROM Account 
                           		WHERE Name='TestAccount'];

		System.assertEquals(false, TwilioSMSHelper.isSMSRequired(accountAfter));
    }
    
    
    @isTest 
	static void sendSMS() {
        Test.setMock(HttpCalloutMock.class, new SMSTwilioHttpCalloutMock()); 
        Set<Id> accountIdSet =new Set<Id>();
    	Account testAccount = new Account();
        testAccount.Name = 'TestAccount';
        testAccount.Phone = '+380675651802';
        insert testAccount;  
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'TestOpportunity';
        opportunity.AccountId = testAccount.Id;
        opportunity.Amount = 51000;
        opportunity.StageName = 'Closed Won';
        opportunity.CloseDate = Date.today();
        insert opportunity;
        
        Account accountAfter = [SELECT Id, Customer_Status__c, Is_Gold_SMS_sended__c, Phone, Annual_Revenue_Spend__c
                           		FROM Account 
                           		WHERE Name='TestAccount'];    
        System.assertEquals(true, accountAfter.Is_Gold_SMS_sended__c);
	}
    
}