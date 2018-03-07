*CargoPackageManager
iceRepository
	| backend locationToUse |
	
	self validate.

	locationToUse := self locationToUse.
	backend := self storageClass 
		newRepositoryAt: locationToUse
		subdirectory: self subdirectory.

	^ IceRepository backend: backend