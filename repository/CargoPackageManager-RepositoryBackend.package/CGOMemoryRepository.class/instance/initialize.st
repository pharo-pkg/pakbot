initialization
initialize
	super initialize.
	voyageRepository := VOMemoryRepository new.
	voyageRepository enableSingleton