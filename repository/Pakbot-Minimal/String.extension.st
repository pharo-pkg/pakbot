Extension { #name : #String }

{ #category : #'*Pakbot-Minimal' }
String >> asGitUrl [
	^ self asGitUrlOrMetacelloRepositorySpec asGitUrl 
]

{ #category : #'*Pakbot-Minimal' }
String >> asGitUrlOrMetacelloRepositorySpec [
	^ (PBGitUrl canHandleUrl: self)
		ifTrue: [ PBGitUrl url: self ]
		ifFalse: [ PBMetacelloRepositorySpec url: self ]

]

{ #category : #'*Pakbot-Minimal' }
String >> asMetacelloRepositorySpec [
	^ PBMetacelloRepositorySpec url: self
]

{ #category : #'*Pakbot-Minimal' }
String >> asPackageDependency [
	^ PBPackageDependency newFrom: self -> #()
]

{ #category : #'*Pakbot-Minimal' }
String >> asSemanticVersion [
	^ SemanticVersion fromString: self
]
