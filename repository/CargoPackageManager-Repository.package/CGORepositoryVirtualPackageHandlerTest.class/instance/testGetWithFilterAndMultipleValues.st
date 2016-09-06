testing
testGetWithFilterAndMultipleValues
	| response |
	
	client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '1.0.0';
		queryAt: #platform add: 'pharo';
		queryAt: #platform add: 'pharo3';
		get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #('Grease-Core@1.1.5')