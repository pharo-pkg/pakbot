configuring
useLocalRepository: aPathString
	self defaultPackageRepository: 
		(CGODirectoryPackageRepository newWithUrl: aPathString)