converting
asSerializableSourcePackageVersion
	"urls serialized by STON show internal implementation of Urls and is not user friendly. To avoid that ensure that repositoryUrl is encoded as a String."
	^ self copy
		instVarNamed: 'repositoryUrl' put: repositoryUrl asString;
		yourself 