checking
assertVersion: aSymbolicVersionString printStringEquals: aString
	| version |
	
	version := SemanticVersion fromString: aSymbolicVersionString.
	self assert: version printString equals: aString.