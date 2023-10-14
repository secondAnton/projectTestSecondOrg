public class PayloadSTL {
	public String name {get; set;}
    public SObject payloadObject {get; set;}
    public String payload {get; set;}
    public DateTime createdAt {get; set;}
    public Metadata metadata {get; set;}
    public String uuid {get; set;}

    public class Metadata {
        public String request_id {get; set;}
    }
}