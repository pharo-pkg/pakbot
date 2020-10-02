Extension { #name : #String }

{ #category : #'*CargoPackageManager' }
String >> asGitUrl [
	^ self asGitUrlOrMetacelloRepositorySpec asGitUrl 
]

{ #category : #'*CargoPackageManager' }
String >> asGitUrlOrMetacelloRepositorySpec [
	^ (PBGitUrl canHandleUrl: self)
		ifTrue: [ PBGitUrl url: self ]
		ifFalse: [ PBMetacelloRepositorySpec url: self ]

]

{ #category : #'*CargoPackageManager' }
String >> asMetacelloRepositorySpec [
	^ PBMetacelloRepositorySpec url: self
]

{ #category : #'*CargoPackageManager' }
String >> asPackageDependency [
	^ PBPackageDependency newFrom: self -> #()
]

{ #category : #'*CargoPackageManager' }
String >> asPackageVersionReference [
	^ CGOPackageVersionReference newOn: self
]

{ #category : #'*CargoPackageManager' }
String >> asSemanticVersion [
	^ SemanticVersion fromString: self
]
