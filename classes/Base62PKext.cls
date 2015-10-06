public with sharing class Base62PKext {
    
	public Base62PKext(Apexpages.Standardcontroller controller){
	}    
    
    @RemoteAction
    public static Id getFirstId() {
    	Id firstId;
    	List<Large_Object__c> loList = [SELECT Id FROM Large_Object__c ORDER BY Id ASC LIMIT 1];
		if (!loList.isEmpty()) {
			firstId = loList[0].Id;
		}
		return firstId;
    }        
    
    @RemoteAction
    public static Id getLastId() {
    	Id lastId;
    	List<Large_Object__c> loList = [SELECT Id FROM Large_Object__c ORDER BY Id DESC LIMIT 1];
		if (!loList.isEmpty()) {
			lastId = loList[0].Id;
		}
		return lastId;
    }            
    
    
	@RemoteAction
	public static List<Map<String, String>> doBase62Chunk(Id firstId, Id lastId, Integer chunkSize) {    
		List<Map<String, String>> rangeListChunked = new List<Map<String, String>>();

			
		if ((firstId != null) && (lastId != null)) {
			//chunk our start and end Ids into batches of specified size
			List<Map<String, String>> chunkList = ChunkService.chunkIdRange(firstId, lastId, chunkSize);
				
			for (Map<String, String> chunk: chunkList) {
				rangeListChunked.add(
					New Map<String, String> {
						'first' => chunk.get('first'),
						'last' => chunk.get('last')
						}
				);	
			}						
		}

		return rangeListChunked;
	}    
	
	
    @RemoteAction
    public static List<Large_Object__c> queryChunk(String firstId, String lastId) {
		String SOQL =  	'SELECT Id, Autonumber__c, Some_Number__c ' +
						'FROM Large_Object__c ' +
						'WHERE Some_Number__c > 10 AND Some_Number__c < 20 ' +
						'AND Id >= \'' + firstId + '\' ' +
						'AND Id <= \''+ lastId +'\'  ';
						
		return database.query(SOQL);
    }    	
    
    
    
}