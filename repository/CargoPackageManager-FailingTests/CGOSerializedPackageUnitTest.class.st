"
A SerializedPackageVersionTest is a test class for testing the behavior of SerializedPackageVersion
"
Class {
	#name : #CGOSerializedPackageUnitTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-FailingTests-Model-Serialization'
}

{ #category : #'expected results' }
CGOSerializedPackageUnitTest >> a100With2EmptyDependency [
	^ 'CGOPackageUnit {
	#description : ''A test package version.'',
	#version : ''1.0.0'',
	#package : #A,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#src : CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Foo/Bar/main''
		},
		#packageName : #no-file-specified,
		#versionString : ''JohnDoe.0''
	},
	#dependencies : [
		#B : [ ],
		#C : [ ]
	]
}'
]

{ #category : #'expected results' }
CGOSerializedPackageUnitTest >> a100WithDependencies [
	^ 'CGOPackageUnit {
	#description : ''A test package version.'',
	#version : ''1.0.0'',
	#package : #A,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#src : CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Foo/Bar/main''
		},
		#packageName : #no-file-specified,
		#versionString : ''JohnDoe.0''
	},
	#dependencies : [
		#B : [
			''=3.1.0''
		],
		#C : [
			''=1.0.0'',
			''=1.1.0''
		]
	]
}'
]

{ #category : #'expected results' }
CGOSerializedPackageUnitTest >> a100WithoutDependencies [
	^ 'CGOPackageUnit {
	#description : ''A test package version.'',
	#version : ''1.0.0'',
	#package : #A,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#src : CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Foo/Bar/main''
		},
		#packageName : #no-file-specified,
		#versionString : ''JohnDoe.0''
	},
	#dependencies : [ ]
}'
]

{ #category : #'expected results' }
CGOSerializedPackageUnitTest >> aWithDependencyWithNoConstraint [
	^ 'CGOPackageUnit {
	#description : ''A test package version.'',
	#version : ''1.0.0'',
	#package : #A,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#src : CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Foo/Bar/main''
		},
		#packageName : #no-file-specified,
		#versionString : ''JohnDoe.0''
	},
	#dependencies : [
		#B : [ ]
	]
}'
]

