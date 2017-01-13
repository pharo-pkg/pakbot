tests
testLoadOrderHandlesCycles
	self 
		shouldnt: [ loadInstructionsBuilder loadOrder ]
		raise: MessageNotUnderstood