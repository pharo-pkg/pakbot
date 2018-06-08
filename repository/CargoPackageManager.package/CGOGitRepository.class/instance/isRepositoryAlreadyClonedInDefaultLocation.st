private
isRepositoryAlreadyClonedInDefaultLocation
	^ iceRepository location isNil
		and: [ iceRepository defaultLocation exists
				and: [ iceRepository defaultLocation hasChildren ] ]