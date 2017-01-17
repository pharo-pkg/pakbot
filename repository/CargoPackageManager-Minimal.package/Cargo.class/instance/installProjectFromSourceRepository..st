installing
installProjectFromSourceRepository: aCGOSourceRepository 
	| project |

	project := self useSourceRepository: aCGOSourceRepository.
	self package: project asPackageAssembly.
	self install