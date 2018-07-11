specs
retrieveSpec: aSelector

	| layout |
	
	layout := self perform: aSelector.
	layout isSpecLayout ifTrue: [ layout selector: aSelector ].
	^ layout