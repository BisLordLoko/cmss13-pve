/obj/item/device/helmet_visor
	name = "AN/PAV-70 visor"
	desc = "The guts of a Personal-Augmented-Viewer HUD unit. Fitted as-standard in almost all helmets in use by UA forces."
	icon = 'icons/obj/items/clothing/helmet_visors.dmi'
	icon_state = "hud_sight"
	w_class = SIZE_TINY

	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY)

	///The sound when toggling on the visor
	var/toggle_on_sound = 'sound/handling/hud_on.ogg'

	///The sound when toggling off the visor
	var/toggle_off_sound = 'sound/handling/hud_off.ogg'

	///The icon name for our helmet's action, in 'icons/obj/items/clothing/helmet_visors.dmi'
	var/action_icon_string = "hud_sight_down"

	///The overlay name for when our visor is active, in 'icons/mob/humans/onmob/helmet_garb.dmi'
	var/helmet_overlay = "hud_sight_right"

/obj/item/device/helmet_visor/Destroy(force)
	if(!istype(loc, /obj/item/clothing/head/helmet/marine))
		return ..()

	if(!istype(loc?.loc, /mob/living/carbon/human))
		return ..()

	var/obj/item/clothing/head/helmet/marine/attached_helmet = loc
	var/mob/living/carbon/human/user = loc.loc
	deactivate_visor(attached_helmet, user)
	. = ..()

// Visors can attach to all marine helmets by default
/obj/item/device/helmet_visor/proc/can_attach_to(obj/item/clothing/head/helmet/target_helmet)
	return TRUE

/// Called to see if the user can even use this visor
/obj/item/device/helmet_visor/proc/can_toggle(mob/living/carbon/human/user)
	return TRUE

/// Called to see if this visor is a special non-HUD visor
/obj/item/device/helmet_visor/proc/toggle_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user, silent = FALSE)
	if(attached_helmet == user.head && attached_helmet.active_visor == src)

		if(!can_toggle(user))
			return FALSE

		activate_visor(attached_helmet, user)

		if(!silent)
			to_chat(user, SPAN_NOTICE("You activate the [src] on the [attached_helmet]."))
			playsound_client(user.client, toggle_on_sound, null, 75)

		return TRUE

	deactivate_visor(attached_helmet, user)

	if(!silent)
		to_chat(user, SPAN_NOTICE("You deactivate the [src] on the [attached_helmet]."))
		playsound_client(user.client, toggle_off_sound, null, 75)

	return TRUE

/// Called by toggle_visor() to activate the visor's effects
/obj/item/device/helmet_visor/proc/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	for(var/type in hud_type)
		var/datum/mob_hud/current_mob_hud = GLOB.huds[type]
		current_mob_hud.add_hud_to(user, attached_helmet)

/// Called by toggle_visor() to deactivate the visor's effects
/obj/item/device/helmet_visor/proc/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	for(var/type in hud_type)
		var/datum/mob_hud/current_mob_hud = GLOB.huds[type]
		current_mob_hud.remove_hud_from(user, attached_helmet)

/obj/item/device/helmet_visor/process(delta_time)
	return PROCESS_KILL

/// Called by /obj/item/clothing/head/helmet/marine/get_examine_text(mob/user) to get extra examine text for this visor
/obj/item/device/helmet_visor/proc/get_helmet_examine_text()
	return SPAN_NOTICE("\A [name] is flipped down.")

/obj/item/device/helmet_visor/upp
	name = "KKV-66M visor"
	desc = "The KKV-66M \"Geist\" is an augmented-reality Heads Up Display developed by Germany. Standard for all helmets in use by the UPP's armed forces."
	hud_type = list(MOB_HUD_FACTION_UPP)

/obj/item/device/helmet_visor/medical
	name = "AN/MPAV-71 visor"
	desc = "The guts of a Medical/Personal-Augmented-Viewer HUD unit. Uncommon to see in use outside of US Army units."
	icon_state = "med_sight"
	hud_type = list(MOB_HUD_MEDICAL_BASIC)
	action_icon_string = "med_sight_down"
	helmet_overlay = "med_sight_right"

