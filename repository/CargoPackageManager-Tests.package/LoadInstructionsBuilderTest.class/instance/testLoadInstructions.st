tests
testLoadInstructions
	| loadInstructions pkgVersionReferences |

	loadInstructions := sorter loadInstructions.
	self assert: loadInstructions groups size equals: 5.
	pkgVersionReferences := loadInstructions groups 
		flatCollect: [ :aPackageGroup | aPackageGroup packageVersions ].
	pkgVersionReferences withIndexDo: 
		[ :pkgVersionReference :index | 
		self
			assert: pkgVersionReference asString
			equals: (self expectedSortResult at: index) ].