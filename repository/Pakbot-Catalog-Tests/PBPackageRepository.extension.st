Extension { #name : #PBPackageRepository }

{ #category : #'*Pakbot-Catalog-Tests' }
PBPackageRepository >> registerFakePackage: aPackageName version: aVersionString [

	| file |
	file := self fileForPackageNamed: aPackageName version: aVersionString.
	
	file parent ensureCreateDirectory.
	file ensureCreateFile.
]