/obj/item/device/helmet_visor/medical/army
	name = "AN/MPAV-71A visor"
	desc = "The guts of a Medical/Personal-Augmented-Viewer HUD unit. This one has US Army markings on its casing."
	helmet_overlay = "med_sight_left"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_MEDICAL_BASIC)

/obj/item/device/helmet_visor/medical/advanced
	name = "AN/MAV-72 visor"
	desc = "The guts of a Medical-Augmented-Viewer HUD unit. Links to the biomonitors of allied personnel and provides detailed information for those able to comprehend it."
	helmet_overlay = "med_sight_right"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_MEDICAL_ADVANCED)

/obj/item/device/helmet_visor/medical/advanced/pmc
	hud_type = list(MOB_HUD_FACTION_PMC, MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY, MOB_HUD_MEDICAL_ADVANCED)

/obj/item/device/helmet_visor/medical/advanced/twe
	hud_type = list(MOB_HUD_FACTION_WY, MOB_HUD_FACTION_TWE, MOB_HUD_MEDICAL_ADVANCED)

/obj/item/device/helmet_visor/medical/advanced/upp
	hud_type = list(MOB_HUD_FACTION_UPP, MOB_HUD_MEDICAL_ADVANCED)

/obj/item/device/helmet_visor/medical/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	. = ..()
	for(var/type in hud_type)
		var/datum/mob_hud/current_mob_hud = GLOB.huds[type]
		current_mob_hud.add_hud_to(user, attached_helmet)

/obj/item/device/helmet_visor/medical/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	. = ..()
	for(var/type in hud_type)
		var/datum/mob_hud/current_mob_hud = GLOB.huds[type]
		current_mob_hud.remove_hud_from(user, attached_helmet)

/obj/item/device/helmet_visor/medical/process(delta_time)
	return PROCESS_KILL

/obj/item/device/helmet_visor/medical/advanced/can_toggle(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return

	if(!skillcheck(user, SKILL_MEDICAL, SKILL_MEDICAL_MEDIC))
		to_chat(user, SPAN_NOTICE("You are not skilled enough to use [src]."))
		return FALSE

	return TRUE

/obj/item/device/helmet_visor/medical/advanced/ui_state(mob/user)
	return GLOB.not_incapacitated_and_adjacent_strict_state

/obj/item/device/helmet_visor/medical/advanced/ui_data(mob/user)
	var/list/data = list(
		"published_documents" = GLOB.chemical_data.research_publications,
		"terminal_view" = FALSE
	)
	return data

/obj/item/device/helmet_visor/medical/advanced/tgui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if (!ui)
		ui = new(user, src, "PublishedDocsHud", name)
		ui.open()

/obj/item/device/helmet_visor/medical/advanced/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	if(!ishuman(ui.user))
		return

	var/mob/living/carbon/human/user = ui.user

	if(user.stat || user.is_mob_restrained() || !in_range(src, user))
		return

	switch(action)
		if ("read_document")
			var/print_type = params["print_type"]
			var/print_title = params["print_title"]
			var/obj/item/paper/research_report/report = GLOB.chemical_data.get_report(print_type, print_title)
			if(report)
				report.read_paper(user)
			return

/datum/action/item_action/view_publications/helmet_visor/action_activate()
	. = ..()
	var/obj/item/device/helmet_visor/medical/advanced/medical_visor = locate() in holder_item

	if(!medical_visor)
		return

	medical_visor.tgui_interact(owner)

/obj/item/device/helmet_visor/security
	name = "AN/JPAV-73"
	desc = "The guts of a Judicial/Personal-Augmented-Viewer HUD unit. Uncommon to see in use outside of military police units."
	icon_state = "sec_sight"
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_SECURITY_ADVANCED)
	action_icon_string = "sec_sight_down"
	helmet_overlay = "sec_sight_right"

/obj/item/device/helmet_visor/welding_visor
	name = "welding visor"
	desc = "An integrated heavily-polarized welding screen that can be quickly deployed & retracted as needed by the operator."
	icon_state = "sight_empty"
	hud_type = null
	action_icon_string = "blank_hud_sight_down"
	helmet_overlay = "weld_visor"

