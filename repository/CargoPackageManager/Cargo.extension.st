Extension { #name : #Cargo }

{ #category : #'*CargoPackageManager' }
Cargo >> fetch [
	self loadInstructions	fetch
]

{ #category : #'*CargoPackageManager' }
Cargo >> fetchInto: aDirectoryReference [
	"aDirectoryReference could be 
		- either a string path to a folder,
		- either a file reference denting a folder,
		- or a MCDirectory instance"
	| mcRepo |
	mcRepo := (aDirectoryReference class canUnderstand: #storeVersion:)
		ifTrue: [ aDirectoryReference ]
		ifFalse: [ MCRepository fromUrl: aDirectoryReference asFileReference ensureCreateDirectory ].
	self loadInstructions fetchInto: mcRepo

]

{ #category : #'*CargoPackageManager' }
Cargo >> install [
	self installFrom: self loadInstructions
]

{ #category : #'*CargoPackageManager' }
Cargo >> loadInstructions [
	| resolution |
	resolution := PBSolver new
		repositories: repositories;
		solveProject: self rootDependency.
	^ CGOLoadInstructionsBuilder new
		resolution: resolution;
		loadInstructions
]

{ #category : #'*CargoPackageManager' }
Cargo >> mcVersions [
	^ self loadInstructions mcVersions
]
