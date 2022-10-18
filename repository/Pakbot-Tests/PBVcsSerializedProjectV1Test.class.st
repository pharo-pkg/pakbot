Class {
	#name : #PBVcsSerializedProjectV1Test,
	#superclass : #TestCase,
	#instVars : [
		'repository',
		'iceRepositoryLocation'
	],
	#category : #'Pakbot-Tests-Serialization'
}

{ #category : #accessing }
PBVcsSerializedProjectV1Test class >> resources [
	^ #()
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> counterUiProject [
	| project dependency |
	
	dependency := PBPakbotProjectDependency named: 'pharo-counter' repositoryUrl: 'https://git@github.com/demarey/pharo-counter-ui.git'.
	dependency repository version: 'master'.

	project := (PBProjectVersion named: #'Counter-UI')
		description: 'Small UI for the counter model.';
		repository: PBGitMemoryRepository new;
		addExternalProjectRequirement: dependency;
		registry: PBPackageRegistry new;
		yourself.
	(project createPackageNamed: #'Counter-UI-Spec')
		description: 'Core package with the counter UI based on Spec.';
		addDependencyOn: #'Counter::Counter-Core';
		yourself.
	^ project
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> counterUiStonString [
	" STON toStringPretty: (self new counterUiProject asVcsSerializedCargoProject) "
	^ '{#version:''1.0''}
{
	#name : #Counter-UI,
	#description : ''Small UI for the counter model.'',
	#units : [
		{
			#name : #Counter-UI-Spec,
			#description : ''Core package with the counter UI based on Spec.'',
			#dependencies : [
				#''Counter::Counter-Core''
			]
		}
	],
	#dependencies : [
		{
			#name : ''pharo-counter'',
			#repository : {
				#type : #git,
				#repositoryUrl : ''ssh://git@github.com/demarey/pharo-counter.git'',
				#version : ''master''
			},
			#version : ''''
		}
	]
}'
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> iceRepositoryLocation [
	^ iceRepositoryLocation
		ifNil: [ iceRepositoryLocation := FileLocator temp
				/ ('pakbot-project-serialization-tests-' , DateAndTime now asFileNameCompatibleString) ]
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> projectWithBaselineDependencyStonString [
	^ '{#version:''1.0''}
{
	#name : #Foo,
	#description : ''Foo project for test purposes. I have a baseline dependency'',
	#version: ''1.0'',
	#units : [
		{
			#name : #Foo-Bar,
			#description : ''A package foo bar.''
		}
	],
	#dependencies : [
		{
			#baseline : #Icetray,
			#url : ''https://github.com/pharo-spec/icetray.git'',
			#version : #master
		}
	]
}'
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> projectWithConfigurationDependencyStonString [
	^ '{#version:''1.0''}
{
	#name : #Foo,
	#description : ''Foo project for test purposes. I have a configuration dependency'',
	#version: ''1.0'',
	#units : [
		{
			#name : #Foo-Bar,
			#description : ''A package foo bar.''
		}
	],
	#dependencies : [
		{
			#configuration : #Ston,
			#url : ''http://ss3.gemstone.com/ss/STON'',
			#version : #stable
		}
	]
}'
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> setUp [
	self iceRepositoryLocation ensureDeleteAll.
	repository := IceRepositoryCreator new 
			location: self iceRepositoryLocation;
			createNewRepositoryNamed: 'pakbot-project-serialization-tests'.
	(repository getConfigurationGlobal: false) username: 'mock'.
	(repository getConfigurationGlobal: false) email: 'mock'.
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> stonStringForExampleProject [
	"
		STON toStringPretty: aPBProjectVersion example asVcsSerializedCargoProject
	"
	^ '{#version:''1.0''}
{
	#name : #MyProject,
	#description : ''A simple project used for illustration.'',
	#version : ''0.1'',
	#units : [
		{
			#name : #UnitTest,
			#description : ''A simple ongoing package unit.''
		}
	]
}' withInternetLineEndings
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> tearDown [

	self unloadCounterUI.
	repository forget.
	self iceRepositoryLocation ensureDeleteAll.
	
	super tearDown
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanDeserializeADependencyOnExternalBaselineProject [
	| project dependency |
	
	project := PBProjectVersion fromVcsStonString: self projectWithBaselineDependencyStonString.
	
	dependency := project dependencies anyOne.

	self 
		assert: project dependencies size 
		equals: 1.
	self 
		assert: dependency name
		equals: #Icetray.
			
	self
		assert: dependency class 
		equals: PBMetacelloBaselineProjectDependency.
	self
		assert: dependency repositoryUrl 
		equals: 'https://github.com/pharo-spec/icetray.git'.
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanDeserializeADependencyOnExternalConfigurationProject [
	| project dependency |
	
	project := PBProjectVersion fromVcsStonString: self projectWithConfigurationDependencyStonString.
	
	dependency := project dependencies anyOne.

	self 
		assert: project dependencies size 
		equals: 1.
	self 
		assert: dependency name
		equals: #Ston.
			
	self
		assert: dependency class 
		equals: PBMetacelloConfigurationProjectDependency.
	self
		assert: dependency repositoryUrl 
		equals: 'http://ss3.gemstone.com/ss/STON'.
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanDeserializeSimpleProject [
	| project packageUnit |
	
	project := PBProjectVersion fromVcsStonString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: PBProjectVersion example.
		
	self assert: project assemblies isEmpty.
	self 
		assertCollection: project packageNames asArray
		hasSameElements: #('UnitTest').

	packageUnit := project packageUnits anyOne.
	self
		assert: packageUnit project 
		equals: project.
	self
		assertCollection: packageUnit platformRequirements 
		hasSameElements: #()
	
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanSerializeAndDeserializeAPackageDependencyOnExternalPakbotProject [
	| project iceProject deserializedProject packageDependency externalProject |
	
	project := self counterUiProject.
	iceProject := PBIcebergProject onRepository: repository project: project.
	repository workingCopy basicSetProject: iceProject.
	
	repository commitWithMessage: 'commit from #testCanSerializeAndDeserializeAPackageDependencyOnExternalPakbotProject'.
	repository workingCopy basicSetProject: nil. "ensure we read project from git"
	deserializedProject := repository workingCopy project pakbotProject.
	
	self
		assert: deserializedProject dependencies size
		equals: project dependencies size.
	
	packageDependency := deserializedProject packageUnits anyOne dependencies first.
	"dependency on 'Counter::Counter-Core'"
	self 
		assert: packageDependency dependencyName
		equals: 'Counter-Core'.
	"TODO: fix me!
	self 
		assert: dependency scope
		equals: 'Counter'."
	
	self 
		assert: project dependencies size 
		equals: deserializedProject dependencies size.			
	externalProject := deserializedProject dependencies anyOne.
	self
		assert: externalProject class 
		equals: PBPakbotProjectDependency.
	self
		assert: externalProject repositoryUrl 
		equals: 'https://git@github.com/demarey/pharo-counter-ui.git'.
	self 
		assert: externalProject name
		equals: #'pharo-counter'.
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanSerializeAndDeserializeAProjectWithAssembly [
	| project iceProject deserializedProject assembly |
	
	project := PBProjectVersion example.
	project addAssemblyNamed: #NestedAssembly.
	assembly := project addAssemblyNamed: #TestAssembly.
	assembly
		description: 'A simple ongoing package assembly.';
		addPackage: (project packageOrAssemblyNamed: #UnitTest);
		addPackage: (project packageOrAssemblyNamed: #NestedAssembly).
	iceProject := PBIcebergProject onRepository: repository project: project.
	repository workingCopy basicSetProject: iceProject.
	
	repository commitWithMessage: 'commit from #testCanSerializeAndDeserilazeAProjectWithAssembly'.
	repository workingCopy basicSetProject: nil. "ensure we read project from git"
	deserializedProject := repository workingCopy project pakbotProject.
	
	self
		assert: deserializedProject name 
		equals: project name.
	self
		assert: deserializedProject version 
		equals: project version.
	self
		assert: deserializedProject packages 
		equals: project packages.
	self
		assert: deserializedProject assemblies 
		equals: project assemblies.
	self
		assertCollection: (deserializedProject assemblyNamed: #TestAssembly) parts
		hasSameElements: (project assemblyNamed: #TestAssembly) parts.
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanSerializeAndDeserializeAProjectWithDependencyOnExternalProject [
	| project iceProject deserializedProject |
	
	project := PBProjectVersion example.
	project addDependency: ((PBMetacelloBaselineProjectDependency
				name: #aPakbotProject
				repositoryUrl: #'git@github.com:foo/bar.git'
				version: '1.1')
					loads: #('Core');
					yourself).
	iceProject := PBIcebergProject onRepository: repository project: project.
	repository workingCopy basicSetProject: iceProject.
	
	repository commitWithMessage: 'commit from #testCanSerializeAndDeserializeAProjectWithDependencyOnExternalProject'.
	repository workingCopy basicSetProject: nil. "ensure we read project from git"
	deserializedProject := repository workingCopy project pakbotProject.
	
	self
		assert: deserializedProject name 
		equals: project name.
	self
		assert: deserializedProject version 
		equals: project version.
	self
		assert: deserializedProject packages 
		equals: project packages.
	self
		assertCollection: deserializedProject dependencies
		hasSameElements: project dependencies.
	self
		assert: deserializedProject dependencies first
		equals: project dependencies first.
	self
		assert: deserializedProject dependencies first packagesToLoad 
		equals: project dependencies first packagesToLoad
]

{ #category : #tests }
PBVcsSerializedProjectV1Test >> testCanSerializeSimpleProject [
	| serializedProject |
	
	serializedProject := PBProjectVersion example asVcsSerializedCargoProject.
	
	self
		assert: serializedProject asString
		equals: self stonStringForExampleProject
]

{ #category : #'test data' }
PBVcsSerializedProjectV1Test >> unloadCounterUI [

	| counterUIPackage |
	counterUIPackage := #'Counter-UI-Spec' asPackageIfAbsent: [ ^ self ].
	counterUIPackage mcWorkingCopy unload.
]
