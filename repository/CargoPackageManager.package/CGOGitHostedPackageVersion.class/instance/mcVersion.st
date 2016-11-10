accessing
mcVersion
	| iceRepo icePackageVersion |
	
	iceRepo := (IceRepository origin: repositoryUrl) 
		subdirectory: (subdirectory ifNil: ['']); "Optional, default = '' = code in repository root"
		yourself.
	icePackageVersion := (iceRepo packageNamed: packageName) versionFor: commitish.
	^ icePackageVersion mcVersion