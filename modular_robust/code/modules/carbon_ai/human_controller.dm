
/datum/ai_controller/monkey/human
	ai_movement = /datum/ai_movement/basic_avoidance
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

//make that work with factions too!!!!!!!!!!!!!!!!!!!!!!!!!!
// /datum/targeting_strategy/basic/monkey/faction_check(datum/ai_controller/controller, mob/living/living_mob, mob/living/the_target)
//nevermind might just use /datum/targeting_strategy/basic


/datum/ai_controller/monkey/human/New(atom/new_pawn)
	var/static/list/control_examine = list(
		ORGAN_SLOT_EYES = span_notice("%PRONOUN_They seem%PRONOUN_s to have a basic form of intelligence."),
	)
	AddElement(/datum/element/ai_control_examine, control_examine)
	return ..()



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
