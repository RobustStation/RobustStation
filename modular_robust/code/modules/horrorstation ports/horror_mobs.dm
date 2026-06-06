//from my old codebase i worked on some time in 2023

/mob/living/simple_animal/hostile/horrormob
	name = "Debug horrormob"
	desc = "You should shit yourself NOW!"
	icon = 'modular_robust/code/modules/horrorstation ports/icons.dmi'

// originally copypasted from  statue code
// now copypasted from /datum/component/unobserved_actor/proc/check_if_seen(mob/living/source)
/mob/living/simple_animal/hostile/horrormob/proc/can_be_seen(turf/my_turf)
	// Check for darkness
	if(my_turf.lighting_object && my_turf.get_lumcount() < 0.1) // No one can see us in the darkness, right?
		return FALSE

	// We aren't in darkness, loop for viewers.
	for(var/mob/living/mob_target in oview(my_turf, 7)) // They probably cannot see us if we cannot see them... can they?
		if(mob_target.client && !mob_target.is_blind() && !HAS_TRAIT(mob_target, TRAIT_UNOBSERVANT))
			return TRUE
	for(var/obj/vehicle/sealed/mecha/mecha_mob_target in oview(my_turf, 7))
		for(var/mob/mechamob_target as anything in mecha_mob_target.occupants)
			if(mechamob_target.client && !mechamob_target.is_blind() && !HAS_TRAIT(mechamob_target, TRAIT_UNOBSERVANT))
				return TRUE

	return FALSE

/*
/mob/living/simple_animal/hostile/horrormob/proc/can_be_seen(turf/destination)
	// Check for darkness
	var/turf/T = get_turf(loc)
	if(T && destination && T.lighting_object)
		if(T.get_lumcount()<0.1 && destination.get_lumcount()<0.1) // No one can see us in the darkness, right?
			return null
		if(T == destination)
			destination = null
	var/list/check_list = list(src)
	if(destination)
		check_list += destination
	for(var/atom/check in check_list)
		for(var/mob/living/M in viewers(getexpandedview(world.view, 1, 1), check))
			if(M != src && M.client && CanAttack(M) && !M.has_unlimited_silicon_privilege && !M.eye_blind)
				return M
		for(var/obj/mecha/M in view(getexpandedview(world.view, 1, 1), check)) //assuming if you can see them they can see you
			if(M.occupant?.client && !M.occupant.eye_blind)
				return M.occupant
	return null
*/

/mob/living/simple_animal/hostile/horrormob/FindHidden()
	return 0 // So most horror mobs don't search for people in lockers



// i used collosus code as a template, so there may be some leftover megafauna code and some errors related to it
/mob/living/simple_animal/hostile/horrormob/blink
	name = "Blink"
	desc = ""
	health = 180 // to create an illusion that it can be damaged and doesn't teleport away faster than you can reach your gun
	maxHealth = 250
	attack_verb_continuous = "judges"
	attack_verb_simple = "judge"
	attack_sound = 'sound/effects/magic/clockwork/ratvar_attack.ogg'
	icon_state = "blink"
	icon_living = "blink"
	icon_dead = ""
	icon = 'modular_robust/code/modules/horrorstation ports/96x96.dmi'
	speak_emote = list("roars")
	armour_penetration = 10
	melee_damage_lower = 30
	melee_damage_upper = 30
	speed = 10
	move_to_delay = 1
	pixel_x = -32
	del_on_death = TRUE
	death_message = "disintegrates."
	death_sound = 'sound/effects/fuse.ogg'
//	search_objects = 1
//	wanted_objects = list(/obj/machinery/light) //they overhauled mob AI so idk how to work with these
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES

/mob/living/simple_animal/hostile/horrormob/blink/Move(turf/NewLoc)
	if(can_be_seen(NewLoc))
		disappear()
		return 0
	return ..()

