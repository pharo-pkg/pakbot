Class {
	#name : #CGOVcsSerializedProjectV1Test,
	#superclass : #CGOTest,
	#category : #'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #accessing }
CGOVcsSerializedProjectV1Test class >> resources [
	^ #()
]

{ #category : #'test data' }
CGOVcsSerializedProjectV1Test >> counterUiProject [
	| project dependency |
	
	dependency := PBPakbotProjectDependency named: 'pharo-counter' repositoryUrl: 'git@github.com:demarey/pharo-counter-ui.git'.
	dependency repository version: 'master'.

	project := (PBProject named: #'Counter-UI')
		description: 'Small UI for the counter model.';
		addExternalCargoProject: dependency;
		registry: CGOPackageRegistry new;
		yourself.
	(project createPackageNamed: #'Counter-UI-Spec')
		description: 'Core package with the counter UI based on Spec.';
		addDependencyOn: #'Counter::Counter-Core';
		yourself.
	^ project
]

{ #category : #'test data' }
CGOVcsSerializedProjectV1Test >> counterUiStonString [
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
	#externalProjects : [
		{
			#name : ''pharo-counter'',
			#repository : {
				#type : #git,
				#repositoryUrl : ''git://git@github.com/demarey/pharo-counter.git'',
				#version : ''master''
			},
			#version : ''''
		}
	]
}'
]

{ #category : #'test data' }
CGOVcsSerializedProjectV1Test >> stonStringForExampleProject [
	"
		STON toStringPretty: CGOOngoingProject example asVcsSerializedCargoProject
	"
	^ '{#version:''1.0''}
{
	#name : #MyProject,
	#description : ''A simple project used for illustration.'',
	#units : [
		{
			#name : #UnitTest,
			#description : ''A simple ongoing package unit.''
		}
	]
}'
]

{ #category : #'test data' }
CGOVcsSerializedProjectV1Test >> tearDown [

	| counterUIPackage |
	counterUIPackage := #'Counter-UI-Spec' asPackageIfAbsent: [ ^ self ].
	counterUIPackage mcWorkingCopy unload.
	
	super tearDown
]

{ #category : #tests }
CGOVcsSerializedProjectV1Test >> testCanDeserializationSimpleProject [
	| project packageUnit |
	
	project := PBProject fromStonString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: PBProject example.
		
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
CGOVcsSerializedProjectV1Test >> testCanDeserializeAPackageDependencyOnExternalCargoProject [
	| project dependency externalProject |
	
	project := PBProject fromStonString: self counterUiStonString.
	
	dependency := project packageUnits anyOne dependencies first.
	self 
		assert: dependency dependencyName
		equals: 'Counter::Counter-Core'.
	
	self 
		assert: project externalProjects size 
		equals: 1.
	self 
		assert: project externalProjects anyOne name
		equals: #'pharo-counter'.
			
	externalProject := project externalProjects anyOne.
	self
		assert: externalProject class 
		equals: PBPakbotProjectDependency.
	self
		assert: externalProject repositoryUrl 
		equals: 'git://git@github.com/demarey/pharo-counter.git'.
]

{ #category : #tests }
CGOVcsSerializedProjectV1Test >> testCanSerializeAPackageDependencyOnExternalCargoProject [
	| project projectStonString |
	
	project := self counterUiProject.
	projectStonString := STON toStringPretty: project asVcsSerializedCargoProject.
	
	self 
		assert: projectStonString
		equals: '{
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
	#externalProjects : [
		{
			#name : ''pharo-counter'',
			#repository : {
				#type : #git,
				#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
				#version : ''master''
			},
			#version : ''''
		}
	]
}'
]

{ #category : #tests }
CGOVcsSerializedProjectV1Test >> testCanSerializeSimpleProject [
	| serializedProject |
	
	serializedProject := PBProject example asVcsSerializedCargoProject.
	
	self
		assert: serializedProject asString
		equals: self stonStringForExampleProject
]
