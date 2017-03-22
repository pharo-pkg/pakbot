tests - versions fetching
testLatestVersionOfPackageSuitableForEnvironment
	| result |

	self flag: 'This test is failing randomly: sometimes success, sometimes error. Skip it till it has a reproducible status'.
	^ self skip.
		
	"result := repository 
				latestVersionOf: #'Zinc-HTTP'
				suitableForEnvironment: #().
	self 
		assert: result first asString
		equals: 'Zinc-HTTP@2.5.2'"