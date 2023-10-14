trigger TestObjectTrigger on TestObject__c (after update) {
    system.debug('FROM Trigger');
    system.debug('TriggerHandler.alreadyRunOnce   ' + TriggerHandler.alreadyRunOnce);
    if(!TriggerHandler.alreadyRunOnce) {
        TriggerHandler.alreadyRunOnce = true;
        List<TestObject__c> testObjectListUpdate = new List<TestObject__c>();
        
        for(TestObject__c testObject : Trigger.New) {
            TestObject__c testObjectUpdate = new TestObject__c();
            testObjectUpdate.Id = testObject.Id;
            testObjectUpdate.TextField__c = 'NEW VALUE After';
            testObjectListUpdate.add(testObjectUpdate);
        }
        update testObjectListUpdate;
    }    
}