trigger AccountTrigger on Account (before update) {
    TwilioSMSHelper.handleTrigger(Trigger.new, Trigger.operationType);
}