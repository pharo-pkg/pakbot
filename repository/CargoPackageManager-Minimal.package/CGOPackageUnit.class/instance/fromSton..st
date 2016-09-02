ston
fromSton: stonReader
	"Decode the specific PackageVersion serialization format."
	| serializedPkgVersion |
	serializedPkgVersion := CGOSerializedPackageUnit new fromSton: stonReader.
	serializedPkgVersion flushIn: self.