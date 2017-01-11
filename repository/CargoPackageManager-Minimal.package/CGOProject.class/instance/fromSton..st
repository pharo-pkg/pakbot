instance creation
fromSton: stonReader
	"Decode the Cargo serializable project format."
	| serializableProject |
	
	serializableProject := CGOSerializableProject new fromSton: stonReader.
	serializableProject flushIn: self.