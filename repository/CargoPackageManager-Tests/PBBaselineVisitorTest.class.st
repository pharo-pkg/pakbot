Class {
	#name : #PBBaselineVisitorTest,
	#superclass : #TestCase,
	#instVars : [
		'visitor'
	],
	#category : #'CargoPackageManager-Tests-Metacello'
}

{ #category : #'test data' }
PBBaselineVisitorTest >> babyMockConfiguration: spec [
	spec
		project: 'BabyMock2'
		with: [ spec
				className: #ConfigurationOfBabyMock2;
				versionString: #stable;
				repository: 'http://smalltalkhub.com/mc/zeroflag/BabyMock2/main/' ]
]

{ #category : #'test data' }
PBBaselineVisitorTest >> baselineWithConditionalPackageDeclaration: spec [
	<baseline>
	spec
		for: #all do: [ 
			spec 
				package: 'PakbotTestExample-CommonPackage';
				for: #bar do: [ spec package: 'PakbotTestExample-BarPackage' ]. ];
		for: #foo do: [ spec package: 'PakbotTestExample-FooPackage' ].
]

{ #category : #'test data' }
PBBaselineVisitorTest >> baselineWithConditionalPackageDependencyDeclaration: spec [
	<baseline>
	spec
		for: #common do: [ spec package: 'PakbotTestExample-PackageA' ];
		for: #foo do: [ spec package: 'PakbotTestExample-FooPackage'.
							 spec package: 'PakbotTestExample-PackageA' with: [ spec requires: 'PakbotTestExample-FooPackage' ] ];
		for: #bar do: [ spec package: 'PakbotTestExample-BarPackage'.
							 spec package: 'PakbotTestExample-PackageA' with: [ spec requires: 'PakbotTestExample-BarPackage' ] ].
]

{ #category : #'test data' }
PBBaselineVisitorTest >> baselineWithForwardReference: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
					package: 'PakbotTestExample-PackageA';
					group: 'groupWithFR' with: #('PakbotTestExample-PackageA' 'PakbotTestExample-PackageB');
					package: 'PakbotTestExample-PackageB' ]
]

{ #category : #'test data' }
PBBaselineVisitorTest >> baselineWithGroupForwardReference: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
					package: 'PakbotTestExample-PackageA';
					package: 'PakbotTestExample-PackageB';
					group: 'groupWithFR1' with: #(groupWithFR2 'PakbotTestExample-PackageC');
					group: 'groupWithFR2' with: #('PakbotTestExample-PackageA' 'groupB');
					group: 'groupB' with: #('PakbotTestExample-PackageB');
					package: 'PakbotTestExample-PackageC' ]
]