{ #category : #'expected results' }
CGOSerializedPackageUnitTest >> seasideCore310StonString [
	^ 'CGOPackageUnit {
	#description : ''No description'',
	#version : ''3.1.0'',
	#package : #Seaside-Core,
	#timestamp : DateAndTime [ ''2015-02-26T12:17:20.505912+01:00'' ],
	#src : CGOMonticelloHostedPackageVersion {
		#repository : CGOMonticelloRepository {
			#repositoryUrl : ''http://smalltalkhub.com/mc/Seaside/Seaside31/main''
		},
		#packageName : #Seaside-Core,
		#versionString : ''pmm.808''
	},
	#dependencies : [
		#Grease-Core : [
			''=1.1.5''
		],
		#Seaside-Core-Platform : [
			''=1.0.0''
		]
	]
}'
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testDeserializeDependenciesIn [
	| serializedPkgVersion pkgVersion |
	serializedPkgVersion := CGOSerializedPackageUnit new
		instVarNamed: 'dependencies' put: {#'Grease-Core'->#('=1.1.5') . #'Seaside-Core-Platform'->#('=3.1.0')};
		yourself.
	pkgVersion := CGOPackageUnit new.
	serializedPkgVersion deserializeDependenciesIn: pkgVersion.
	self
		assert: pkgVersion dependencies class
		equals: Array.
	self
		assert: (pkgVersion dependencies at: 1) asString
		equals: 'Grease-Core (=1.1.5)'.
	self
		assert: (pkgVersion dependencies at: 2) asString
		equals: 'Seaside-Core-Platform (=3.1.0)'.
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testFromSton [
	| seasideCore ston |
	seasideCore := self packageVersions detect: [ :each | each packageName = 'Seaside-Core' ].
	ston := CGOPackageVersionWriter toStringPretty: seasideCore.
	self
		assert: (STON fromString: ston)
		equals: seasideCore
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testFromStonTargetClass [
	| ston |
	ston := CGOPackageVersionWriter toStringPretty: 
				(CGOSerializedPackageUnit new
					instVarNamed: 'package' put: #A;
					instVarNamed: 'version' put: '1.0.0' asSemanticVersion;
					yourself).
	self 
		assert: (STON fromString: ston) class
		equals: CGOPackageUnit
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testFromStonWithApkg [
	| pkgVersion constraints |
	
	pkgVersion := STON fromString: self a100WithDependencies.

	self assert: pkgVersion packageName equals: #A.
	self assert: pkgVersion version equals: (SemanticVersion fromString: '1.0').
	self assert: pkgVersion description equals: 'A test package version.'.
	self 
		assert: ((pkgVersion sourcePackageVersion instVarNamed: 'repository') instVarNamed: 'repositoryUrl')
		equals: 'http://smalltalkhub.com/mc/Foo/Bar/main' asUrl.	
	self assert: pkgVersion dependencies size equals: 2.
	self assert: pkgVersion dependencies first targetedPackage equals: #B.
	self assert: pkgVersion dependencies second targetedPackage equals: #C.
	constraints := pkgVersion dependencies second constraints.
	self assert: constraints size equals: 2.
	self assert: constraints first asString equals: '=1.0.0'
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testStonOn [
	| seasideCore |
	seasideCore := self packageVersions detect: [ :each | each packageName = 'Seaside-Core' ].
	seasideCore 
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
		
	self
		assert: (CGOPackageVersionWriter toStringPretty: seasideCore)
		equals: self seasideCore310StonString
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testStonOnWith2EmptyDependency [
	| pkgUnit ston |
	pkgUnit := STON fromString: self a100With2EmptyDependency.
	ston := CGOPackageVersionWriter toStringPretty: pkgUnit.
	self
		assert: ston
		equals: self a100With2EmptyDependency
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testStonOnWithApkg [
	| dictionary pkgVersion result |
	
	dictionary := Dictionary new.
	dictionary
		add: #package -> #A;
		add: #version -> '1.0';
		add: #description -> 'A test package version.';
		add: #sourcePackageVersion -> (CGOMonticelloHostedPackageVersion 
			repositoryUrl: 'http://smalltalkhub.com/mc/Foo/Bar/main'
			packageName: 'no-file-specified'
			versionString: 'JohnDoe.0');
		add: #dependencies -> { #B -> #('=3.1') . #C -> #('=1.0' '=1.1')}.
	pkgVersion := CGOPackageVersion newFrom: dictionary.
	pkgVersion
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	result := String streamContents: [ :stream | (CGOPackageVersionWriter on: stream)
		referencePolicy: #ignore;
		prettyPrint: true; 
		nextPut: pkgVersion;
		yourself ].
	self assert: result equals: self a100WithDependencies
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testStonOnWithApkgWithDependencyWithNoConstraint [
	| dictionary pkgVersion result |
	
	dictionary := Dictionary new.
	dictionary
		add: #package -> #A;
		add: #version -> '1.0';
		add: #description -> 'A test package version.';
		add: #sourcePackageVersion -> (CGOMonticelloHostedPackageVersion 
			repositoryUrl: 'http://smalltalkhub.com/mc/Foo/Bar/main'
			packageName: 'no-file-specified'
			versionString: 'JohnDoe.0');
		add: #dependencies -> { #B -> #() }.
	pkgVersion := CGOPackageVersion newFrom: dictionary. 
	pkgVersion
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	result := String streamContents: [ :stream | (CGOPackageVersionWriter on: stream)
		referencePolicy: #ignore;
		prettyPrint: true; 
		nextPut: pkgVersion;
		yourself ].
	self assert: result equals: self aWithDependencyWithNoConstraint
]

{ #category : #tests }
CGOSerializedPackageUnitTest >> testStonOnWithApkgWithoutDependencies [
	| dictionary pkgVersion result |
	
	dictionary := Dictionary
		with: #package -> #A
		with: #version -> '1.0'
		with: #description -> 'A test package version.'
		with: #sourcePackageVersion -> (CGOMonticelloHostedPackageVersion 
			repositoryUrl: 'http://smalltalkhub.com/mc/Foo/Bar/main'
			packageName: 'no-file-specified'
			versionString: 'JohnDoe.0').
	pkgVersion := CGOPackageVersion newFrom: dictionary.
	pkgVersion
		instVarNamed: 'timestamp'
		put: (DateAndTime fuzzyReadFrom: '2015-02-26T12:17:20.505912+01:00' readStream).
	result := String streamContents: [ :stream | (CGOPackageVersionWriter on: stream)
		referencePolicy: #ignore;
		prettyPrint: true; 
		nextPut: pkgVersion;
		yourself ].
	self assert: result equals: self a100WithoutDependencies
]
