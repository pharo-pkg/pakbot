"
Test extension made on IceMetacelloRepository
"
Class {
	#name : #PBIceMetacelloRepositoryTest,
	#superclass : #TestCase,
	#category : #'Pakbot-Tests-Metacello-Support'
}

{ #category : #tests }
PBIceMetacelloRepositoryTest >> testCanGetHttpsUrlFromAMetacelloGitHubUrl [
	
	| urlString |
	urlString :=  IceMetacelloRepositoryType httpsUrlFor: 'github://pharo-contributions/XML-XMLParser/src'.
	
	self
		assert: urlString
		equals: 'https://github.com/pharo-contributions/XML-XMLParser.git'
]
