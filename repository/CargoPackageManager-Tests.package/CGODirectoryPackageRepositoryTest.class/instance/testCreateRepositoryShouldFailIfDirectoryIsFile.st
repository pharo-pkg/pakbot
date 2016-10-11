repository-specific
testCreateRepositoryShouldFailIfDirectoryIsFile

	self deny: temporaryPath asFileReference isDirectory.
	temporaryPath asFileReference writeStream close.
	
	self should: [CGODirectoryPackageRepository newInDirectory: temporaryPath fullName] raise: FileExists