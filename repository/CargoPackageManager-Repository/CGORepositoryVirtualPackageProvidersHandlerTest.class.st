Class {
	#name : #CGORepositoryVirtualPackageProvidersHandlerTest,
	#superclass : #CGORepositoryTest,
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #running }
CGORepositoryVirtualPackageProvidersHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'virtualpackages'
]

{ #category : #testing }
CGORepositoryVirtualPackageProvidersHandlerTest >> testGet [
	| response |
	
	client 
		addPathSegment: 'foo-dbDriver';
		get.
	self assert: client isSuccess.
	response := client contents collect: #asString.
	self assert: response equals: #('foo-mysql@1.0')
]

{ #category : #testing }
CGORepositoryVirtualPackageProvidersHandlerTest >> testGetUnknownPackage [
	[ client 
		addPathSegment: 'foo';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound
]

{ #category : #testing }
CGORepositoryVirtualPackageProvidersHandlerTest >> testGetWithFilter [
	| response |
	
	client 
		addPathSegment: 'foo-dbDriver';
		queryAt: #platform add: 'pharo';
		get.
	self assert: client isSuccess.
	response := client contents collect: #asString.
	self assert: response equals: #('foo-mysql@1.0')
]

{ #category : #testing }
CGORepositoryVirtualPackageProvidersHandlerTest >> testGetWithFilterAndMultipleValues [
	| response |
	client 
		addPathSegment: 'foo-dbDriver';
		queryAt: #platform add: 'pharo';
		queryAt: #platform add: 'pharo3';
		get.
	self assert: client isSuccess.
	response := client contents collect: #asString.
	self assert: response equals: #('foo-mysql@1.0')
]