/mob/living/simple_animal/hostile/horrormob/blink/proc/disappear()
	src.icon_state = "blink_disappearing"
	src.icon_living = "blink_disappearing"
	sleep(6)
	var/turf/safe_turf = find_safe_turf(zlevels = src.z, extended_safety_checks = TRUE)
	do_teleport(src,safe_turf,channel = TELEPORT_CHANNEL_MAGIC)
	sleep(4)
	src.icon_state = "blink"
	src.icon_living = "blink"

//originally they were supposed to hide in lockers and ambush people who open them, but i failed to
//implement that back then
// maybe i'll try to redo it when i learn how mob ai works after the overhauls
/*
/mob/living/simple_animal/hostile/horrormob/hermit
	name = "Hermit"
	desc = ""
	health = 100
	maxHealth = 100
	attacktext = "bites"
	attack_sound = 'sound/mobs/non-humanoids/fish/fish_slap1.ogg'
	icon_state = "locker_hermit"
	icon_living = "locker_hermit"
	icon_dead = "locker_hermit_dead" //apparently they didn't have a dead icon by default
	speak_emote = list("roars")
	armour_penetration = 5
	melee_damage_lower = 13
	melee_damage_upper = 13
	speed = 10
	move_to_delay = 4
	search_objects = 1
	wanted_objects = list(/obj/structure/closet)
	vision_range = 5
	aggro_vision_range = 12

/mob/living/simple_animal/hostile/horrormob/hermit/AttackingTarget()
	if(target == /obj/structure/closet)
		var/obj/structure/closet/Cl = target
		Cl.dive_into(src)
		return
	else
		return ..()

/mob/living/simple_animal/hostile/horrormob/hermit/EscapeConfinement()
	return //so it doesn't just destroy lockers from the inside
*/

//////////////////////////////////// Eyes statue
/mob/living/basic/statue/eyes
	name = "statue"
	desc = "A statue made from cheap concrete or sandstone and covered in scrap copper plates. No idea what the eyes are made from though."
	icon = 'modular_robust/code/modules/horrorstation ports/icons.dmi'
	icon_state = "statue_eyes"
	icon_living = "statue_eyes"
	icon_dead = "statue_eyes_dead" //i guess my last backup was from an old version of horrorstation because i had to remake this icon from memory too
	melee_damage_lower = 10
	melee_damage_upper = 10
//	vision_range = 20
	maxHealth = 50
	health = 50
	maximum_survivable_temperature = 1200 // so they can be killed with localised plasmafires, but incendiary weapons are not effective

/mob/living/simple_animal/hostile/statue/eyes/AttackingTarget()
	. = ..()

/* // I guess this part is now handled by the element that prevents them from moving
	if(target == /turf/closed/wall)
		return FALSE
	if(can_be_seen(get_turf(loc)))
		if(client)
			to_chat(src, span_warning("You cannot attack, there are eyes on you!"))
		return FALSE
*/
	if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.Paralyze(2 SECONDS, TRUE, TRUE)
		C.spin(50,1)
		C.adjust_stamina_loss(40)
		C.adjust_oxy_loss(30)
		C.adjust_temp_blindness(2 SECONDS)
//		C.blind_eyes(1)
		var/turf/safe_turf = find_safe_turf(zlevels = src.z, extended_safety_checks = TRUE)
		do_teleport(target,safe_turf,channel = TELEPORT_CHANNEL_MAGIC)
		return ..()




// there was supposed to be an invisible horrormob who takes photos of you but i couldn't code that back then either


//=-=-=-=-=-
//NEW MOBS
//=-=-=-=-=-
//remade the barely functioning hermits into a mob that just bites you without anything unusual
/mob/living/simple_animal/hostile/horrormob/bloodvine
	name = "Bloodvine"
	desc = ""
	health = 80
	maxHealth = 80
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = 'sound/mobs/non-humanoids/fish/fish_slap1.ogg'
	icon_state = "locker_hermit"
	icon_living = "locker_hermit"
	icon_dead = "locker_hermit_dead" //apparently they didn't have a dead icon by default
	speak_emote = list("roars")
	armour_penetration = 5
	melee_damage_lower = 10
	melee_damage_upper = 10
	speed = 10
	move_to_delay = 4



