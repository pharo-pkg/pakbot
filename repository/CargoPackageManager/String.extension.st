Extension { #name : #String }

{ #category : #'*CargoPackageManager' }
String >> asPackageDependency [
	^ CGOPackageDependency newFrom: self -> #()
]

{ #category : #'*CargoPackageManager' }
String >> asPackageVersionReference [
	^ CGOPackageVersionReference newOn: self
]

{ #category : #'*CargoPackageManager' }
String >> asSemanticVersion [
	^ SemanticVersion fromString: self
]
