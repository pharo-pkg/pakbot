"
API for common package / projet dependencies

project instance variable holds a reference to the project declaring the dependency.
"
Class {
	#name : #PBAbstractDependency,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Minimal-Dependencies'
}

{ #category : #conflicts }
PBAbstractDependency >> additionalConflictingInstalledProjects [

	^ #()
]

{ #category : #testing }
PBAbstractDependency >> fitsPlatformRequirements [
	
	^ self subclassResponsibility
]

{ #category : #accessing }
PBAbstractDependency >> fullyQualifiedName [
	^ self name
]

{ #category : #'querying - installed' }
PBAbstractDependency >> isInstalled [
	
	"Returns true if the dependency is installed in the image with the same version"
	^ project registry isInstalled: self
]

{ #category : #testing }
PBAbstractDependency >> isOutOfSync [	
	"Returns true if there is a version of the project installed but not the correct version"
	
	^ project registry isOutOfSync: self.
]

{ #category : #testing }
PBAbstractDependency >> isSolved [
	
	self subclassResponsibility
]

{ #category : #accessing }
PBAbstractDependency >> name [
	self subclassResponsibility 
]

{ #category : #accessing }
PBAbstractDependency >> project: aCGOOngoingProject [ 

	project := aCGOOngoingProject
]

{ #category : #solving }
PBAbstractDependency >> resolvedDependency [ 
	
	self subclassResponsibility
]
