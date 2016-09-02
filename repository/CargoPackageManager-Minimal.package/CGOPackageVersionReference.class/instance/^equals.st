comparing
= other
	^ self class = other class 
		and: [ self packageName = other packageName 
			and: [ self versionNumber = other versionNumber ] ]