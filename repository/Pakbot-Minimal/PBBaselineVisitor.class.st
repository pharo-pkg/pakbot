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
		'groups',
		'currentAttributes',
		'currentElement',
		'specs'
	],
	#category : #'Pakbot-Minimal-Metacello-Support'
}

{ #category : #accessing }
PBBaselineVisitor class >> attributesConjonctionCharacter [
	^ $|
]

{ #category : #accessing }
PBBaselineVisitor class >> projectFor: aBaselineOf [
	| visitor |
	visitor := self visitBaseline: aBaselineOf.
	visitor generateProject.
	^ visitor project
]

{ #category : #private }
PBBaselineVisitor class >> visitBaseline: aBaseline [

	| visitor pragmas |
	visitor := self new initializeOn: aBaseline. 
	(aBaseline isLocalSelector: #baseline:)
		ifTrue: [ aBaseline new baseline: visitor. ^ visitor ].
	
	"baseline can be any method if it defines tha baseline pragma"
	pragmas := (Pragma allNamed: #baseline in: aBaseline).
	pragmas ifNotEmpty: [ aBaseline new perform: pragmas first method selector withArguments: { visitor } ].
	^ visitor
]

{ #category : #accessing }
PBBaselineVisitor >> attributesSeparator [
	^ $:
]

{ #category : #accessing }
PBBaselineVisitor >> attributesStringFor: aNameOrListOfNames [

	^ aNameOrListOfNames isString 
					ifTrue: [ aNameOrListOfNames ] 
					ifFalse: [ "many attributes" self class attributesConjonctionCharacter join: aNameOrListOfNames ]
]

{ #category : #visiting }
PBBaselineVisitor >> baseline: aName with: aBlockClosure [
	| dependency |

	self initializeNewProjectDependencyNamed: aName with: aBlockClosure defaulVersion: 'master'.
	currentElement beBaseline.

	dependency := self metacelloBaselineDependencyFromProjectSpecNamed: aName.
	project addExternalProjectRequirement: dependency.
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

{ #category : #accessing }
PBBaselineVisitor >> currentAttributes [
	^ currentAttributes
]

{ #category : #accessing }
PBBaselineVisitor >> currentAttributesString [

	^ self attributesSeparator join:
			(self currentAttributes collect: [ :each | self attributesStringFor: each])
]

{ #category : #accessing }
PBBaselineVisitor >> currentSpec [ 
	^ specs 
		at: self currentAttributesString
		ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #visiting }
PBBaselineVisitor >> for: platformAttribute do: aBlockClosure [
	"(#common = platformAttribute or: [ Smalltalk image metacelloPlatformAttributes includes: platformAttribute ])
		ifFalse: [ ""spec is not for this platform"" ^ self ]."

	currentAttributes add: platformAttribute.

	[ aBlockClosure value ]
		ensure: [ [ currentAttributes removeLast ] on: CollectionIsEmpty do: [ "ignore" ] ] 
	
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
PBBaselineVisitor >> generatePackageFor: packageSpecs [
	
	packageSpecs size = 1
		ifTrue: [	packageSpecs first asPakbotPackageIn: project ]
		ifFalse: [ | package |
			"Will generate a pakbot package by merging information available for me and the list of package specs given as argument"
			package := project newNotLoadedPackage: packageSpecs first name.
			packageSpecs do: [ :spec | spec mergeIn: package ] ].
]

{ #category : #generating }
PBBaselineVisitor >> generatePackages [
		
	self specsByPackage
		do: [ :packageSpecs | self generatePackageFor: packageSpecs ].

]

{ #category : #generating }
PBBaselineVisitor >> generateProject [
	self generatePackages.
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
	currentAttributes := OrderedCollection new.
	specs := Dictionary new.
]

{ #category : #initialization }
PBBaselineVisitor >> initializeNewProjectDependencyNamed: aName with: aBlockClosure defaulVersion: defaultVersion [

	currentElement := PBMetacelloProjectSpec new 
		name: aName;
		version: defaultVersion;
		yourself.
	aBlockClosure value. "populate project spec"
	self currentSpec add: currentElement 
]

{ #category : #initialization }
PBBaselineVisitor >> initializeOn: aBaselineClass [
	| projectName |
	
	projectName := aBaselineClass name allButFirst: 'BaselineOf' size.
	project name: projectName.
	^ self
]

{ #category : #visiting }
PBBaselineVisitor >> loads: parts [

	currentElement loads: parts.
]

{ #category : #generating }
PBBaselineVisitor >> metacelloBaselineDependencyFromProjectSpecNamed: aName [

	| repoSpec dependency |
	repoSpec := PBMetacelloRepositorySpec url: (currentElement repository).
	dependency := PBMetacelloBaselineProjectDependency
				name: aName
				repositoryUrl: repoSpec asGitUrl scpUrl
				version: (repoSpec version ifNil: [ currentElement version ]).
	currentElement loads
		ifNotNil: [ :names | dependency loads: names ].
	^ dependency
]

{ #category : #generating }
PBBaselineVisitor >> metacelloConfigurationDependencyFromProjectSpecNamed: aName [

	^ PBMetacelloConfigurationProjectDependency
				name: aName
				repositoryUrl: (currentElement repository)
				version: (currentElement version).
]

{ #category : #visiting }
PBBaselineVisitor >> package: aName [ 
	^ self currentSpec add: (PBMetacelloPackageSpec named: aName)
]

{ #category : #visiting }
PBBaselineVisitor >> package: aName with: aBlockClosure [ 

	currentElement := self package: aName.
	aBlockClosure value

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
PBBaselineVisitor >> project: projectName copyFrom: aName with: aBlockClosure [ 
	"this should be done when resolving within a project is doable"
	| spec dependency |
	
	spec := self specNamed: aName in: self currentAttributesString.
	currentElement := spec deepCopy. "TODO: copy does not work as expected."
	currentElement name: projectName.
	self currentSpec add: currentElement.
	aBlockClosure value. "populate project spec"

	dependency := currentElement isBaseline 
		ifTrue: [ self metacelloBaselineDependencyFromProjectSpecNamed: projectName ]
		ifFalse: [ self metacelloConfigurationDependencyFromProjectSpecNamed: projectName ].
	project addExternalProjectRequirement: dependency.
]

{ #category : #visiting }
PBBaselineVisitor >> project: aName with: aBlockClosure [ 
	self initializeNewProjectDependencyNamed: aName with: aBlockClosure defaulVersion: 'stable'.
	currentElement beConfiguration.

	project addExternalProjectRequirement: (self metacelloConfigurationDependencyFromProjectSpecNamed: aName).
]

{ #category : #visiting }
PBBaselineVisitor >> repository: aRepositoryUrlString [

	currentElement repository: aRepositoryUrlString 
]

{ #category : #visiting }
PBBaselineVisitor >> requires: aNameOrAListOfNames [
	currentElement addRequirements: aNameOrAListOfNames
]

{ #category : #generating }
PBBaselineVisitor >> sortedGroups [
	"sort groups so that their parts are already defined in project"
	| sorter groupNames nodes |
	sorter := AITopologicalSorting new.
	groupNames := groups collect: #key.
	nodes := Set withAll: groupNames. "We ignore package as they are already added to the project".
	sorter nodes: nodes.
	sorter edges: groups from: #key toAll: #value.
	sorter run.
	
	^ (sorter topologicalSortedElements
		 collect: [ :model | groups detect: [ :group | group key = model ] ]) reversed
]

{ #category : #accessing }
PBBaselineVisitor >> specNamed: aName in: attributeString [

	^ specs 
		at: attributeString
		ifPresent: [ :specList | specList detect: [ :spec | spec name = aName ] ]
]

{ #category : #accessing }
PBBaselineVisitor >> specsByPackage [
	| dict |
	dict := Dictionary new.
	specs keysAndValuesDo: [ :attributeString :specList |
		specList do: [ :spec | 
			spec isPackageSpec ifTrue: [  
				spec attributes: attributeString.
				(dict at: spec name ifAbsentPut: OrderedCollection new) add: spec ] ] ].
	^ dict
]

{ #category : #visiting }
PBBaselineVisitor >> versionString: aString [

	currentElement version: aString
]
