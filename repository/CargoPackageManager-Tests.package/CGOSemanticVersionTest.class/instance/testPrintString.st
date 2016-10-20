tests-parsing
testPrintString

	self assertVersion: '2' printStringEquals: '2.0.0'.
	self assertVersion: '1.2' printStringEquals: '1.2.0'.
	self assertVersion: '1.1.3' printStringEquals: '1.1.3'.
	self assertVersion: '1.1.3-RC1' printStringEquals: '1.1.3-RC1'