tests
testCanCreateAPBMetacelloProjectFromABaselineProjectDependency
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