//@RestResource(urlMapping='/firstwebservice/*')

@RestResource(urlMapping='/contentdocument/*')
global class PublicApiContentDocumentClass {

    @HttpGet
    global static String doGet() {
        String name = RestContext.request.params.get('id');
        return 'your Id is ==>'+name;
    }
    
    /*@HttpPost
    global static Id createDocument(String AccountName) {
        Account acc = new account();
        acc.Name = AccountName ;
        acc.Website = 'www.'+ AccountName +'.com' ;
        Insert acc ;
        return acc.Id;
    }*/
    
    @HttpPost
    global static Id createDocument(String fileName, String fileExtension, String blobData) {
        ContentVersion cntVersion = new ContentVersion();
        cntVersion.PathOnClient = fileName + '.' + fileExtension;
        cntVersion.Title = fileName;
        cntVersion.VersionData = EncodingUtil.base64Decode(blobData);
        Insert cntVersion ;
        
        Id conDocument = [
            SELECT ContentDocumentID 
            FROM ContentVersion 
    		WHERE Id = :cntVersion.ID
        ].ContentDocumentID;
        	
        ContentDocumentLink conDocLink = new ContentDocumentLink();
    	conDocLink.LinkedEntityId = '0010900001L2f2mAAB';
        conDocLink.ContentDocumentId = conDocument;
        conDocLink.shareType = 'V';
        conDocLink.Visibility = 'AllUsers';
        insert conDocLink; 
        
        return cntVersion.Id;
    }
    
    
}