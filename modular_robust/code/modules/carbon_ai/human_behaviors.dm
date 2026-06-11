

// might make /datum/ai_behavior/monkey_equip make human NPCs equip only the loot they spawned with but lost somehow
// or make them look for the same loot

//might use pickpocketing code to make them stop moving when healing someone/themselves

// /datum/ai_behavior/monkey_flee can be probably left as is
// same with monkey_attack_mob, although i might need to add gun reloading later



// /obj/structure/closet/body_bag
// BB_HUMAN_HIDE_BODIES = TRUE

/datum/ai_behavior/human_disposal_mob
	behavior_flags = AI_BEHAVIOR_REQUIRE_MOVEMENT | AI_BEHAVIOR_MOVE_AND_PERFORM //performs to increase frustration

/datum/ai_behavior/human_disposal_mob/setup(datum/ai_controller/controller, attack_target_key, disposal_target_key)
	. = ..()
	set_movement_target(controller, controller.blackboard[attack_target_key])

/datum/ai_behavior/human_disposal_mob/finish_action(datum/ai_controller/controller, succeeded, attack_target_key, disposal_target_key)
	. = ..()
	controller.clear_blackboard_key(attack_target_key) //Reset attack target
	controller.set_blackboard_key(BB_MONKEY_DISPOSING, FALSE) //No longer disposing
	controller.clear_blackboard_key(disposal_target_key) //No target disposal

/datum/ai_behavior/human_disposal_mob/perform(seconds_per_tick, datum/ai_controller/controller, attack_target_key, disposal_target_key)
	if(controller.blackboard[BB_MONKEY_DISPOSING]) //We are disposing, don't do ANYTHING!!!!
		return AI_BEHAVIOR_DELAY

	var/mob/living/target = controller.blackboard[attack_target_key]
	var/mob/living/living_pawn = controller.pawn

	set_movement_target(controller, target)

	if(!target)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	if(target.pulledby != living_pawn && !HAS_AI_CONTROLLER_TYPE(target.pulledby, /datum/ai_controller/monkey/human)) //Steals from monkeys but not other people
		if(living_pawn.Adjacent(target) && isturf(target.loc))
			target.grabbedby(living_pawn)
		return AI_BEHAVIOR_DELAY //Do the rest next turn

	var/obj/structure/closet/disposal = controller.blackboard[disposal_target_key]
	set_movement_target(controller, disposal)

	if(!disposal)
		return AI_BEHAVIOR_DELAY | AI_BEHAVIOR_FAILED

	if(living_pawn.Adjacent(disposal))
		INVOKE_ASYNC(src, PROC_REF(try_disposal_mob), controller, attack_target_key, disposal_target_key) //put him in!
		return AI_BEHAVIOR_DELAY
	//This means we might be getting pissed!
	return AI_BEHAVIOR_DELAY

/datum/ai_behavior/human_disposal_mob/proc/try_disposal_mob(datum/ai_controller/controller, attack_target_key, disposal_target_key)
	var/mob/living/living_pawn = controller.pawn
	var/mob/living/target = controller.blackboard[attack_target_key]
	var/obj/structure/closet/disposal = controller.blackboard[disposal_target_key]

	controller.set_blackboard_key(BB_MONKEY_DISPOSING, TRUE)
//if the locker or bodybag is closed, open it
	if (disposal.opened == FALSE)
//freeing the hand so you can open the closet
		var/held_item = living_pawn.get_active_held_item()
		if (held_item!= null)
			living_pawn.dropItemToGround(held_item)
//interact with the closet with your hopefully open hand
		controller.ai_interact(target = disposal, combat_mode = FALSE)
//in case it was locked and clicking it opened it, check if it's still closed and click it again
		if (disposal.opened == FALSE)
			controller.ai_interact(target = disposal, combat_mode = FALSE)//clicking the closet once to open it
// pick up the dropped item now either way to not forget it later
		if (held_item!= null)
			living_pawn.put_in_hands(held_item)
//if disposal is still closed, give up
		if (disposal.opened == FALSE)
			controller.set_blackboard_key_assoc(BB_MONKEY_BLACKLISTITEMS, disposal)//Hopefully this will work with the blacklist
			finish_action(controller, FALSE, attack_target_key, disposal_target_key)
//when open, put the body inside
	disposal.mouse_drop_receive(target, living_pawn)//i hope this doesn't require the mob to have a client
	finish_action(controller, TRUE, attack_target_key, disposal_target_key)




//!!!!!!!!!!!!!!!!!
// /datum/ai_behavior/monkey_set_combat_target/perform
/datum/ai_behavior/human_set_combat_target/perform(seconds_per_tick, datum/ai_controller/controller, set_key, enemies_key)
	var/list/enemies = controller.blackboard[enemies_key]
	var/list/valids = list()
	for(var/mob/living/possible_enemy in view(MONKEY_ENEMY_VISION, controller.pawn))
		if(possible_enemy == controller.pawn)
			continue // don't target ourselves
		if(!enemies[possible_enemy]) //We don't hate this creature! But we might still attack it!
			if(!controller.blackboard[BB_MONKEY_AGGRESSIVE]) //We are not aggressive either, so we won't attack!
				continue
//!!!!!!!!!!!!!! make this actually work with factions propperly
//			if(possible_enemy.has_faction(list(FACTION_MONKEY, FACTION_JUNGLE)) && !controller.blackboard[BB_MONKEY_TARGET_MONKEYS]) // do not target your team. includes monkys gorillas etc.
//				continue
		// Weighted list, so the closer they are the more likely they are to be chosen as the enemy
		valids[possible_enemy] = CEILING(100 / (get_dist(controller.pawn, possible_enemy) || 1), 1)

	if(!length(valids))
		return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_FAILED

	controller.set_blackboard_key(set_key, pick_weight(valids))
	return AI_BEHAVIOR_INSTANT | AI_BEHAVIOR_SUCCEEDED
