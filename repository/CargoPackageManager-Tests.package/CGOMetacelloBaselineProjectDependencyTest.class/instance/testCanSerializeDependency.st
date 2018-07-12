tests
testCanSerializeDependency
	| projectDependencyString |
	projectDependencyString := STON toStringPretty: CGOMetacelloBaselineProject example.
	
	self 
		assert: projectDependencyString
		equals: 'CGOMetacelloBaselineProject {
	#baseline : #PakbotTestExample,
	#url : ''git://git@github.com/pharo-pkg/PakbotTestExample.git'',
	#version : ''0866472ddded2a8fc36d3bae23f01aecfe947dc7''
}'.