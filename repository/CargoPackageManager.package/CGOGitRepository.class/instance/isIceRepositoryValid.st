private
isIceRepositoryValid
	^ (iceRepository isKindOf: IceRepository)
		and: [ iceRepository isValid ]