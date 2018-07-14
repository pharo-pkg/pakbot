Class {
	#name : #CGORepositoryPackageListHandlerTest,
	#superclass : #CGORepositoryTest,
	#category : 'CargoPackageManager-Repository-Tests'
}

{ #category : #running }
CGORepositoryPackageListHandlerTest >> setUp [
	super setUp.
	client addPathSegment: 'packages'
]

{ #category : #testing }
CGORepositoryPackageListHandlerTest >> testGet [
	| response |
	
	client get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response class equals: Array.
	self assert: response size equals: 67
]
