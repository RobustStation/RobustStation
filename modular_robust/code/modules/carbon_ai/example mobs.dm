

/mob/living/carbon/human/ai
	ai_controller = /datum/ai_controller/monkey/human
	var/npc_outfit = /datum/outfit/job/assistant

// /mob/living/carbon/human/proc/equipOutfit(outfit)

/mob/living/carbon/human/ai/Initialize(mapload)
	. = ..()
	equipOutfit(npc_outfit)

/mob/living/carbon/human/ai/syndicate
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

/mob/living/carbon/human/ai/syndicate/assasin
	ai_controller = /datum/ai_controller/monkey/human/assasin

/mob/living/carbon/human/ai/nt_trooper
	npc_outfit = /datum/outfit/nt_soldier_npc
	faction = list(ROLE_DEATHSQUAD)

/datum/outfit/nt_soldier_npc
	name = "NT Private Security Officer"
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

/mob/living/carbon/human/ai/nt_trooper/assasin
	ai_controller = /datum/ai_controller/monkey/human/assasin



