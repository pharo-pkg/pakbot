private
isRepositoryAlreadyCloned
	^ iceRepository location isNotNil
		and: [ iceRepository location exists
				and: [ iceRepository location hasChildren ] ]