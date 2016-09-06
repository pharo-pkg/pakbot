running
setUp
	super setUp.
	repository := CGOMemoryRepository new.
	self packageVersions do: #save.
	self packages do: #save "workaround for the voyage bug: https://github.com/estebanlm/voyage/issues/2"