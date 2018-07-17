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
	| project |
	project := (CGOOngoingProject named: #'Counter-UI')
		description: 'Small UI for the counter model.';
		addExternalCargoProject:
			(CGOCargoProjectDependency
				named: 'pharo-counter' repositoryUrl: 'github://demarey/pharo-counter-ui:master');
		registry: CGOPackageRegistry new;
		yourself.
	(project newPackageUnit: #'Counter-UI-Spec')
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

{ #category : #tests }
CGOVcsSerializedProjectV1Test >> testCanDeserializationSimpleProject [
	| project packageUnit |
	
	project := CGOOngoingProject fromStonString: self stonStringForExampleProject.
	
	self
		assert: project
		equals: CGOOngoingProject example.
		
	self assert: project assemblies isEmpty.
	self 
		assertCollection: project packageUnitNames asArray
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
	
	project := CGOOngoingProject fromStonString: self counterUiStonString.
	
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
		equals: CGOCargoProjectDependency.
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
	
	serializedProject := CGOOngoingProject example asVcsSerializedCargoProject.
	
	self
		assert: serializedProject asString
		equals: self stonStringForExampleProject
]
