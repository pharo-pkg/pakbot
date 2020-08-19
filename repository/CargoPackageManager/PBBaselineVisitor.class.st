"
I'm a visitor for Metacello Baselines.
I build a Pakbot project from the information I get from the baseline.
The project will not be registered in the default registry but in a new one created for the context of this visitor.

Usage:
	self projectFor: BaselineOfPakbot.
"
Class {
	#name : #PBBaselineVisitor,
	#superclass : #Object,
	#instVars : [
		'project',
		'projectDependencyProperties'
	],
	#category : #'CargoPackageManager-Metacello'
}

{ #category : #accessing }
PBBaselineVisitor class >> projectFor: aBaselineOf [
	| visitor |
	visitor := self new. 
	visitor baseline: aBaselineOf new.
	^ visitor project
]

{ #category : #visiting }
PBBaselineVisitor >> baseline: aBaseline [
	| projectName |
	projectName := aBaseline class name allButFirst: 'BaselineOf' size.
	project name: projectName.
	aBaseline baseline: self
]

{ #category : #visiting }
PBBaselineVisitor >> baseline: aName with: aBlockClosure [
	| dependency |
	projectDependencyProperties := Dictionary with: 'version' -> 'master'.
	aBlockClosure value.
	dependency := PBMetacelloBaselineProjectDependency
				name: aName
				repositoryUrl: (projectDependencyProperties at: 'repository')
				version: (projectDependencyProperties at: 'version').
	project addExternalCargoProject: dependency.
	"for now, pakbot only supports project dependencies. Add these external projects as dependencies"
	project addDependency: dependency.
]

{ #category : #visiting }
PBBaselineVisitor >> className: aString [
	"class name of the ConfigurationOf
	ignored for now."
]

{ #category : #visiting }
PBBaselineVisitor >> for: platformAttribute do: aBlockClosure [
	(#common = platformAttribute or: [ Smalltalk image metacelloPlatformAttributes includes: platformAttribute ])
		ifFalse: [ "spec is not for this platform" ^ self ].
	
	aBlockClosure value. 
	
]

{ #category : #visiting }
PBBaselineVisitor >> group: aName with: aCollection [
	| assembly |
	assembly := project addAssemblyNamed: aName. 
	assembly parts: aCollection
]

{ #category : #initialization }
PBBaselineVisitor >> initialize [
	project := PBProjectVersion named: 'BaselineVisitorProject'.
	project registry: PBPackageRegistry new.
]

{ #category : #visiting }
PBBaselineVisitor >> loads: parts [
	self flag: 'TODO manage loads directives'
]

{ #category : #visiting }
PBBaselineVisitor >> package: aName [ 
	project newNotLoadedPackage: aName.
]

{ #category : #visiting }
PBBaselineVisitor >> package: aName with: aBlockClosure [ 
	self package: aName.
	self flag: 'TODO: handle dependencies'.
]

{ #category : #visiting }
PBBaselineVisitor >> postLoadDoIt: aString [ 
	"ignore for now"
]

{ #category : #accessing }
PBBaselineVisitor >> project [
	^ project
]

{ #category : #visiting }
PBBaselineVisitor >> project: aString copyFrom: aString2 with: aBlockClosure [ 
	self flag: #TODO.
	"this should be done when resolving within a project is doable"
	"ignore for now"
]

{ #category : #visiting }
PBBaselineVisitor >> project: aName with: aBlockClosure [ 
	projectDependencyProperties := Dictionary with: 'version' -> 'stable'.
	aBlockClosure value.
	project addExternalCargoProject: (PBMetacelloConfigurationProjectDependency
				name: aName
				repositoryUrl: (projectDependencyProperties at: 'repository')
				version: (projectDependencyProperties at: 'version')).
]

{ #category : #visiting }
PBBaselineVisitor >> repository: aRepositoryUrlString [
	projectDependencyProperties 
		at: 'repository'
		put: aRepositoryUrlString 
]

{ #category : #visiting }
PBBaselineVisitor >> versionString: aString [
	projectDependencyProperties 
		at: 'version'
		put: aString
]
