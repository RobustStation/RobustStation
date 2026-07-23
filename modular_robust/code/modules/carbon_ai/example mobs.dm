
/mob/living/carbon/human/species/ai
	ai_controller = /datum/ai_controller/monkey/human
	race = /datum/species/human
	var/npc_outfit = /datum/outfit/job/assistant

// /mob/living/carbon/human/proc/equipOutfit(outfit)

/mob/living/carbon/human/species/ai/angry // angry human wearing nothing
	ai_controller = /datum/ai_controller/monkey/human/hostile

/mob/living/carbon/human/species/ai/Initialize(mapload)
	. = ..()
	equipOutfit(npc_outfit)

//syndicate
/mob/living/carbon/human/species/ai/syndicate
	npc_outfit = /datum/outfit/syndicate_npc
	faction = list(ROLE_SYNDICATE)

/datum/outfit/syndicate_npc
	name = "Syndicate basic human"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	back = /obj/item/storage/backpack/fireproof
	ears = /obj/item/radio/headset/syndicate/alt
	backpack_contents = list(
		/obj/item/storage/box/survival/interdyne,
		/obj/item/ammo_box/magazine/smgm45,
	)
	r_hand = /obj/item/gun/ballistic/automatic/c20r
	belt = /obj/item/gun/ballistic/automatic/pistol/clandestine
	id = /obj/item/card/id/advanced/chameleon
	implants = list(/obj/item/implant/weapons_auth)

/mob/living/carbon/human/species/ai/syndicate/assasin
	ai_controller = /datum/ai_controller/monkey/human/assasin

// nt shocktroopers
/mob/living/carbon/human/species/ai/nt_trooper
	npc_outfit = /datum/outfit/nt_soldier_npc
	faction = list(ROLE_DEATHSQUAD)

/datum/outfit/nt_soldier_npc
	name = "NT Private Security basic human"
	uniform = /obj/item/clothing/under/rank/security/officer
	suit = /obj/item/clothing/suit/armor/vest
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/tackler/combat
	mask = /obj/item/clothing/mask/gas/sechailer/swat
	head = /obj/item/clothing/head/helmet/swat/nanotrasen
	back = /obj/item/storage/backpack/security
	id = /obj/item/card/id/advanced
	id_trim = /datum/id_trim/centcom/corpse/private_security
	r_hand = /obj/item/gun/ballistic/automatic/wt550
	belt = /obj/item/gun/ballistic/automatic/pistol/m1911

/mob/living/carbon/human/species/ai/nt_trooper/assasin
	ai_controller = /datum/ai_controller/monkey/human/assasin

// skeletons
/mob/living/carbon/human/species/ai/skeleton_knight
	race = /datum/species/skeleton
	ai_controller = /datum/ai_controller/monkey/human/hostile
	npc_outfit = /datum/outfit/skeleton_knight_npc
	faction = list(FACTION_SKELETON)


/datum/outfit/skeleton_knight_npc
	name = "skeleton knight npc"
	uniform = /obj/item/clothing/under/color/black
	suit = /obj/item/clothing/suit/armor/riot/knight/greyscale
	shoes = /obj/item/clothing/shoes/plate/larp //some of the armor is larper armor due to necromancer budget cuts
	gloves = /obj/item/clothing/gloves/plate/larp

	head = /obj/item/clothing/head/helmet/knight/greyscale
	back = /obj/item/storage/backpack

	r_hand = /obj/item/claymore/weak/weaker



