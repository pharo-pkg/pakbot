converting
asOngoingPackage
	"avoid nil values when a collection is expected"
	platformRequirements := self toArray: platformRequirements.
	provisions := self toArray: provisions.
	
	^ CGOOngoingPackageUnit new 	
		initializeFromVcsSerializedPackage: self