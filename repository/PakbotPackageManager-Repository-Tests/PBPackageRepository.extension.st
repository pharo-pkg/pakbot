Extension { #name : #PBPackageRepository }

{ #category : #'*PakbotPackageManager-Repository-Tests' }
PBPackageRepository >> registerFakePackage: aPackageName version: aVersionString [

	| file |
	file := self fileForPackageNamed: aPackageName version: aVersionString.
	
	file parent ensureCreateDirectory.
	file ensureCreateFile.
]
