querying - installed
isInstalledInMetacello
	
	| conf |
	conf := MetacelloProjectRegistration registry configurationRegistry at: (#ConfigurationOf , name) ifAbsent: [ ^ false ].	
	^ conf version = version and: [ conf loadedInImage and: [ conf configurationProjectSpec loads isEmpty ]]