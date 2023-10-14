public class GetGeoQueueable implements Queueable, Database.AllowsCallouts{
    
    private String geoUrl;

    public GetGeoQueueable(String geoUrl) {
        this.geoUrl = geoUrl;
    }

    public void execute(QueueableContext context) {
        // awesome code here
    }
}