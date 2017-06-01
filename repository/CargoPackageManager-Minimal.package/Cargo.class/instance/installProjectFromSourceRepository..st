installing
installProjectFromSourceRepository: aCGOSourceRepository 
	| project |

	project := self useSourceRepository: aCGOSourceRepository.
	self package: project name version: project version.
	self install