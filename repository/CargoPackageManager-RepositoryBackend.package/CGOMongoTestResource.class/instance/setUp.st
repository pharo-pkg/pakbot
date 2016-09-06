running
setUp
	super setUp.
	repository := CGOMongoRepository newWithDbName: 'PPM-Tests'.
	repository reset. "remove old data"
	self packageVersions do: #save.
	self packages do: #save