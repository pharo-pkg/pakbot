testing
testGet
	| response |

	client
		addPathSegment: 'Grease-Core';
		addPathSegment: 'latest';
		get;
		yourself.
	self assert: client isSuccess.
	response := client contents.
	self assert: (response isKindOf: CGOPackageVersion).
	self assert: response asString equals: 'Grease-Core@1.1.5'