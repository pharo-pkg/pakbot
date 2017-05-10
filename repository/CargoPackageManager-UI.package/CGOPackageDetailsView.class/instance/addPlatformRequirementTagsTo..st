building
addPlatformRequirementTagsTo: morph
	"ongoingPackageUnit platformRequirements do: [ :string | morph addMorph: (self tagFactory text: string asMorph) morph ]"