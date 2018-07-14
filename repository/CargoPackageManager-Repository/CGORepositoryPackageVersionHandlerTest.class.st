"
A PPMRepositoryPackageVersionHandlerTest is a test class for testing the behavior of PPMRepositoryPackageVersionHandler
"
Class {
	#name : #CGORepositoryPackageVersionHandlerTest,
	#superclass : #CGORepositoryTest,
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #'test input' }
CGORepositoryPackageVersionHandlerTest >> bar300Ston [
	^ 'CGOPackageUnit {
	#package : #Bar,
	#version : ''3.0.0'',
	#dependencies:  [
		#Foo : [ ]
	]
}'
]

{ #category : #running }
CGORepositoryPackageVersionHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'packages'
]

{ #category : #testing }
CGORepositoryPackageVersionHandlerTest >> testGet [
	| response |

	client
		addPathSegment: 'Grease-Core';
		addPathSegment: '1.1.5';
		get;
		yourself.
	self assert: client isSuccess.
	response := client contents.
	self assert: (response isKindOf: CGOPackageVersion).
	self assert: response asString equals: 'Grease-Core@1.1.5'
]

{ #category : #testing }
CGORepositoryPackageVersionHandlerTest >> testGetUnknownPackage [
	[ client 
		addPathSegment: 'foo';
		addPathSegment: '1.0.0';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound
]

{ #category : #testing }
CGORepositoryPackageVersionHandlerTest >> testGetUnknownVersion [
	[ client 
		addPathSegment: 'Grease-Core';
		addPathSegment: '12.40.6';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound
]

{ #category : #'tests-public' }
CGORepositoryPackageVersionHandlerTest >> testPost [
	| packageVersion |

	client
		addPathSegment: 'Bar';
		addPathSegment: '3.0.0';
		entity: ((ZnEntity text: self bar300Ston)
					contentType: ZnMimeType applicationSton);
		post;
		yourself.
	self assert: client isSuccess.
	
	client get.
	self assert: client isSuccess.
	packageVersion := client contents.
	self assert: (packageVersion isKindOf: CGOPackageVersion).
	self assert: packageVersion asString equals: 'Bar@3.0.0'.
	
	"clean up"
	packageVersion remove
]

{ #category : #'tests-private' }
CGORepositoryPackageVersionHandlerTest >> testUriFor [
	| pkgVersion |
	pkgVersion := CGOPackageVersion fromString: 'foo@0.1'.
	self 
		assert: (CGORepositoryPackageVersionHandler new uriFor: pkgVersion)
		equals: '/packages/foo/0.1.0'
]
