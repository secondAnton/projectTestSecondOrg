@isTest
private class TestGearSetClass {
	
    @isTest 
    static void testaddMethod() {
        GearSetClass gearsetclass = new GearSetClass();
        System.assertEquals(2, gearsetclass.addMethod(1, 1));
    }
    
    @isTest 
    static void testsubtractMethod() {
        GearSetClass gearsetclass = new GearSetClass();
        System.assertEquals(4, gearsetclass.subtractMethod(5, 1));
    }
    
    @isTest 
    static void testmultiplyMethod() {
        GearSetClass gearsetclass = new GearSetClass();
        System.assertEquals(4, gearsetclass.multiplyMethod(2, 2));
    }
}