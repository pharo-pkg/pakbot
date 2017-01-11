private
ensureIcePackageNamed: aPackageName
	| iceRepository |
	iceRepository := self iceRepository.
	^ [ iceRepository packageNamed: packageName ]
		on: NotFound 
		do: [ iceRepository addPackageNamed: aPackageName ]