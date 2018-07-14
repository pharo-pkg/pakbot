Extension { #name : #AssemblyManifest }

{ #category : #'*CargoPackageManager-Utils' }
AssemblyManifest class >> includesAny: aListOfPackageName [
	^ (self parts collect: #key) 
		includesAny: aListOfPackageName
]
