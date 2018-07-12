tests
testLoadOrder
	| packages |

	packages := sorter loadOrder flattened collect: #resolvedProjectVersion.
	"self assert: packages equals: #()"
	1 to: packages size do: [ :index |
		self 
			assertPackage: (packages at: index)
			equals: (self expectedSortResult at: index) ]