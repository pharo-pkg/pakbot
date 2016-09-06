tests
testLoadOrderHandlesCycles
	self 
		shouldnt: [ sorter loadOrder ]
		raise: MessageNotUnderstood