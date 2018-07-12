loading
load
	groups 
		do: [ :group | group load ]
		displayingProgress: [ :group | 'Installing ' , group name ]