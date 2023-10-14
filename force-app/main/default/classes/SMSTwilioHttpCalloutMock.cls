global class SMSTwilioHttpCalloutMock implements HttpCalloutMock{
	private static final String responseBody = '{' +
        '"sid": "SM16c0795c51564377b309b9305c523c61",' +
        '"date_created": "Wed, 11 Aug 2021 08:45:06 +0000",' +
        '"date_updated": "Wed, 11 Aug 2021 08:45:06 +0000",' +
        '"date_sent": null,' +
        '"account_sid": "AC91b3a7891d1045ca15c4bb8f6b4410c0",' +
        '"to": "+380675651802",' +
        '"from": "+14792268921",' +
        '"messaging_service_sid": null,' +
        '"body": "Sent from your Twilio trial account - Now you have a GOLD status. Regards.",' +
        '"status": "queued",' +
        '"num_segments": "1",' +
        '"num_media": "0",' +
        '"direction": "outbound-api",' +
        '"api_version": "2010-04-01",' +
        '"price": null,' +
        '"price_unit": "USD",' +
        '"error_code": null,' +
        '"error_message": null' +
    '}';
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setStatusCode(200);
        response.setBody(responseBody);
        return response;
    }
}