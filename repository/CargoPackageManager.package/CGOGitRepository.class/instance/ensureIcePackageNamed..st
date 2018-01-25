private
ensureIcePackageNamed: aPackageName
	^ [ self iceRepository packageNamed: aPackageName ]
		on: NotFound 
		do: [ self iceRepository addPackageNamed: aPackageName ]