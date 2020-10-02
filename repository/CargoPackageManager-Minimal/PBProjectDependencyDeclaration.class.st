"
I define the API available on external project dependencies declaration.
My subclasses contains external project dependencies on:
- Cargo projects,
- Metacello baselines,
- Metecello configurations.
"
Class {
	#name : #PBProjectDependencyDeclaration,
	#superclass : #PBAbstractDependency,
	#instVars : [
		'name',
		'packagesToLoad'
	],
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #accessing }
PBProjectDependencyDeclaration >> constraints [
	
	^ self subclassResponsibility
]

{ #category : #initialization }
PBProjectDependencyDeclaration >> initialize [ 
	packagesToLoad := Set new.
]

{ #category : #testing }
PBProjectDependencyDeclaration >> isMetacelloProjectDependency [
	^ false
]

{ #category : #solving }
PBProjectDependencyDeclaration >> isResolvedBy: aResolution [
	
	^ aResolution resolvesDependency: self
]

{ #category : #testing }
PBProjectDependencyDeclaration >> isSameProjectAs: anotherProject [ 
	
	^ self name = anotherProject name
]

{ #category : #accessing }
PBProjectDependencyDeclaration >> loads: aListOfNames [ 
	packagesToLoad addAll: aListOfNames
]

{ #category : #accessing }
PBProjectDependencyDeclaration >> name [
	^ name
]

{ #category : #accessing }
PBProjectDependencyDeclaration >> packagesToLoad [
	^ packagesToLoad
]

{ #category : #printing }
PBProjectDependencyDeclaration >> printOn: aStream [
	aStream << 'a ' << self class name << '(' << name << ')'
]

{ #category : #solving }
PBProjectDependencyDeclaration >> resolveIn: aPBResolvedProject solver: aPBSolver [

	aPBResolvedProject addResolvedDependency: 
		(PBResolvedDependency
			 onDependency: self
			 resolution: (aPBSolver solveProject: self resolvedDependency loads: self packagesToLoad))
]
