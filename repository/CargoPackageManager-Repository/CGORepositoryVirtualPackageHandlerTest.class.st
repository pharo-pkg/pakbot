Class {
	#name : #CGORepositoryVirtualPackageHandlerTest,
	#superclass : #CGORepositoryTest,
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #running }
CGORepositoryVirtualPackageHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'virtualpackages'
]

{ #category : #testing }
CGORepositoryVirtualPackageHandlerTest >> testGet [
	| response |
	
	client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '1.0.0';
		get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #('Grease-Core@1.1.5')
]

{ #category : #testing }
CGORepositoryVirtualPackageHandlerTest >> testGetUnknownPackage [
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
CGORepositoryVirtualPackageHandlerTest >> testGetUnknownVersion [
	[ client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '12.40.6';
		get;
		yourself. ]
		on: ZnHttpUnsuccessful 
		do: [ "ignore" ].
	self assert: client isNotFound
]

{ #category : #testing }
CGORepositoryVirtualPackageHandlerTest >> testGetWithFilter [
	| response |
	
	client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '1.0.0';
		queryAt: #platform add: 'pharo';
		get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #('Grease-Core@1.1.5')
]

{ #category : #testing }
CGORepositoryVirtualPackageHandlerTest >> testGetWithFilterAndMultipleValues [
	| response |
	
	client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '1.0.0';
		queryAt: #platform add: 'pharo';
		queryAt: #platform add: 'pharo3';
		get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #('Grease-Core@1.1.5')
]
