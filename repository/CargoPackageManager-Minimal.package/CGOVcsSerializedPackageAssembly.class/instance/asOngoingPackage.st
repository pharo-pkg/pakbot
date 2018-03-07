converting
asOngoingPackage
	"avoid nil values when a collection is expected"
	parts := self toArray: parts.

	^ CGOOngoingPackageAssembly new 
		initializeFromVcsSerializedPackage: self