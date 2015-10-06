public with sharing class QLPKExt {

	public QLPKExt(Apexpages.Standardcontroller controller){
	}

    @RemoteAction
    public static List<Large_Object__c> queryChunk(String firstId, String lastId, Boolean isLast) {
		
		//last Id range uses <=, all others use <
		String lastClause = 'AND Id < \''+ lastId +'\'  ';
		if (isLast) {
			lastClause = 'AND Id <= \''+ lastId +'\'  ';	
		}		
		
		String SOQL =  	'SELECT Id, Autonumber__c, Some_Number__c ' +
						'FROM Large_Object__c ' +
						'WHERE Some_Number__c > 10 AND Some_Number__c < 20 ' +
						'AND Id >= \'' + firstId + '\' ' +
						lastClause;
						
		return database.query(SOQL);
    }    



    
}