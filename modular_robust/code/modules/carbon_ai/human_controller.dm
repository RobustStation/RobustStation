#define BB_HUMAN_HIDE_BODIES "BB_human_hide_bodies"

/datum/ai_controller/monkey/human
	ai_movement = /datum/ai_movement/basic_avoidance_human
	movement_delay = 0.4 SECONDS
	planning_subtrees = list(
		/datum/ai_planning_subtree/generic_resist,
		/datum/ai_planning_subtree/human_combat,
		/datum/ai_planning_subtree/generic_hunger,
		/datum/ai_planning_subtree/generic_play_instrument,
//		/datum/ai_planning_subtree/monkey_shenanigans,
	)

	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_MONKEY_AGGRESSIVE = FALSE,
		BB_MONKEY_BEST_FORCE_FOUND = 7, // default unarmed attack damage average, if a weapon is worse than that, just punch instead of using it
		BB_MONKEY_ENEMIES = list(),
		BB_MONKEY_BLACKLISTITEMS = list(),
		BB_MONKEY_PICKPOCKETING = FALSE,
		BB_MONKEY_DISPOSING = FALSE,
		BB_MONKEY_GUN_NEURONS_ACTIVATED = TRUE,
		BB_HUMAN_HIDE_BODIES = FALSE, //hide them in lockers that are nearly everywhere instead of putting them in body bags
		BB_SONG_LINES = MONKEY_SONG,
		BB_RESISTING = FALSE,
		BB_MONKEY_GIVE_CHANCE = 5,
	)
	idle_behavior = /datum/idle_behavior/idle_monkey


//this should replace the monkeybrain examine text instead of adding a second line to it but i guess that's for later
/datum/ai_controller/monkey/human/New(atom/new_pawn)
	var/static/list/control_examine = list(
		ORGAN_SLOT_EYES = span_notice("%PRONOUN_They seem%PRONOUN_s to have a basic form of intelligence."),
	)
	AddElement(/datum/element/ai_control_examine, control_examine)
	return ..()



/datum/ai_controller/monkey/human/hostile
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_MONKEY_AGGRESSIVE = TRUE,
		BB_MONKEY_BEST_FORCE_FOUND = 7, // default unarmed attack damage average, if a weapon is worse than that, just punch instead of using it
		BB_MONKEY_ENEMIES = list(),
		BB_MONKEY_BLACKLISTITEMS = list(),
		BB_MONKEY_PICKPOCKETING = FALSE,
		BB_MONKEY_DISPOSING = FALSE,
		BB_MONKEY_GUN_NEURONS_ACTIVATED = TRUE,
		BB_HUMAN_HIDE_BODIES = FALSE,
		BB_SONG_LINES = MONKEY_SONG,
		BB_RESISTING = TRUE,
		BB_MONKEY_GIVE_CHANCE = 5,
	)

// automatically hostile and hides the bodies
/datum/ai_controller/monkey/human/assasin
	blackboard = list(
		BB_TARGETING_STRATEGY = /datum/targeting_strategy/basic,
		BB_MONKEY_AGGRESSIVE = TRUE,
		BB_MONKEY_BEST_FORCE_FOUND = 7, // default unarmed attack damage average, if a weapon is worse than that, just punch instead of using it
		BB_MONKEY_ENEMIES = list(),
		BB_MONKEY_BLACKLISTITEMS = list(),
		BB_MONKEY_PICKPOCKETING = FALSE,
		BB_MONKEY_DISPOSING = FALSE,
		BB_MONKEY_GUN_NEURONS_ACTIVATED = TRUE,
		BB_HUMAN_HIDE_BODIES = TRUE, //hide them in lockers that are nearly everywhere instead of putting them in body bags
		BB_SONG_LINES = MONKEY_SONG,
		BB_RESISTING = TRUE,
		BB_MONKEY_GIVE_CHANCE = 5,
	)


// human movement: basic avoidance
// mostly copypasted from code/datums/ai/movement/ai_movement_basic_avoidance.dm

///Uses Byond's basic obstacle avoidance movement
/datum/ai_movement/basic_avoidance_human
	max_pathing_attempts = 10
	/// Movement flags to pass to the loop
	var/move_flags = NONE

/datum/ai_movement/basic_avoidance_human/start_moving_towards(datum/ai_controller/controller, atom/current_movement_target, min_distance)
	. = ..()
	var/atom/movable/moving = controller.pawn
	var/min_dist = controller.blackboard[BB_CURRENT_MIN_MOVE_DISTANCE]
// human movement change
	if (!istype(controller.pawn, /mob/living))
		return //i hope return doesn't fuck up the sequence. Just don't put controllers with this onto items and this will be enough
	var/mob/living/living_pawn = controller.pawn

	var/mob_nextmove_delay = living_pawn.next_move - world.time
// if this doesn't work, try making the ai movement update the next move thing somehow
	var/delay = max(controller.movement_delay,mob_nextmove_delay)
// human movement change end
	var/datum/move_loop/loop = GLOB.move_manager.move_to(moving, current_movement_target, min_dist, delay, flags = move_flags, subsystem = SSai_movement, extra_info = controller)
	RegisterSignal(loop, COMSIG_MOVELOOP_PREPROCESS_CHECK, PROC_REF(pre_move))
	RegisterSignal(loop, COMSIG_MOVELOOP_POSTPROCESS, PROC_REF(post_move))

// if(HAS_TRAIT(src, TRAIT_INCAPACITATED))


//make it check if it's next move time has come
/datum/ai_movement/basic_avoidance_human/allowed_to_move(datum/move_loop/has_target/dist_bound/source)
	var/turf/target_turf = get_step_towards(source.moving, source.target)
	if(!target_turf?.can_cross_safely(source.moving))
		return FALSE
	return ..()

/// Move immediately and don't update our facing
/datum/ai_movement/basic_avoidance/backstep
	move_flags = MOVEMENT_LOOP_START_FAST | MOVEMENT_LOOP_NO_DIR_UPDATE
