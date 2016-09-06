private
hasChildNodes: aNode
	| children |
	
	[ children := nextBlock value: aNode ] 
		on: MessageNotUnderstood 
		do: [ ^ false ].
	^ children size > 0