versions fetching
packagesProviding: aName for: platformAttributes
	(aName = #'foo-dbDriver')
		ifTrue: [ ((platformAttributes isEmpty) or: [ platformAttributes includes: 'pharo' ])
						ifTrue: [^ #('foo-mysql@1.0') ] ].
	CGOPackageNotFoundError signal