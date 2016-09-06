as yet unclassified
seaside31LoadingAnyOrder
| files gofer |
files := #('Seaside-Tools-Core-pmm.23' 'Seaside-Pharo20-Core-pmm.3' 'Seaside-Pharo-Welcome-NickAger.2' 'JQuery-Core-pmm.128' 'Seaside-Component-pmm.101' 'Seaside-Pharo-Continuation-lr.5' 'Javascript-Core-pmm.95' 'Seaside-Pharo20-Tools-Web-JohanBrichau.3' 'Grease-Core-JohanBrichau.83' 'Grease-Pharo30-Core-pmm.11' 'Seaside-Tools-Web-pmm.118' 'Zinc-Seaside-SvenVanCaekenberghe.40' 'Javascript-Pharo20-Core-JohanBrichau.4' 'Seaside-Environment-pmm.81' 'Seaside-Development-pmm.163' 'Seaside-Examples-pmm.24' 'JQuery-UI-pmm.88' 'Seaside-RenderLoop-JohanBrichau.95' 'Seaside-Pharo-Environment-lr.6' 'Seaside-Pharo-Tools-Spec-pmm.9' 'Seaside-Core-pmm.808' 'Seaside-Widgets-pmm.33' 'Seaside-Session-pmm.168' 'Seaside-Pharo-Flow-lr.5' 'Seaside-Pharo-Development-JohanBrichau.66' 'Seaside-Flow-pmm.24' 'Zinc-Character-Encoding-Core-SvenVanCaekenberghe.28' 'Zinc-HTTP-SvenVanCaekenberghe.388' 'Zinc-Resource-Meta-Core-SvenVanCaekenberghe.30' 'Seaside-Canvas-pmm.127' 'Seaside-Pharo-Canvas-pmm.4' 'Seaside-Welcome-pmm.47').

gofer := Gofer new.
gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Seaside31').
gofer repository: (MCSmalltalkhubRepository owner: 'Seaside' project: 'Grease11').
gofer repository: (MCHttpRepository location: 'http://mc.stfx.eu/ZincHTTPComponents' ).

files do: [ :file | gofer version: file ].

gofer load