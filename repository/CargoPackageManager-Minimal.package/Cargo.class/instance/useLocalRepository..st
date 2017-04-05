configuring
useLocalRepository: aPathString
	"A local repository takes precedence from the central one but not on package metadata fetch from SCM"
	repositories 
		add: (CGODirectoryPackageRepository newWithUrl: aPathString)
		afterIndex: 1