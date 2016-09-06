as yet unclassified
seaside31LoadingInOrder
| files gofer |

files := #(	'Grease-Core-JohanBrichau.83' 
			'Grease-Pharo30-Core-pmm.11' 
			'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28' 
			'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30' 
			'Zinc-HTTP-SvenVanCaekenberghe.388').
gofer := Gofer new.
gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Grease11').
gofer repository: (MCHttpRepository location: 'http://mc.stfx.eu/ZincHTTPComponents' ).
files do: [ :file | gofer version: file ].
gofer load.

files := #(	'Grease-Core-JohanBrichau.83' 
			'Grease-Pharo30-Core-pmm.11' 
			'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28' 
			'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30' 
			'Zinc-HTTP-SvenVanCaekenberghe.388' 
			'Seaside-Core-pmm.808' 
			'Seaside-Pharo20-Core-pmm.3' 
			'Seaside-Component-pmm.101' 
			'Seaside-Canvas-pmm.127' 
			'Seaside-Pharo-Canvas-pmm.4' 
			'Seaside-Session-pmm.168' 
			'Seaside-RenderLoop-JohanBrichau.95' 
			'Seaside-Tools-Core-pmm.23'
			'Seaside-Pharo-Tools-Spec-pmm.9' 
			'Seaside-Flow-pmm.24' 

			'Seaside-Examples-pmm.24' 
			'Seaside-Widgets-pmm.33' 
			'Seaside-Pharo-Flow-lr.5'
			'Seaside-Tools-Web-pmm.118' 
			'Seaside-Pharo20-Tools-Web-JohanBrichau.3' 
			'Seaside-Development-pmm.163' 
			'Seaside-Pharo-Development-JohanBrichau.66' 		

			'Seaside-Environment-pmm.81' 
			'Seaside-Pharo-Environment-lr.6' 
			'Zinc-Seaside-SvenVanCaekenberghe.40' 
			'Javascript-Core-pmm.95' 
			'Javascript-Pharo20-Core-JohanBrichau.4' 
			'JQuery-Core-pmm.128' 
			'JQuery-UI-pmm.88' 
			'Seaside-Welcome-pmm.47'
			'Seaside-Pharo-Welcome-NickAger.2' 
			'Seaside-Pharo-Continuation-lr.5' 
			).

files do: [ :file | 
    gofer := Gofer new.
    gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Seaside31').
    gofer repository: (MCHttpRepository location: 'http://mc.stfx.eu/ZincHTTPComponents' ).

    gofer version: file.
    gofer load ].

"test with: ZnZincServerAdaptor startOn: 8080 "