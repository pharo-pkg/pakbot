tests
testCanDeserializeDependency
	| dependency |
	dependency := STON fromString: 'CGOMetacelloBaselineProject {
	#baseline : #PakbotTestExample,
	#url : ''git://git@github.com/pharo-pkg/PakbotTestExample.git'',
	#version : ''0866472ddded2a8fc36d3bae23f01aecfe947dc7''
}'.
	self 
		assert: dependency repositoryUrl
		equals: 'git://git@github.com/pharo-pkg/PakbotTestExample.git' asZnUrl.
	self 
		assert: dependency version
		equals: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.