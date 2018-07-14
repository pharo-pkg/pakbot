"
I define the API available on external project dependencies declaration.
My subclasses contains external project dependencies on:
- Cargo projects,
- Metacello baselines,
- Metecello configurations.
"
Class {
	#name : #CGOProjectDependencyDeclaration,
	#superclass : #CGOAbstractDependency,
	#category : 'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #accessing }
CGOProjectDependencyDeclaration >> constraints [
	
	^ self subclassResponsibility
]

{ #category : #testing }
CGOProjectDependencyDeclaration >> isMetacelloProjectDependency [
	^ false
]

{ #category : #solving }
CGOProjectDependencyDeclaration >> isResolvedBy: aResolution [
	
	^ aResolution resolvesDependency: self
]

{ #category : #testing }
CGOProjectDependencyDeclaration >> isSameProjectAs: anotherProject [ 
	
	^ self name = anotherProject name
]
