tests
testLoadInstructions
	| loadInstructions pkgVersionReferences |

	loadInstructions := loadInstructionsBuilder loadInstructions.
	self assert: loadInstructions groups size equals: 5.
	pkgVersionReferences := loadInstructions groups 
		flatCollect: [ :aPackageGroup | aPackageGroup packageVersions ].
	self
		assert: (pkgVersionReferences collect: #asString as: Array)
		equals: self expectedSortResult.