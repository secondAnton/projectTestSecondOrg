public class UtilityService {

    public static String getSObjectJson(sObject payloadObject) {
        String sObjectType = payloadObject.Id.getSObjectType().getDescribe().getName();
        system.debug('sObjectType  '+sObjectType);
        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get(sObjectType).getDescribe().fields.getMap();
        JSONGenerator generator = JSON.createGenerator(false);
        generator.writeStartObject();
        
        for (String fieldName : fieldMap.keySet()) {
            //system.debug(fieldName);
            
            if (fieldName == 'testfield__c') {
                system.debug(fieldName + ' ' + payloadObject.get(fieldName));
                DescribeFieldResult dfr = fieldMap.get(fieldName).getDescribe();
                system.debug('dfr.getName '+dfr.getName());
                generator.writeStringField(dfr.getName(), String.valueOf(payloadObject.get(fieldName)));
            }            
        }
        
        
        /*for (String fieldName : fieldMap.keySet()) {
            DescribeFieldResult dfr = fieldMap.get(fieldName).getDescribe();
            if (payloadObject.get(fieldName) == null) {
                generator.writeNullField(dfr.getName());
                continue;
            }
            Schema.DisplayType dfrType = dfr.getType();
            switch on dfrType {
                when BOOLEAN {
                    generator.writeBooleanField(dfr.getName(), Boolean.valueOf(payloadObject.get(fieldName)));
                }
                when DATE {
                    generator.writeDateField(dfr.getName(), Date.valueOf(payloadObject.get(fieldName)));
                }
                when DATETIME {
                    generator.writeDateTimeField(dfr.getName(), DateTime.valueOf(payloadObject.get(fieldName)));
                }
                when ID {
                    generator.writeIdField(dfr.getName(), (Id) (payloadObject.get(fieldName)));
                }
                when INTEGER {
                    generator.writeNumberField(dfr.getName(), Integer.valueOf(payloadObject.get(fieldName)));
                }
                when DOUBLE, CURRENCY, PERCENT {
                    generator.writeNumberField(dfr.getName(), Double.valueOf(payloadObject.get(fieldName)));
                }
                when else {
                    generator.writeStringField(dfr.getName(), String.valueOf(payloadObject.get(fieldName)));
                }
            }
        }*/
        
        generator.writeEndObject();

        return generator.getAsString();
    }
}