/obj/item/device/helmet_visor/welding_visor/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	attached_helmet.vision_impair = VISION_IMPAIR_MAX
	attached_helmet.flags_inventory |= COVEREYES|COVERMOUTH
	attached_helmet.flags_inv_hide |= HIDEEYES|HIDEFACE
	attached_helmet.eye_protection = EYE_PROTECTION_WELDING
	user.update_tint()

/obj/item/device/helmet_visor/welding_visor/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	attached_helmet.vision_impair = VISION_IMPAIR_NONE
	attached_helmet.flags_inventory &= ~(COVEREYES|COVERMOUTH)
	attached_helmet.flags_inv_hide &= ~(HIDEEYES|HIDEFACE)
	attached_helmet.eye_protection = EYE_PROTECTION_NONE
	user.update_tint()

/obj/item/device/helmet_visor/welding_visor/mercenary
	helmet_overlay = ""

/obj/item/device/helmet_visor/welding_visor/tanker
	helmet_overlay = "tanker_weld_visor"

#define NVG_VISOR_USAGE(delta_time) (power_cell.use(power_use * (delta_time ? delta_time : 1)))

/obj/item/device/helmet_visor/night_vision
	name = "night vision optic"
	desc = "An insertable visor HUD into a standard USCM helmet. This type gives a form of night vision and is standard issue in units with regular funding."
	icon_state = "nvg_sight"
	hud_type = null
	action_icon_string = "nvg_sight_down"
	helmet_overlay = "nvg_sight_right"
	toggle_on_sound = 'sound/handling/toggle_nv1.ogg'
	toggle_off_sound = 'sound/handling/toggle_nv2.ogg'

	/// The internal battery for the visor
	var/obj/item/cell/high/power_cell

	/// About 5 minutes active use charge (hypothetically)
	var/power_use = 33

	/// The alpha of darkness we set to for the mob while the visor is on, not completely fullbright but see-able
	var/lighting_alpha = 100

	/// A slight glowing green light while the NVG is activated, is initialized as in the attached_helmet's contents
	var/atom/movable/nvg_light/on_light

	/// Whether or not the sight uses on_light and produces light
	var/visor_glows = TRUE

/obj/item/device/helmet_visor/night_vision/Initialize(mapload, ...)
	. = ..()
	power_cell = new(src)

/obj/item/device/helmet_visor/night_vision/Destroy()
	power_cell = null
	. = ..()

/obj/item/device/helmet_visor/night_vision/get_examine_text(mob/user)
	. = ..()

	. += SPAN_NOTICE("It is currently at [floor((power_cell.charge / power_cell.maxcharge) * 100)]% charge.")

/obj/item/device/helmet_visor/night_vision/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	RegisterSignal(user, COMSIG_HUMAN_POST_UPDATE_SIGHT, PROC_REF(on_update_sight))

	user.add_client_color_matrix("nvg_visor", 99, color_matrix_multiply(color_matrix_saturation(0), color_matrix_from_string("#7aff7a")))
	user.overlay_fullscreen("nvg_visor", /atom/movable/screen/fullscreen/flash/noise/nvg)
	user.overlay_fullscreen("nvg_visor_blur", /atom/movable/screen/fullscreen/brute/nvg, 3)
	user.update_sight()
	if(visor_glows)
		on_light = new(attached_helmet)
		on_light.set_light_on(TRUE)
	START_PROCESSING(SSobj, src)
	RegisterSignal(user, COMSIG_MOB_CHANGE_VIEW, PROC_REF(change_view))

/obj/item/device/helmet_visor/night_vision/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	user.remove_client_color_matrix("nvg_visor", 1 SECONDS)
	user.clear_fullscreen("nvg_visor", 0.5 SECONDS)
	user.clear_fullscreen("nvg_visor_blur", 0.5 SECONDS)

	if(visor_glows)
		qdel(on_light)
	UnregisterSignal(user, COMSIG_HUMAN_POST_UPDATE_SIGHT)
	UnregisterSignal(user, COMSIG_MOB_CHANGE_VIEW)

	user.update_sight()
	STOP_PROCESSING(SSobj, src)

