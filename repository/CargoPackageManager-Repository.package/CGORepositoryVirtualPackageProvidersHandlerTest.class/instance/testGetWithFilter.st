testing
testGetWithFilter
	| response |
	
	client 
		addPathSegment: 'foo-dbDriver';
		queryAt: #platform add: 'pharo';
		get.
	self assert: client isSuccess.
	response := client contents collect: #asString.
	self assert: response equals: #('foo-mysql@1.0')