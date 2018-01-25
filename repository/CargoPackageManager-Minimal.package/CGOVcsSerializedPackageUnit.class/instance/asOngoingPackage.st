converting
asOngoingPackage
	"avoid nil values when a collection is expected"
	platformRequirements := self toArray: platformRequirements.
	provisions := self toArray: provisions.
	
	^ CGOOngoingPackageUnit2 new 	
		initializeFromVcsSerializedPackage: self