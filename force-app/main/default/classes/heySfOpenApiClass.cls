@RestResource(urlMapping='/Account/*')
global class heySfOpenApiClass {
	
    @HttpGet
    global static String getAccounts() {
        RestRequest request = RestContext.request;
        list<Account> result = new list<Account>();
        result =  [SELECT Name,Website FROM Account];
        return 'Get Request Working';
       //return JSON.serialize(result);
    }
    
    @HttpPost
    global static Id getAccounts(String AccountName) {
        Account acc = new account();
        acc.Name = AccountName ;
        acc.Website = 'www.'+ AccountName +'.com' ;
        Insert acc ;
        return acc.Id;
    }
}