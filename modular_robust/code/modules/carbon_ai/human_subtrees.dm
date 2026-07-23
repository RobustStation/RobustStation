



///monkey combat subtree.// now human
/datum/ai_planning_subtree/human_combat/SelectBehaviors(datum/ai_controller/monkey/human/controller, seconds_per_tick)
	var/mob/living/living_pawn = controller.pawn
	var/list/enemies = controller.blackboard[BB_MONKEY_ENEMIES]

	if((HAS_TRAIT(controller.pawn, TRAIT_PACIFISM)) || (!length(enemies) && !controller.blackboard[BB_MONKEY_AGGRESSIVE])) //Pacifist, or we have no enemies and we're not pissed
		living_pawn.set_combat_mode(FALSE)
		return
// if there's no target, find a new one
	if(!controller.blackboard[BB_MONKEY_CURRENT_ATTACK_TARGET])
		controller.queue_behavior(/datum/ai_behavior/human_set_combat_target, BB_MONKEY_CURRENT_ATTACK_TARGET, BB_MONKEY_ENEMIES)
		living_pawn.set_combat_mode(FALSE)
		return SUBTREE_RETURN_FINISH_PLANNING

	var/mob/living/selected_enemy = controller.blackboard[BB_MONKEY_CURRENT_ATTACK_TARGET]
// if enemy stopped existing, stop targeting it
	if(QDELETED(selected_enemy))
		living_pawn.set_combat_mode(FALSE)
		return

	if(!selected_enemy.stat) //He's up, get him!
		if(living_pawn.health < MONKEY_FLEE_HEALTH) //Time to skeddadle
			controller.queue_behavior(/datum/ai_behavior/monkey_flee)
			return SUBTREE_RETURN_FINISH_PLANNING //I'm running fuck you guys

		if(controller.TryFindWeapon()) //Getting a weapon is higher priority if im not fleeing.
			return SUBTREE_RETURN_FINISH_PLANNING
//recruiting more monkeys to help.
/* //removing it for now because teamwork is hard to implement
		if(controller.blackboard[BB_MONKEY_RECRUIT_COOLDOWN] < world.time)
			controller.queue_behavior(/datum/ai_behavior/recruit_monkeys, BB_MONKEY_CURRENT_ATTACK_TARGET)
			return
*/

