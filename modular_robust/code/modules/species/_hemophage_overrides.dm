// ROBUST OVERRIDE - makes all hemophages into masquerades
// TRAIT_MASQUERADE_FOOD
#define HEMOPHAGE_OVER_DESC "This is a work in progress."

/datum/species/hemophage
	name = "Human?"
	plural_form = "Humans"


/datum/species/hemophage/get_species_description()
	return HEMOPHAGE_OVER_DESC


/datum/species/hemophage/get_species_lore()
	return list(
		"More information to be filled in later.",
		"Roleplay standards:",
		"Masquerade culture is strongly upheld by Hemophage specimen. Known Hemophages are often seen with disgust and pity.",
		"Hemophages must protect their identity at all costs.",
		"For the Hemophages who cannot, they will be beholden to the discretion of the Medical wing, or left to act upon their survivalist impulses.",
	)


#undef HEMOPHAGE_OVER_DESC
