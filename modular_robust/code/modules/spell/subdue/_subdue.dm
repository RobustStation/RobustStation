// new spell types in development. they don't fully work but maybe they'll get eventually finished by our successors
/datum/action/cooldown/spell/pointed/subdue
	name = "Subdue"
	desc = "Makes a creature follow your commands"
	background_icon_state = "bg_demon"
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "gib"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	school = SCHOOL_PSYCHIC
//removes it's old factions after adding the new ones from the caster
	var/override_faction = TRUE //works
//makes the target follow commands. without it just makes the target non-hostile to the caster
	var/tame = TRUE // doesn't work but tries to
// when enabled, only allows you to subdue mobs from allowed_types
	var/check_mob_type = FALSE
	var/allowed_types = list(/mob/living/basic,/mob/living/simple_animal/hostile)

//commands given to the mob if it isn't tameable by default
	var/static/list/pet_commands = list(
		/datum/pet_command/idle,
		/datum/pet_command/move,
		/datum/pet_command/free,
		/datum/pet_command/follow,
		/datum/pet_command/attack,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
		/datum/pet_command/protect_owner
	)

//allows you to subdue a mob already tamed by somebody else. set to false by default, enable it only for very evil spells
	var/steal_pets = FALSE // doesn't prevent pet stealing yet until i find a propper way to make a check that finds if the pet has any owners

/datum/action/cooldown/spell/pointed/subdue/is_valid_target(atom/cast_on)
	if(!isliving(cast_on)) //checks if mob can be alive, not if the mob is alive.
		to_chat(owner, span_warning("[cast_on] is not a living creature."))
		return FALSE

	var/mob/living/target = cast_on
	if(target.mind)
		to_chat(owner, span_warning("target's mind is too strong to subdue."))
		return FALSE

	if(!steal_pets && FALSE) // replace "false" with a check that finds if the mob has any owners
		to_chat(owner, span_warning("[cast_on] is already loyal to someone else."))
		return FALSE
// using that shit from code/__HELPERS/_lists.dm to get if the mob is of a reuqired type
	if(check_mob_type && !is_type_in_list(target,allowed_types))
		to_chat(owner, span_warning("[name] can not subdue a creature of this type."))
		return FALSE

	return TRUE

/// Called on atoms summoned after they are created, allows extra variable editing and such of created objects
/datum/action/cooldown/spell/pointed/subdue/cast(mob/living/cast_on)
	if (override_faction)
		cast_on.faction = owner.faction
	else
		cast_on.faction |= owner.faction

	if (tame)
		var/datum/component/obeys_commands/obeysc = cast_on.GetExactComponent(/datum/component/obeys_commands)
		if (obeysc == null)
			obeysc = cast_on.AddComponent(/datum/component/obeys_commands, pet_commands)
		obeysc.add_friend(owner) // tames the creature

	return



/datum/action/cooldown/spell/pointed/subdue/lavaland
	name = "Subdue lavaland creature"
	desc = "Makes lavaland creatures allied to you."
	background_icon_state = "bg_demon"
	button_icon = 'icons/mob/actions/actions_cult.dmi'
	button_icon_state = "dominate"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	school = SCHOOL_PSYCHIC
	override_faction = TRUE
	check_mob_type = TRUE
	allowed_types = list(/mob/living/basic/mining,/mob/living/basic/mining/goliath)
// check if it also correctly works with subtypes by trying to subdue /mob/living/basic/mining/lobstrosity for example


/datum/action/cooldown/spell/pointed/subdue/demon
	name = "Subdue demon"
	desc = "Makes demons allied to you."
	background_icon_state = "bg_demon"
	button_icon = 'icons/mob/simple/lavaland/lavaland_monsters.dmi'
	button_icon_state = "brimdemon"
	background_icon_state = "bg_demon"
	overlay_icon_state = "bg_demon_border"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	school = SCHOOL_PSYCHIC
	override_faction = TRUE
	check_mob_type = TRUE
	allowed_types = list(/mob/living/basic/demon,/mob/living/simple_animal/hostile/megafauna/demonic_frost_miner,/mob/living/basic/mining/watcher,/mob/living/basic/mining/brimdemon)
