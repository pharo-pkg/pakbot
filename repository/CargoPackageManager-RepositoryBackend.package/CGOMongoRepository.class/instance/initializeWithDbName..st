initialization
initializeWithDbName: aString
	super initialize.
	voyageRepository := VOMongoRepository database: aString.
	voyageRepository enableSingleton