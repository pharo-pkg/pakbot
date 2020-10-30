Extension { #name : #PBPackage }

{ #category : #'*CargoPackageManager-UI' }
PBPackage >> iconName [
	^ #package
]

{ #category : #'*CargoPackageManager-UI' }
PBPackage >> uiItemIn: anAssembly [
	^ PBPackageReferenceUIItem on: self inAssembly: anAssembly
]
