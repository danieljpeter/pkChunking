public with sharing class FillObjectBatch implements Database.Batchable<Integer> {

	public Iterable<Integer> start(Database.BatchableContext BC) {
		List<Integer> intList = new List<Integer>();
		
		//20,000 x 2,000 records per batch = 40M total
		for (Integer i=1; i<=4000; i++) {
			intList.add(i);	
		}
		
		return intList;
	}
 
    public void execute(Database.BatchableContext BC, List<Integer> intList) {
		List<Large_Object__c> largeObjList = new List<Large_Object__c>();
		for (Integer i: intList) {
			for (Integer j=0; j<2000; j++) {
				largeObjList.add(
					new Large_Object__c (
							Some_Number__c=getRand(),
							Some_Datetime__c=System.now()
						)
				);					
			}
		}
		insert (largeObjList); 
    }
 
 	public static Decimal getRand() {
 		Integer lower = 0;
 		Integer upper = 100;
 		
 		//get a random int between 0-100
 		Decimal retDec = Math.round( Math.random() * (upper - lower) ) + lower;
 		
 		//give it a random decimal
 		retDec += Math.random();
 		
 		//round it to 2 decimal places
 		retDec = retDec.setScale(2, System.RoundingMode.HALF_EVEN);
 		
 		return retDec;

 	}
 
	public void finish(Database.BatchableContext BC) {
	}

	//Database.executeBatch(new FillObjectBatch(), 1);

	
}