accessing
iceRepository
	^ (IceRepository origin: repositoryUrl) 
		subdirectory: (subdirectory ifNil: ['']); "Optional, default = '' = code in repository root"
		yourself