trigger OpportunityTrigger on Opportunity (before insert, after update) {
    /*Set<Id> accountIdSet = new Set<Id>();
    
    system.debug('Trigger.operationType  ' + Trigger.operationType);
    
    for (Opportunity opportunity : Trigger.New) {
        if (opportunity.StageName == 'Closed Won') {
            accountIdSet.add(opportunity.AccountId);
        }
    }
    
    List<Account> accountList = [SELECT Customer_Status__c, Phone, Annual_Revenue_Spend__c 
                                 FROM Account 
                                 WHERE Id IN : accountIdSet];
    
    // Выводятся данные с Аккаунта до обновления, рассчитываемого в роллапе и формула филд
    system.debug('OPPO  STATUS   ' + accountList[0].Customer_Status__c);
    system.debug('OPPO   Annual_Revenue_Spend__c    ' + accountList[0].Annual_Revenue_Spend__c );
    */
    
}