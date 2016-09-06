testing
testGetWithFilterAndMultipleValues
	| response |
	client 
		addPathSegment: 'foo-dbDriver';
		queryAt: #platform add: 'pharo';
		queryAt: #platform add: 'pharo3';
		get.
	self assert: client isSuccess.
	response := client contents collect: #asString.
	self assert: response equals: #('foo-mysql@1.0')