/obj/item/device/helmet_visor/night_vision/process(delta_time)
	if(!NVG_VISOR_USAGE(delta_time))

		if(!istype(loc, /obj/item/clothing/head/helmet/marine))
			return PROCESS_KILL

		if(!istype(loc?.loc, /mob/living/carbon/human))
			return PROCESS_KILL

		var/obj/item/clothing/head/helmet/marine/attached_helmet = loc
		var/mob/living/carbon/human/user = loc.loc
		to_chat(user, SPAN_NOTICE("[src] deactivates as the battery goes out."))
		deactivate_visor(attached_helmet, user)
		return PROCESS_KILL

/obj/item/device/helmet_visor/night_vision/can_toggle(mob/living/carbon/human/user)
	. = ..()
	if(!.)
		return

	if(user.client?.view > 7)
		to_chat(user, SPAN_WARNING("You cannot use [src] while using optics."))
		return FALSE

	if(!NVG_VISOR_USAGE(FALSE))
		to_chat(user, SPAN_NOTICE("Your [src] is out of power! You'll need to recharge it."))
		return FALSE

	return TRUE

/obj/item/device/helmet_visor/night_vision/get_helmet_examine_text()
	. = ..()

	. += SPAN_NOTICE(" It is currently at [floor((power_cell.charge / power_cell.maxcharge) * 100)]% charge.")

/obj/item/device/helmet_visor/night_vision/proc/on_update_sight(mob/user)
	SIGNAL_HANDLER

	if(lighting_alpha < 255)
		user.see_in_dark = 12
	user.lighting_alpha = lighting_alpha
	user.sync_lighting_plane_alpha()

/obj/item/device/helmet_visor/night_vision/proc/change_view(mob/user, new_size)
	SIGNAL_HANDLER
	if(new_size > 7) // cannot use binos with NVO
		var/obj/item/clothing/head/helmet/marine/attached_helmet = loc
		if(!istype(attached_helmet))
			return
		deactivate_visor(attached_helmet, user)
		to_chat(user, SPAN_NOTICE("You deactivate [src] on [attached_helmet]."))
		playsound_client(user.client, toggle_off_sound, null, 75)
		attached_helmet.active_visor = null
		attached_helmet.update_icon()
		var/datum/action/item_action/cycle_helmet_huds/cycle_action = locate() in attached_helmet.actions
		if(cycle_action)
			cycle_action.set_default_overlay()

#undef NVG_VISOR_USAGE

/atom/movable/nvg_light
	light_power = 0.5
	light_range = 1
	light_color = COLOR_LIGHT_GREEN
	light_system = MOVABLE_LIGHT
	light_flags = LIGHT_ATTACHED

/obj/item/device/helmet_visor/night_vision/marine_raider
	name = "advanced night vision optic"
	desc = "An insertable visor HUD into a standard USCM helmet. This type gives a form of night vision and is standard issue in special forces units."
	hud_type = list(MOB_HUD_FACTION_MARINE, MOB_HUD_FACTION_ARMY, MOB_HUD_FACTION_NAVY, MOB_HUD_MEDICAL_ADVANCED)
	helmet_overlay = "nvg_sight_right_raider"
	power_use = 0
	visor_glows = FALSE

/obj/item/device/helmet_visor/night_vision/marine_raider/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	. = ..()

	for(var/type in hud_type)
		var/datum/mob_hud/current_mob_hud = GLOB.huds[type]
		current_mob_hud.add_hud_to(user, attached_helmet)

/obj/item/device/helmet_visor/night_vision/marine_raider/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	. = ..()

	for(var/type in hud_type)
		var/datum/mob_hud/current_mob_hud = GLOB.huds[type]
		current_mob_hud.remove_hud_from(user, attached_helmet)

/obj/item/device/helmet_visor/night_vision/marine_raider/process(delta_time)
	return PROCESS_KILL

