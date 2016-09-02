comparing
= other
	(self major = other major) ifFalse: [ ^ false ].
	(self minor = other minor) ifFalse: [ ^ false ].
	(self patch = other patch) ifFalse: [ ^ false ].
	(self suffix = other suffix) ifFalse: [ ^ false ].
	^ true