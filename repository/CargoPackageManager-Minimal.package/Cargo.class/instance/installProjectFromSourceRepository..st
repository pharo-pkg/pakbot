installing
installProjectFromSourceRepository: aCGOSourceRepository 
	| project scmMetadata |

	scmMetadata := CGOScmPackageMetadata new.
	repositories := repositories copyWithFirst: scmMetadata.
	project := scmMetadata registerProjectFromSourceRepository: aCGOSourceRepository.

	self package: project asPackageAssembly.
	self install