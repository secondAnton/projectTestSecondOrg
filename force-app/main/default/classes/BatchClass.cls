public class BatchClass implements Database.Batchable<sObject> {
    
    String textVar;
    
    public BatchClass(String text) {
        this.textVar = text;
    }

    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, BillingStreet, BillingCity, BillingState, ' +
            'BillingPostalCode, (SELECT ID, MailingStreet, MailingCity, ' +
            'MailingState, MailingPostalCode FROM Contacts) FROM Account ' +
            'Where BillingCountry = \'USA\''
        );
    }

    public void execute(Database.BatchableContext bc, List<Account> scope) {
        // process each batch of records
        List<Contact> contacts = new List<Contact>();
        for (Account account : scope) {
            for (Contact contact : account.contacts) {
                contact.MailingStreet = account.BillingStreet;
                contact.MailingCity = account.BillingCity;
                contact.MailingState = account.BillingState;
                contact.MailingPostalCode = account.BillingPostalCode;
                // add contact to list to be updated
                contacts.add(contact);
            }
        }
        update contacts;

        system.debug('BATCH ' + textVar);

    }

    public void finish(Database.BatchableContext bc){
        //QueueableClass queueableClass = new QueueableClass('DDDDD');
        //System.enqueueJob(queueableClass);
        SchedulableClass1 schedulableClass = new SchedulableClass1('JJJJJ');
        String sch = '0 01 10 27 9 ? 2023';
        String jobID = System.schedule('SchedulableClass1', sch, schedulableClass);
    }
}