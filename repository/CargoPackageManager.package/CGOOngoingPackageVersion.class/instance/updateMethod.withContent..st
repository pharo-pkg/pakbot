private - utilities
updateMethod: aSelector withContent: aSmalltalkExpression
	| source tree |
	source := aSelector , Character cr asString, Character tab asString , '^ ', aSmalltalkExpression.
	tree := RBParser parseMethod: source.
	manifest class
		compile: tree formattedCode
		classified: 'meta-data'