/obj/item/device/helmet_visor/night_vision/marine_raider/twe
	desc = "A high-tech visor often seen used by the Royal Marine Commando forces of the TWE. Offers various tactical readouts as well as providing night-vision capabilities."
	hud_type = list(MOB_HUD_FACTION_TWE, MOB_HUD_FACTION_WY, MOB_HUD_MEDICAL_ADVANCED)

/////////////////////// PO VISOR ///////////////////////

/obj/item/device/helmet_visor/po_visor
	name = "MK30 flight visor, black"
	desc = "A standard issue snap-on visor used by USCM dropship pilots. Polarized to reduce glare and protect the eyes during atmospheric re-entry and orbital deployment."
	icon_state = "po_visor"
	action_icon_string = "po_visor_down"
	helmet_overlay = "po_visor_black"
	toggle_on_sound = 'sound/handling/helmet_open.ogg'
	toggle_off_sound = 'sound/handling/helmet_close.ogg'

/obj/item/device/helmet_visor/po_visor/can_attach_to(obj/item/clothing/head/helmet/target_helmet)
	if(!istype(target_helmet, /obj/item/clothing/head/helmet/upp/marinepilot))
		return FALSE
	return TRUE

/obj/item/device/helmet_visor/po_visor/activate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	..()
	attached_helmet.flags_inventory |= COVEREYES
	attached_helmet.flags_inv_hide |= HIDEEYES|HIDEFACE
	attached_helmet.eye_protection = EYE_PROTECTION_FLASH
	user.update_tint()

/obj/item/device/helmet_visor/po_visor/deactivate_visor(obj/item/clothing/head/helmet/marine/attached_helmet, mob/living/carbon/human/user)
	..()
	attached_helmet.flags_inventory &= ~(COVEREYES)
	attached_helmet.flags_inv_hide &= ~(HIDEEYES|HIDEFACE)
	attached_helmet.eye_protection = EYE_PROTECTION_NONE
	user.update_tint()

/obj/item/device/helmet_visor/po_visor/purple
	name = "MK30 flight visor, purple"
	icon_state = "po_visor_purple"
	action_icon_string = "po_visor_purple_down"
	helmet_overlay = "po_visor_purple"

/obj/item/device/helmet_visor/po_visor/lightblue
	name = "MK30 flight visor, light-blue"
	icon_state = "po_visor_lightblue"
	action_icon_string = "po_visor_lightblue_down"
	helmet_overlay = "po_visor_lightblue"

/obj/item/device/helmet_visor/po_visor/red
	name = "MK30 flight visor, red"
	icon_state = "po_visor_red"
	action_icon_string = "po_visor_red_down"
	helmet_overlay = "po_visor_red"

/obj/item/device/helmet_visor/po_visor/darkblue
	name = "MK30 flight visor, dark-blue"
	icon_state = "po_visor_darkblue"
	action_icon_string = "po_visor_darkblue_down"
	helmet_overlay = "po_visor_darkblue"

/obj/item/device/helmet_visor/po_visor/yellow
	name = "MK30 flight visor, yellow"
	icon_state = "po_visor_yellow"
	action_icon_string = "po_visor_yellow_down"
	helmet_overlay = "po_visor_yellow"

/obj/item/device/helmet_visor/po_visor/marine
	name = "MK30 flight visor, black"
	desc = "A standard issue snap-on visor used by USCM dropship pilots. Polarized to reduce glare and protect the eyes during atmospheric re-entry and orbital deployment. This one seems to be slightly modified in order to fit into most modern helmets."
	helmet_overlay = "po_visor_black_marine"
	hud_type = list()

/obj/item/device/helmet_visor/po_visor/marine/can_attach_to(obj/item/clothing/head/helmet/target_helmet)
	return TRUE

/obj/item/device/helmet_visor/po_visor/marine/yellow
	name = "MK30 flight visor, yellow"
	icon_state = "po_visor_yellow"
	action_icon_string = "po_visor_yellow_down"
	helmet_overlay = "po_visor_yellow_marine"
