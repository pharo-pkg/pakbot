testing
testGet
	| response |
	
	client 
		addPathSegment: 'foo-virtual';
		addPathSegment: '1.0.0';
		get.
	self assert: client isSuccess.
	response := client contents.
	self assert: response equals: #('Grease-Core@1.1.5')