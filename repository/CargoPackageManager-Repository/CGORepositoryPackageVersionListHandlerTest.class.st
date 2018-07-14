Class {
	#name : #CGORepositoryPackageVersionListHandlerTest,
	#superclass : #CGORepositoryTest,
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #running }
CGORepositoryPackageVersionListHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'packages'
]

{ #category : #testing }
CGORepositoryPackageVersionListHandlerTest >> testGet [
	| response |

	client
		addPathSegment: 'Grease-Core';
		get;
		yourself.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #( '1.0.0' '1.1.5' '2.0.0')
]

{ #category : #testing }
CGORepositoryPackageVersionListHandlerTest >> testGetUnknownPackage [
	[ client 
		addPathSegment: 'foo';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound
]
