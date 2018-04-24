instance creation
fromSton: stonReader
	"Decode the specific PackageVersion serialization format."
	| serializedPkgVersion |
	serializedPkgVersion := CGOVcsSerializedPackageUnit new fromSton: stonReader.
	serializedPkgVersion asOngoingPackage.