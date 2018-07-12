tests
testCanCreateDependency
	| dependency |
	dependency := CGOMetacelloBaselineProject example.
	self 
		assert: dependency name
		equals: #PakbotTestExample.
	self 
		assert: dependency repositoryUrl asString
		equals: 'git://git@github.com/pharo-pkg/PakbotTestExample.git'.
	self 
		assert: dependency version
		equals: '0866472ddded2a8fc36d3bae23f01aecfe947dc7'.