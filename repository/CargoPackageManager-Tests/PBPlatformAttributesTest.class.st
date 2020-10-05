"
A PBPlatformAttributesTest is a test class for testing the behavior of PBPlatformAttributes
"
Class {
	#name : #PBPlatformAttributesTest,
	#superclass : #TestCase,
	#category : #'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBPlatformAttributesTest >> testCanGetOSAttribute [
	| attributes |
	attributes := PBPlatformAttributes new.
	
	self assert: (attributes operatingSystem includesSubstring: OSPlatform current family).
	self assert: (attributes operatingSystem includesSubstring: OSPlatform current name).
	self assert: (attributes operatingSystem includesSubstring: OSPlatform current version).
]

{ #category : #tests }
PBPlatformAttributesTest >> testCanGetSmalltalkAttribute [
	| attributes |
	attributes := PBPlatformAttributes new.
	
	self assert: (attributes smalltalk beginsWith: 'Smalltalk::Pharo').
	self assert: (attributes smalltalk includesSubstring: SystemVersion current dottedMajorMinor)
]
