"
I represent a part of a project
"
Class {
	#name : #PBProjectElement,
	#superclass : #PBLoadableUnit,
	#instVars : [
		'project'
	],
	#category : #'CargoPackageManager-Model'
}

{ #category : #adding }
PBProjectElement >> addDependency: aDependency [

	dependencies add: aDependency.
	aDependency project: self project.
	self project announceChangeInDependencies.
]

{ #category : #accessing }
PBProjectElement >> fullyQualifiedName [

	 ^ self projectName, '::' , self name
]

{ #category : #accessing }
PBProjectElement >> project [
	^ project
]

{ #category : #accessing }
PBProjectElement >> project: aCGOOngoingProject [ 
	project := aCGOOngoingProject
]

{ #category : #accessing }
PBProjectElement >> registry [
	^ project registry
]

{ #category : #actions }
PBProjectElement >> remove [
	
	self subclassResponsibility
]
