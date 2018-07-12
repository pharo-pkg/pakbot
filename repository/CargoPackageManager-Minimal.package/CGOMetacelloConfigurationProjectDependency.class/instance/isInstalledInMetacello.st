querying - Installed
isInstalledInMetacello
	
	| conf |
	conf := MetacelloProjectRegistration registry configurationRegistry at: (#ConfigurationOf , configuration) ifAbsent: [ ^ false ].	
	^ conf version = version and: [ conf loadedInImage and: [ conf configurationProjectSpec loads isEmpty ]]