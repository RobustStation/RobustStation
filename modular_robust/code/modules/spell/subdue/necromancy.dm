// revives corpses and makes them not hostile towards you if they had AI
// should also make them follow your commands but something is wrong
/datum/action/cooldown/spell/pointed/subdue/necromancy
	name = "Necromancy"
	desc = "Raises creatures from the dead and makes them follow your commands. Might even work on dead humans, but the results are not very reliable"
	button_icon_state = "splattercasting"
	school = SCHOOL_NECROMANCY //duh
	override_faction = TRUE
	tame = TRUE
	cooldown_time = 55 SECONDS
/*
	pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/move,
		/datum/pet_command/free,
		/datum/pet_command/follow,
		/datum/pet_command/attack,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead, //add a command that makes them die for real later
		/datum/pet_command/protect_owner,
	)
*/
	var/heal_amount = 400 // just to make sure

/datum/action/cooldown/spell/pointed/subdue/necromancy/is_valid_target(atom/cast_on)
	. = ..()
	var/mob/living/target = cast_on
	if(target.stat != DEAD)
		if (!HAS_TRAIT(target, TRAIT_NOBREATH)) //heheheheee
			to_chat(owner, span_warning("[cast_on] is not dead."))
		return FALSE

	return TRUE


/datum/action/cooldown/spell/pointed/subdue/necromancy/cast(mob/living/cast_on)
	cast_on.adjust_brute_loss(-heal_amount)
	cast_on.adjust_fire_loss(-heal_amount)
	cast_on.adjust_tox_loss(-heal_amount)
	cast_on.adjust_oxy_loss(-heal_amount)
	cast_on.revive()
	if (!HAS_TRAIT(cast_on, TRAIT_UNHUSKABLE))
		ADD_TRAIT(cast_on, TRAIT_HUSK, BURN)
	. = ..()
	return



