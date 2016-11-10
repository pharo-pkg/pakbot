private
repositories
	self flag: 'TO REMOVE'.
	repositories ifNil: [ repositories := OrderedCollection new ].
	^ repositories 