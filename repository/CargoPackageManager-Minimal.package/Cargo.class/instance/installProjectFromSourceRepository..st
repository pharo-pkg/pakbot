installing
installProjectFromSourceRepository: aCGOSourceRepository 
	| project |

	project := self useSourceRepository: aCGOSourceRepository.
	self package: project packageName version: project version.
	self install