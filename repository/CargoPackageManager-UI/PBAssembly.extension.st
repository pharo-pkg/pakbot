Extension { #name : #PBAssembly }

{ #category : #'*CargoPackageManager-UI' }
PBAssembly >> balloonText [
	
	^ self name, ' Assembly'
]

{ #category : #'*CargoPackageManager-UI' }
PBAssembly >> iconName [
	
	^ #image
]

{ #category : #'*CargoPackageManager-UI' }
PBAssembly >> uiItemIn: anAssembly [
	^ PBAssemblyUIItem on: self
]
