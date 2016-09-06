testing
testGet
	| response |
	
	client 
		addPathSegment: 'foo-dbDriver';
		get.
	self assert: client isSuccess.
	response := client contents collect: #asString.
	self assert: response equals: #('foo-mysql@1.0')