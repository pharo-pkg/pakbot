testing
testGet
	| response |
	
	client get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response class equals: Array.
	self assert: response size equals: 68