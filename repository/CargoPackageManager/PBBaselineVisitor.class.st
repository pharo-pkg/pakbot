"
I'm a visitor for Metacello Baselines.
I build a Pakbot project from the information I get from the baseline.
The project will not be registered in the default registry but in a new one created for the context of this visitor.

Usage: 
```
	self projectFor: BaselineOfPakbot.
```
"
Class {
	#name : #PBBaselineVisitor,
	#superclass : #Object,
	#instVars : [
		'project',
		'projectDependencyProperties',
		'groups',
		'currentAttributes'
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
	aBaseline baseline: self.
	self generateProject.
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
PBBaselineVisitor >> blessing: aString [ 
	" ignore "
]

{ #category : #visiting }
PBBaselineVisitor >> className: aString [
	"class name of the ConfigurationOf
	ignored for now."
]

{ #category : #visiting }
PBBaselineVisitor >> configuration: aString with: aBlock [ 
	self project: aString with: aBlock
]

{ #category : #visiting }
PBBaselineVisitor >> for: platformAttribute do: aBlockClosure [
	(#common = platformAttribute or: [ Smalltalk image metacelloPlatformAttributes includes: platformAttribute ])
		ifFalse: [ "spec is not for this platform" ^ self ].
	
	aBlockClosure value. 
	
]

{ #category : #generating }
PBBaselineVisitor >> generateAssemblies [
	self sortedGroups do: [ :group | self generateAssemblyFor: group ]
]

{ #category : #generating }
PBBaselineVisitor >> generateAssemblyFor: group [
	| assembly |
	assembly := project addAssemblyNamed: group key.
	group value do: [ :each | assembly addPackage: (project packageOrAssemblyNamed: each) ]
]

{ #category : #generating }
PBBaselineVisitor >> generateProject [
	self generateAssemblies.
	^ project
]

{ #category : #visiting }
PBBaselineVisitor >> group: aName with: aCollection [
	groups add: aName -> aCollection
]

{ #category : #initialization }
PBBaselineVisitor >> initialize [
	project := PBProjectVersion named: 'BaselineVisitorProject'.
	groups := OrderedCollection new.
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

{ #category : #generating }
PBBaselineVisitor >> sortedGroups [
	"sort groups so that their parts are already defined in project"
	| sorter groupNames nodes |
	sorter := MalTopologicalSorting new.
	groupNames := groups collect: #key.
	nodes := Set withAll: groupNames. "We ignore package as they are already added to the project".
	sorter nodes: nodes.
	sorter edges: groups from: #key toAll: #value.
	
	^ sorter run collect: [ :node | groups detect: [ :group | group key = node model ] ]
]

{ #category : #visiting }
PBBaselineVisitor >> versionString: aString [
	projectDependencyProperties 
		at: 'version'
		put: aString
]
