*CargoPackageManager
fetchInto: aDirectoryReference
	"aDirectoryReference could be 
		- either a string path to a folder,
		- either a file reference denting a folder,
		- or a MCDirectory instance"
	| mcRepo |
	mcRepo := (aDirectoryReference class canUnderstand: #storeVersion:)
		ifTrue: [ aDirectoryReference ]
		ifFalse: [ MCRepository fromUrl: aDirectoryReference asFileReference ensureCreateDirectory ].
	self loadInstructions fetchInto: mcRepo
