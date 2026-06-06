//should make the summoner control summoned creatures instead of them just going around and doing whatever
//currently only ensures the creatures aren't hostile to their summoner
/datum/action/cooldown/spell/conjure/limit_summons/adv
	name = "Advanced conjuring"
	desc = "Summons creatures and gives more control over them to the caster"
	background_icon_state = "bg_rose" //idk what this background is and i think there's no other action that uses it
	button_icon_state = "statue"
	spell_requirements = SPELL_REQUIRES_NO_ANTIMAGIC
	summon_radius = 1
	max_summons = 100 //most of the summon spells are unlimited, but it inherits limit_summons just in case something needs it.
//	summon_lifespan = 0
//	summon_amount = 1
//when true, the mob only has the summoner's factions and not the factions it should have by default, so a summoned goliath would fight naturally spawning ones.
	var/override_faction = TRUE
	var/tame = TRUE

//commands given to the mob if it isn't tameable by default
	var/static/list/pet_commands = list( // not sure why it's static but it is like this in all of the mob code i used as a refference
		/datum/pet_command/idle,
		/datum/pet_command/move,
		/datum/pet_command/free,
		/datum/pet_command/follow,
		/datum/pet_command/attack,
		/datum/pet_command/fetch,
		/datum/pet_command/play_dead,
		/datum/pet_command/protect_owner,
	)


/datum/action/cooldown/spell/conjure/limit_summons/adv/post_summon(atom/summoned_object, atom/cast_on)
	if(!istype(summoned_object, /mob/living))
		return
	var/mob/living/L = summoned_object //the creature being summoned (i suppose)

	if(!istype(summoned_object, /mob/living))
		return
	var/mob/living/C = cast_on //caster of the spell (i hope)

	if (override_faction)
		L.faction = C.faction
	else
		L.faction |= C.faction

	if (tame)
		var/datum/component/obeys_commands/obeysc = L.GetExactComponent(/datum/component/obeys_commands)
		if (obeysc == null)
			obeysc = L.AddComponent(/datum/component/obeys_commands, pet_commands)
		obeysc.add_friend(C) // tames the creature

	return



/*
EXAMPLE SPELLS
(not used for anything yet, but could be useful for custom antags)
*/

/mob/living/basic/mouse/rat/conjured
	melee_damage_lower = 3
	melee_damage_upper = 3 //because i hate RNG
	obj_damage = 4
	maxHealth = 12
	health = 12

/datum/action/cooldown/spell/conjure/limit_summons/adv/rats
	name = "Summon rats"
	desc = "Summons rats that obey your commands"
	background_icon_state = "bg_rose"
	button_icon = 'icons/mob/actions/actions_animal.dmi'
	button_icon_state = "coffer"//the rat king icons don't have rats on them, this one at least has cheese
	summon_type = list(/mob/living/basic/mouse/rat/conjured)
	summon_lifespan = 15 SECONDS
	cooldown_time = 30 SECONDS
	summon_amount = 5


/datum/action/cooldown/spell/conjure/limit_summons/adv/bloodvine
	name = "Summon bloodvines"
	desc = "Summons rats that obey your commands"
	background_icon_state = "bg_rose"
	button_icon = 'modular_robust/code/modules/horrorstation ports/icons.dmi'
	button_icon_state = "locker_hermit"
	summon_type = list(/mob/living/simple_animal/hostile/horrormob/bloodvine)
	summon_lifespan = 6 SECONDS
	cooldown_time = 20 SECONDS
	summon_amount = 3

