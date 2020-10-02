Class {
	#name : #CGOVirtualPackageVersionTest,
	#superclass : #PBModelTest,
	#category : #'CargoPackageManager-FailingTests-Model'
}

{ #category : #tests }
CGOVirtualPackageVersionTest >> mailVirtualPackage [
	| virtualPkgVersion |
	virtualPkgVersion := CGOVirtualPackageVersion example.
	virtualPkgVersion
		instVarNamed: 'timestamp'
		put: (STON fromString: 'DateAndTime [ ''2017-02-03T11:11:15.370245+01:00'' ]').
	^ virtualPkgVersion
]

{ #category : #tests }
CGOVirtualPackageVersionTest >> testAsPackageVersionReference [
	| pkgVersion pkgVersionReference |
	pkgVersion := CGOVirtualPackageVersion fromString: 'V@1.0'.
	pkgVersionReference := pkgVersion asPackageVersionReference.
	self assert: pkgVersionReference asString equals: 'V@1.0.0'.

]

{ #category : #tests }
CGOVirtualPackageVersionTest >> testCanDeserialize [
	| stonString virtualPkgVersion |
	stonString := CGOPackageVersionWriterV1
		toStringPretty: self mailVirtualPackage.
	
	virtualPkgVersion := STON fromString: stonString.
	
	self
		assert: virtualPkgVersion
		equals: self mailVirtualPackage.
	self 	
		assert: virtualPkgVersion package class
		equals: CGOVirtualPackage 
]

{ #category : #tests }
CGOVirtualPackageVersionTest >> testCanSerializeInSTON [
	| stonString |
	stonString := CGOPackageVersionWriterV1 toStringPretty: self mailVirtualPackage.
	
	self
		assert: stonString
		equals: 'CGOPublishedVirtualPackage {
	#package : ''Mail'',
	#version : ''1.0.0'',
	#description : ''I respect the mail protocol V1.0. See link for more details.'',
	#timestamp : DateAndTime [ ''2017-02-03T11:11:15.370245+01:00'' ]
}'
]
