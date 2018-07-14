Class {
	#name : #PBMetacelloProjectTest,
	#superclass : #TestCase,
	#category : 'CargoPackageManager-Tests-Model'
}

{ #category : #tests }
PBMetacelloProjectTest >> testCanCreateAPBMetacelloProjectFromABaselineProjectDependency [
	| project |
	project := PBMetacelloBaselineProject exampleConfiguration.
	
	self 
		assert: project name
		equals: 'PakbotTestExample'.
	
	self
		assert: project version
		equals: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.
		
	self 	
		assert: project repository
		equals: 'git://git@github.com/pharo-pkg/PakbotTestExample.git' asZnUrl.
		
	self assert: project isConfiguration
]

{ #category : #tests }
PBMetacelloProjectTest >> testCanCreateAPBMetacelloProjectFromAConfigurationProjectDependency [
	| project |
	project := PBMetacelloConfigurationProject exampleConfiguration.
	
	self 
		assert: project name
		equals: 'JSON'.
	
	self
		assert: project version
		equals: #stable.
		
	self 	
		assert: project repository
		equals: 'http://smalltalkhub.com/mc/PharoExtras/JSON/main/' asZnUrl.
		
	self assert: project isConfiguration
]
