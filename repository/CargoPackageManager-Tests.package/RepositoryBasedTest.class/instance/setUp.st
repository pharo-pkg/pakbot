set up
setUp
	super setUp.
	repository := CGOMemoryRepository new.
	self packageVersions do: #save.
	self packages do: #save