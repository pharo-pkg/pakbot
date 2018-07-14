Class {
	#name : #CGORepositoryLatestPackageHandlerTest,
	#superclass : #CGORepositoryTest,
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #running }
CGORepositoryLatestPackageHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'packages'
]

{ #category : #testing }
CGORepositoryLatestPackageHandlerTest >> testGet [
	| response |

	client
		addPathSegment: 'Grease-Core';
		addPathSegment: 'latest';
		get;
		yourself.
	self assert: client isSuccess.
	response := client contents.
	self assert: (response isKindOf: CGOPackageVersion).
	self assert: response asString equals: 'Grease-Core@1.1.5'
]

{ #category : #testing }
CGORepositoryLatestPackageHandlerTest >> testGetUnknownPackage [
	[ client 
		addPathSegment: 'foo';
		addPathSegment: 'latest';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound
]
