loading
fetchInto: aMCRepository
	groups 
		do: [ :group | group fetchInto: aMCRepository ]
		displayingProgress: [ :group | 'Fetching ' , group name ]