/* // makes the monkey scream. probably unneeded for humans
		if(SPT_PROB(ismonkey(living_pawn) ? 25 : 10, seconds_per_tick))
			controller.queue_behavior(/datum/ai_behavior/battle_screech/monkey)
*/
		controller.queue_behavior(/datum/ai_behavior/human_attack_mob, BB_MONKEY_CURRENT_ATTACK_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	//by this point we have a target but they're down, let's try dumpstering this loser

	living_pawn.set_combat_mode(FALSE)
// finding where to put the corpse
	if(!controller.blackboard[BB_MONKEY_TARGET_DISPOSAL]) //if we don't have a targeted place for disposal
// for some reason the code isn't sure that the controller is human one and not the monkey one, so i need to add another check for it
//		if (!istype(controller, /datum/ai_controller/monkey/human))
//			return
//		var/datum/ai_controller/monkey/human/controller_human = controller
//if we're trying to hide bodies in plain sight, put them in a nearby locker
		if(controller.blackboard[BB_HUMAN_HIDE_BODIES])
			controller.queue_behavior(/datum/ai_behavior/find_and_set, BB_MONKEY_TARGET_DISPOSAL, /obj/structure/closet, MONKEY_ENEMY_VISION)
		else
//otherwise, put them specifically in a body bag
			controller.queue_behavior(/datum/ai_behavior/find_and_set, BB_MONKEY_TARGET_DISPOSAL, /obj/structure/closet/body_bag, MONKEY_ENEMY_VISION)
		return

	controller.queue_behavior(/datum/ai_behavior/human_disposal_mob, BB_MONKEY_CURRENT_ATTACK_TARGET, BB_MONKEY_TARGET_DISPOSAL)
	return SUBTREE_RETURN_FINISH_PLANNING

/// Finds food or drinks, picks them up, then gives them to nearby humans
// might remake it into planning subtree for healing allies
/*
/datum/ai_planning_subtree/serve_food

/datum/ai_planning_subtree/serve_food/SelectBehaviors(datum/ai_controller/monkey/controller, seconds_per_tick)
	var/mob/living/living_pawn = controller.pawn
	var/list/nearby_patrons = list()
	for(var/mob/living/carbon/human/human_mob in oview(5, living_pawn))
		if(istype(human_mob.mind?.assigned_role, /datum/job/bartender))
			return //  my boss is on duty!
		if(human_mob.stat != CONSCIOUS || ismonkey(human_mob))
			continue
		if(!human_mob.get_empty_held_indexes())
			continue
		nearby_patrons += human_mob

	// Need at least 2 patrons to bother serving (bearing in mind the
	if(length(nearby_patrons) < 1)
		return

	var/obj/item/serving = controller.blackboard[BB_MONKEY_CURRENT_SERVED_ITEM]
	if(QDELETED(serving) || serving.reagents.total_volume <= 0)
		controller.queue_behavior(/datum/ai_behavior/find_and_set/food_or_drink/to_serve, BB_MONKEY_CURRENT_SERVED_ITEM, /obj/item, 2)
		return

	// we have something to serve, pick a patron and go hand it over
	if(living_pawn.is_holding(serving))
		controller.blackboard[BB_MONKEY_CURRENT_GIVE_TARGET] ||= pick(nearby_patrons)
		controller.queue_behavior(/datum/ai_behavior/give, BB_MONKEY_CURRENT_GIVE_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	// we have something to serve but aren't holding it yet
	if(isturf(serving.loc))
		// fetch the drink
		controller.queue_behavior(/datum/ai_behavior/navigate_to_and_pick_up, BB_MONKEY_CURRENT_SERVED_ITEM, TRUE)
	else
		// give up on the dream
		controller.clear_blackboard_key(BB_MONKEY_CURRENT_SERVED_ITEM)
	return SUBTREE_RETURN_FINISH_PLANNING
*/





// i'll figure whatever the fuck that is later
/*
/datum/ai_planning_subtree/monkey_shenanigans/SelectBehaviors(datum/ai_controller/monkey/controller, seconds_per_tick)

	if(prob(5))
		controller.queue_behavior(/datum/ai_behavior/use_in_hand)

	if(!SPT_PROB(MONKEY_SHENANIGAN_PROB, seconds_per_tick))
		return

	if(!controller.blackboard[BB_MONKEY_CURRENT_PRESS_TARGET])
		if(controller.blackboard[BB_MONKEY_PRESS_TYPEPATH])
			controller.queue_behavior(/datum/ai_behavior/find_and_set, BB_MONKEY_CURRENT_PRESS_TARGET, controller.blackboard[BB_MONKEY_PRESS_TYPEPATH], 2)
		else
			controller.queue_behavior(/datum/ai_behavior/find_nearby, BB_MONKEY_CURRENT_PRESS_TARGET)
	else if(prob(50))
		controller.queue_behavior(/datum/ai_behavior/use_on_object, BB_MONKEY_CURRENT_PRESS_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(!controller.blackboard[BB_MONKEY_CURRENT_GIVE_TARGET])
		controller.queue_behavior(/datum/ai_behavior/find_and_set/pawn_must_hold_item, BB_MONKEY_CURRENT_GIVE_TARGET, /mob/living/carbon/human, 2)
	else if(prob(controller.blackboard[BB_MONKEY_GIVE_CHANCE]))
		controller.queue_behavior(/datum/ai_behavior/give, BB_MONKEY_CURRENT_GIVE_TARGET)
		return SUBTREE_RETURN_FINISH_PLANNING

	if(!controller.blackboard[BB_MONKEY_TAMED])
		controller.TryFindWeapon()
*/










