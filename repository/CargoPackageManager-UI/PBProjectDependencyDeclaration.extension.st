Extension { #name : #PBProjectDependencyDeclaration }

{ #category : #'*CargoPackageManager-UI' }
PBProjectDependencyDeclaration >> iconName [
	^ self class iconName
]

{ #category : #'*CargoPackageManager-UI' }
PBProjectDependencyDeclaration class >> iconName [
	self subclassResponsibility
]
