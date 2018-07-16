Class {
	#name : #CGOVcsSerializedProjectTest,
	#superclass : #CGOTest,
	#category : 'CargoPackageManager-Tests-Model-Serialization'
}

{ #category : #accessing }
CGOVcsSerializedProjectTest class >> resources [
	^ #()
]

{ #category : #'test data' }
CGOVcsSerializedProjectTest >> counterUiProject [
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
CGOVcsSerializedProjectTest >> counterUiStonString [
	" STON toStringPretty: (self new counterUIProject asVcsSerializedCargoProject) "
	^ '{#version:''1.0''}
OngoingProject {
	#name : #Counter-UI,
	#description : ''Small UI for the counter model.'',
	#externalProjects : {
		#Counter : CGOCargoProjectDependency {
			#repository : CGOGitRepository {
				#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
				#version : ''master''
			}
		}
	},
	#units : [
		OngoingPackageUnit {
			#name : #Counter-UI-Spec,
			#description : ''Core package with the counter UI based on Spec.'',
			#dependencies : [
				#''Counter::Counter-Core''
			]
		}
	]
}'
]

{ #category : #'test data' }
CGOVcsSerializedProjectTest >> stonStringForExampleProject [
	"
		STON toStringPretty: CGOOngoingProject example asVcsSerializedCargoProject
	"
	^ '{#version:''1.0''}
OngoingProject {
	#name : #MyProject,
	#description : ''A simple project used for illustration.'',
	#units : [
		OngoingPackageUnit {
			#name : #UnitTest,
			#description : ''A simple ongoing package unit.'',
			#dependencies : [ ]
		}
	]
}'
]

{ #category : #tests }
CGOVcsSerializedProjectTest >> testCanDeserializationSimpleProject [
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
CGOVcsSerializedProjectTest >> testCanDeserializeAPackageDependencyOnExternalCargoProject [
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
		assert: project externalProjects keys anyOne
		equals: #Counter.
			
	externalProject := project externalProjects anyOne.
	self
		assert: externalProject class 
		equals: CGOCargoProjectDependency.
	self
		assert: externalProject repositoryUrl 
		equals: 'git://git@github.com/demarey/pharo-counter-ui.git'.
]

{ #category : #tests }
CGOVcsSerializedProjectTest >> testCanSerializeAPackageDependencyOnExternalCargoProject [
	| project projectStonString |
	
	project := self counterUiProject.
	projectStonString := STON toStringPretty: project asVcsSerializedCargoProject.
	
	self 
		assert: projectStonString
		equals: 'OngoingProject {
	#name : #Counter-UI,
	#description : ''Small UI for the counter model.'',
	#externalProjects : [
		CGOCargoProjectDependency {
			#repository : CGOGitRepository {
				#repositoryUrl : ''git://git@github.com/demarey/pharo-counter-ui.git'',
				#version : ''master''
			},
			#name : ''pharo-counter'',
			#version : ''''
		}
	],
	#units : [
		OngoingPackageUnit {
			#name : #Counter-UI-Spec,
			#description : ''Core package with the counter UI based on Spec.'',
			#dependencies : [
				#''Counter::Counter-Core''
			]
		}
	]
}'
]

{ #category : #tests }
CGOVcsSerializedProjectTest >> testCanSerializeSimpleProject [
	| project |
	
	project := CGOOngoingProject example asVcsSerializedCargoProject.
	
	self
		assert: (CGOPackageVersionWriter toStringPretty: project)
		equals: self stonStringForExampleProject
]
