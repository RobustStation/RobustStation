
//area
/area/centcom/opfor_room
	name = "Opfor room"
	requires_power = FALSE
	area_flags = NOTELEPORT
	default_gravity = STANDARD_GRAVITY
	flags_1 = NONE

//the ghost roles

/obj/effect/mob_spawn/ghost_role/human/allprefs
	name = "One time spawner"
	prompt_name = "all preference ghostrole"
	flavour_text = "A one use ghost role spawner that lets you join the round as your character without a job."
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	allow_mechanical_loadout_items = TRUE

/obj/effect/mob_spawn/ghost_role/human/opfor
	name = "Opfor ghostrole template"
	prompt_name = "Opfor spawner"
	flavour_text = "Spawn as an opfor character with no items other than your loadout."
	infinite_use = TRUE
	deletes_on_zero_uses_left = FALSE
	allow_custom_character = GHOSTROLE_TAKE_PREFS_APPEARANCE
	loadout_enabled = TRUE
	quirks_enabled = TRUE
	allow_mechanical_loadout_items = TRUE

/obj/effect/mob_spawn/ghost_role/human/opfor/assistant
	name = "Assistant opfor ghostrole template"
	prompt_name = "Opfor assistant spawner"
	flavour_text = "Spawn as an opfor character with assistant gear applied before your loadout."
	outfit = /datum/outfit/job/assistant

/obj/effect/mob_spawn/ghost_role/human/opfor/syndicate
	name = "Syndicate opfor ghostrole template"
	prompt_name = "Opfor syndicate spawner"
	flavour_text = "Spawn as an opfor character with syndicate gear applied before your loadout. \
	Doesn't include an uplink, but you can ask for it in the opfor request."
	outfit = /datum/outfit/syndicate_empty

/obj/effect/mob_spawn/ghost_role/human/opfor/wizard
	name = "Wizard opfor ghostrole template"
	prompt_name = "Opfor wizard spawner"
	flavour_text = "Spawn as an opfor character with wizard gear applied before your loadout. \
	Doesn't include the spellbook, but you can ask for it in the opfor request."
	outfit = /datum/outfit/wizard/bookless

/obj/effect/mob_spawn/ghost_role/human/opfor/wizard/academy
	name = "Academy wizard opfor ghostrole template"
	prompt_name = "Opfor academy wizard spawner"
	flavour_text = "Spawn as an opfor character with academy wizard gear applied before your loadout. \
	Doesn't include the spellbook, but you can ask for it in the opfor request."
	outfit = /datum/outfit/wizard/academy

//guide

/obj/item/paper/fluff/opfor_guide
	name = "Opfor system guide"
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	default_raw_text = "<b><center>The opfor guide</b></center><br><br><center> \
	You can use the opfor request verb to ask admins for an antagonist or a non-crew role. It could be anything, \
	even custom antagonists, as long as it contributes to roleplay at least somehow. The full opfor policy for robuststation \
	is not written yet, but in short the main point is: Don't murderbone for no reason, have a character with at least a \
	basic motivation to DO SOMETHING, and have your character's lore correspond with the lore of the server (or at least \
	not contradict it intentionally). After you're done preparing, ask admins to teleport you out of the room to the place \
	where your character should appear. </center>"



