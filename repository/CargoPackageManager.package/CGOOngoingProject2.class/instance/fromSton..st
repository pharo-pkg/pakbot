ston
fromSton: stonReader
	"Decode the Cargo serialized project."
	| serializedProject |
	
	serializedProject := CGOVcsSerializedProject new fromSton: stonReader.
	self registry: CGOPackageRegistry default.
	serializedProject flushIn: self.