{ #category : #'test data' }
PBBaselineVisitorTest >> parametrizedTestsBaseline: spec [
	spec baseline: 'ParametrizedTests' with: [ spec repository: 'github://tesonep/ParametrizedTests/src' ]
]

{ #category : #'test data' }
PBBaselineVisitorTest >> processWrapperConfiguration: spec [
	spec configuration: 'ProcessWrapper' 
				with: [ spec
					versionString: '1.2';
					repository: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main' ].
]

{ #category : #running }
PBBaselineVisitorTest >> setUp [
	super setUp.
	visitor := PBBaselineVisitor new.
]

{ #category : #'test data' }
PBBaselineVisitorTest >> simpleBaseline: spec [
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
PBBaselineVisitorTest >> testAssembliesOnlyContainPackages [

	self simpleBaseline: visitor.
	
	visitor project assemblies do: 
		[ :assembly |
		 self
			assert: (assembly parts allSatisfy: [ :part | part isUnit or: [ assembly isAssembly ] ])
			description: 'Assembly should only contains package units or assemblies' ].
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanGetDependenciesWhenDeclaredConditionally [
	| project packageADependencies |
	self baselineWithConditionalPackageDependencyDeclaration: visitor.
	project := visitor 
		generateProject;
		project.
	
	self
		assert: project packages size 
		equals: 3.
	self
		assertCollection: project packageNames 
		hasSameElements: #('PakbotTestExample-PackageA' 'PakbotTestExample-FooPackage' 'PakbotTestExample-BarPackage').
	
	packageADependencies := (project packageNamed: #'PakbotTestExample-PackageA') dependencies.
	self
		assert: packageADependencies size
		equals: 2.
	self
		assertCollection: (packageADependencies detect: [ :e | e name = #'PakbotTestExample-FooPackage' ]) platformRequirements 
		hasSameElements: #( #'foo' ).
	self
		assertCollection: (packageADependencies detect: [ :e | e name = #'PakbotTestExample-BarPackage' ]) platformRequirements 
		hasSameElements: #( #'bar' ).
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanGetDependencyOnMetacelloBaseline [
	| dependency |
	
	self simpleBaseline: visitor.
	self parametrizedTestsBaseline: visitor.
	visitor generateProject.
	
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
PBBaselineVisitorTest >> testCanGetDependencyOnMetacelloConfigurationDescribedWtihConfigurationWith [
	| dependency |
	
	self simpleBaseline: visitor.
	self processWrapperConfiguration: visitor.
	visitor generateProject.
	
	self
		assert: visitor project metacelloProjects size
		equals: 1.
	dependency := visitor project metacelloProjects anyOne.
	self
		assert: dependency name 
		equals: #ProcessWrapper.
	self
		assert: dependency repository
		equals: 'http://smalltalkhub.com/mc/hernan/ProcessWrapper/main'.
	self
		assert: dependency version 
		equals: '1.2'.
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanGetDependencyOnMetacelloConfigurationDescribedWtihProjectWith [
	| dependency |
	
	self simpleBaseline: visitor.
	self babyMockConfiguration: visitor.
	visitor generateProject.
	
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
PBBaselineVisitorTest >> testCanGetGroups [

	self simpleBaseline: visitor.
	visitor generateProject.

	self
		assert: visitor project assemblies size
		equals: 2.
	self
		assertCollection: (visitor project assemblyNamed: 'Leaves') packageNames
		hasSameElements: #('PakbotTestExample-PackageA' 'PakbotTestExample-PackageC')
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanGetPackageDependencies [

	| dependencies project |
	self simpleBaseline: visitor.
	project := visitor generateProject.
	dependencies := (visitor project packageNamed: #'PakbotTestExample-PackageB') dependencies.
	
	self
		assert: dependencies size
		equals: 1.
	self
		assert: dependencies first targetedPackage
		equals: #'PakbotTestExample-PackageA'
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanGetPackages [

	| project |
	self simpleBaseline: visitor.
	project := visitor generateProject.
	self
		assertCollection: project packageNames
		hasSameElements: #('PakbotTestExample-PackageA' 'PakbotTestExample-PackageB' 'PakbotTestExample-PackageC' 'PakbotTestExample-PackageD')
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanGetPackagesWhenDeclaredConditionally [
	"ex: spec for: #windows do: [ ... ]"
	| project |
	self baselineWithConditionalPackageDeclaration: visitor.
	project := visitor 
		generateProject;
		project.
	
	self
		assert: project packages size 
		equals: 3.
	self
		assertCollection: (project packageNamed: #'PakbotTestExample-CommonPackage') platformRequirements 
		hasSameElements: #(#'all' ).
	self
		assertCollection: (project packageNamed: #'PakbotTestExample-FooPackage') platformRequirements 
		hasSameElements: #(#'foo' ).
	self
		assertCollection: (project packageNamed: #'PakbotTestExample-BarPackage') platformRequirements 
		hasSameElements: #( #'all' #'bar' ).
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanHandleForwardReferences [

	| assembly |
	self baselineWithForwardReference: visitor.
	visitor generateProject.
	
	assembly := visitor project assemblies anyOne.
	self
		assertCollection: (assembly parts collect: #name)
		hasSameElements: #(#'PakbotTestExample-PackageA' #'PakbotTestExample-PackageB')
]

{ #category : #tests }
PBBaselineVisitorTest >> testCanHandleGroupForwardReferences [

	| assembly |
	self baselineWithGroupForwardReference: visitor.
	visitor generateProject.
	
	assembly := visitor project assemblyNamed: #groupWithFR1.
	self
		assertCollection: (assembly parts collect: #name)
		hasSameElements: #(groupWithFR2 'PakbotTestExample-PackageC').
		
	assembly := visitor project assemblyNamed: #groupWithFR2.
	self
		assertCollection: (assembly parts collect: #name)
		hasSameElements: #('PakbotTestExample-PackageA' 'groupB')
]
