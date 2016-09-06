BFS (see http://en.wikipedia.org/wiki/Breadth-first_search)  iterator.
We avoid to visit already visited children of a node.

	iterator := (BFSIterator 
		on: aGraphRoot 
		nextBlock: [ :parent | parent children]).
	[ iterator hasNext ] whileTrue: 
		[ iterator next ]