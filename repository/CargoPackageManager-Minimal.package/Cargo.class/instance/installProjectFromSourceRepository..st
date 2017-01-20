installing
installProjectFromSourceRepository: aCGOSourceRepository 
	| project |

	project := self useSourceRepository: aCGOSourceRepository.
	self package: project.
	self install