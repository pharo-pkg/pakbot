instance creation
fromRepository: aCGOSourceRepository
	| ongoing |
	ongoing := self fromStonString: aCGOSourceRepository projectMetadataStonString.
	ongoing repository: aCGOSourceRepository.
	^ ongoing