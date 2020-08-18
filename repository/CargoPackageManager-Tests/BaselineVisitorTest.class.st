Class {
	#name : #BaselineVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitor'
	],
	#category : #'CargoPackageManager-Tests-Metacello'
}

{ #category : #'test data' }
BaselineVisitorTest >> babyMockConfiguration: spec [
	spec
		project: 'BabyMock2'
		with: [ spec
				className: #ConfigurationOfBabyMock2;
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ]
]

{ #category : #'test data' }
BaselineVisitorTest >> parametrizedTestsBaseline: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #running }
BaselineVisitorTest >> setUp [
	super setUp.
	visitor := PBBaselineVisitor new.
]

{ #category : #'test data' }
BaselineVisitorTest >> simpleBaseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				package: 'PakbotTestExample-PackageA';
				package: 'PakbotTestExample-PackageB'
					with: [ spec requires: 'PakbotTestExample-PackageA' ];
				package: 'PakbotTestExample-PackageC';
				package: 'PakbotTestExample-PackageD'
					with: [ spec requires: 'PakbotTestExample-PackageC' ].
				
				spec
			group: 'ALL' with: #( 'PakbotTestExample-PackageB' 'PakbotTestExample-PackageD' );
group: 'Leaves' with: #( 'PakbotTestExample-PackageA' 'PakbotTestExample-PackageC' ) ]
]

{ #category : #tests }
BaselineVisitorTest >> testCanGetDependencyOnMetacelloBaseline [
	| dependency |
	
	self simpleBaseline: visitor.
	self parametrizedTestsBaseline: visitor.
	
	self
		assert: visitor project metacelloProjects size
		equals: 1.
	dependency := visitor project metacelloProjects anyOne.
	self
		assert: dependency name 
		equals: #ParametrizedTests.
	self
		assert: dependency repository
		equals: 'github://tesonep/ParametrizedTests/src'.
	self
		assert: dependency version 
		equals: #master.
]

{ #category : #tests }
BaselineVisitorTest >> testCanGetDependencyOnMetacelloConfiguration [
	| dependency |
	
	self simpleBaseline: visitor.
	self babyMockConfiguration: visitor.
	
	self
		assert: visitor project metacelloProjects size
		equals: 1.
	dependency := visitor project metacelloProjects anyOne.
	self
		assert: dependency name 
		equals: #BabyMock2.
	self
		assert: dependency repository
		equals: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/'.
	self
		assert: dependency version 
		equals: #stable.
]

{ #category : #tests }
BaselineVisitorTest >> testCanGetGroups [

	self simpleBaseline: visitor.
	self
		assert: visitor project assemblies size
		equals: 2.
	self
		assertCollection: (visitor project assemblyNamed: 'Leaves') parts
		hasSameElements: #('PakbotTestExample-PackageA' 'PakbotTestExample-PackageC')
]

{ #category : #tests }
BaselineVisitorTest >> testCanGetPackages [

	self simpleBaseline: visitor.
	self
		assertCollection: visitor project packageNames
		hasSameElements: #('PakbotTestExample-PackageA' 'PakbotTestExample-PackageB' 'PakbotTestExample-PackageC' 'PakbotTestExample-PackageD')
]
