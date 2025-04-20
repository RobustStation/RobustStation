#define MAIN_ADDR "byond://main.robuststation.k.vu:7777"
#define BETA_ADDR "byond://beta.robuststation.k.vu:7777"

#define BETA_SERVER "RobustStation Beta (NORP tests, usually offline!)"
#define MAIN_SERVER "RobustStation Main (LRP-MRP, stable)"

/client/verb/go2relay()
	var/list/static/relays = list(
		MAIN_SERVER,
		BETA_SERVER
	)
	var/choice = tgui_input_list(usr, "Which server do you wish to connect to?", "Server Select", relays)
	var/destination
	switch(choice)
		if(MAIN_SERVER)
			destination = MAIN_ADDR
		if(BETA_SERVER)
			destination = BETA_ADDR
	if(destination)
		usr << link(destination)
		sleep(1 SECONDS)
		winset(usr, null, "command=.quit")
	else
		usr << "You didn't select a server."

#undef MAIN_ADDR
#undef BETA_ADDR

#undef MAIN_SERVER
#undef BETA_SERVER
