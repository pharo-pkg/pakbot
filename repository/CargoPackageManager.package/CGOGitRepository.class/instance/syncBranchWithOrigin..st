private
syncBranchWithOrigin: branchName
	[ iceRepository branchName = branchName
		ifTrue: [ ^ self	"already in sync" ] ]
	on: IceNotInBranch
	do: [ "we are in DETACHED HEAD mode, let's chekout the branch" ].
	
	[ (iceRepository branchNamed: branchName) checkout ]
	on: IceBranchNotFound 
	do: [ (iceRepository remoteBranchNamed: 'origin/',branchName) checkout ].
	iceRepository fetch.
	iceRepository hasIncomingCommits
		ifTrue: [ iceRepository pull ]