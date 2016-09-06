versions fetching
packagesProviding: aName version: aSemanticVersion for: platformAttributes
	(aName endsWith: '-virtual')
		ifTrue: [ (aSemanticVersion major < 3)
					ifTrue: [ ((platformAttributes isEmpty) or: [ platformAttributes includes: 'pharo' ])
								ifTrue: [^ #('Grease-Core@1.1.5') ] ] ].
	CGOPackageVersionNotFoundError signal