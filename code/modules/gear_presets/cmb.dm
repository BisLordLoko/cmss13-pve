/datum/equipment_preset/cmb
	faction = FACTION_MARSHAL
	faction_group = list(FACTION_MARSHAL, FACTION_MARINE)
	rank = JOB_CMB
	idtype = /obj/item/card/id/deputy
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH)
	var/human_versus_human = FALSE

/datum/equipment_preset/cmb/New()
	. = ..()
	access = get_access(ACCESS_LIST_UA)

/datum/equipment_preset/cmb/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(80;MALE,20;FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
	var/static/list/colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
	var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
	var/hair_color = pick(hair_colors)
	new_human.r_hair = hair_colors[hair_color][1]
	new_human.g_hair = hair_colors[hair_color][2]
	new_human.b_hair = hair_colors[hair_color][3]
	new_human.r_facial = hair_colors[hair_color][1]
	new_human.g_facial = hair_colors[hair_color][2]
	new_human.b_facial = hair_colors[hair_color][3]
	var/eye_color = pick(colors)
	new_human.r_eyes = colors[eye_color][1]
	new_human.g_eyes = colors[eye_color][2]
	new_human.b_eyes = colors[eye_color][3]
	if(new_human.gender == MALE)
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right", "Bun")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/cmb/load_id(mob/living/carbon/human/new_human, client/mob_client)
	if(human_versus_human)
		var/obj/item/clothing/under/uniform = new_human.w_uniform
		if(istype(uniform))
			uniform.has_sensor = UNIFORM_HAS_SENSORS
			uniform.sensor_faction = FACTION_MARINE
	return ..()

//*****************************************************************************************************/
/datum/equipment_preset/cmb/deputy
	name = "CMB - US Colonial Marshals Deputy"
	paygrades = list(PAY_SHORT_CMBD = JOB_PLAYTIME_TIER_0)
	role_comm_title = "CMB Dep"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_CMB
	rank = JOB_CMB
	skills = /datum/skills/cmb

/datum/equipment_preset/cmb/deputy/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	//head
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/CMB, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full/revolver, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)

/datum/equipment_preset/cmb/deputy/spanish
	name = "CMB - LatAm Colonial Marshals Deputy"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH, LANGUAGE_ENGLISH)

/datum/equipment_preset/cmb/deputy/emergency
	name = "CMB - US Colonial Marshals Deputy (Emergency, SMG)"

/datum/equipment_preset/cmb/deputy/emergency/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	//head
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/CMB, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/lamp, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full/revolver, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	if(prob(85))
		add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	if(prob(85))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/smg/m39, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/smg/m39, WEAR_IN_R_STORE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/m41aMK1, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/m41aMK1, WEAR_IN_R_STORE)

/datum/equipment_preset/cmb/deputy/emergency/spanish
	name = "CMB - LatAm Colonial Marshals Deputy (Emergency, SMG)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH, LANGUAGE_ENGLISH)

/datum/equipment_preset/cmb/deputy/emergency/shotgunner
	name = "CMB - US Colonial Marshals Deputy (Emergency, Shotgun)"

/datum/equipment_preset/cmb/deputy/emergency/shotgunner/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	//head
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/marine/veteran/ua_riot, WEAR_HEAD)
		new_human.equip_to_slot_or_del(new /obj/item/prop/helmetgarb/riot_shield, WEAR_IN_HELMET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/CMB, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/guard, WEAR_JACKET)
	else
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/marine/lamp, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full/revolver, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	if(prob(85))
		add_combat_gloves(new_human)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)

	new_human.equip_to_slot_or_del(new /obj/item/device/motiondetector, WEAR_IN_BACK)

	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/shotgun/pump/dual_tube/cmb, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/shotgun/large, WEAR_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/handful/shotgun/buckshot, WEAR_IN_R_STORE)
	else
		new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/rifle/xm51/withstock, WEAR_J_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/magazine, WEAR_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51, WEAR_IN_R_STORE)
		new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/rifle/xm51, WEAR_IN_R_STORE)

/datum/equipment_preset/cmb/deputy/emergency/shotgunner/spanish
	name = "CMB - LatAm Colonial Marshals Deputy (Emergency, Shotgun)"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH, LANGUAGE_ENGLISH)
//*****************************************************************************************************/

/datum/equipment_preset/cmb/marshal
	name = "CMB - US Colonial Marshal"
	paygrades = list(PAY_SHORT_CMBM = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/marshal
	role_comm_title = "CMB Mar"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_CMB_TL
	rank = JOB_CMB_TL
	skills = /datum/skills/cmb/leader
	minimum_age = 30
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH, LANGUAGE_JAPANESE)

/datum/equipment_preset/cmb/marshal/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	//head
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/CMB, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	//jacket
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full/revolver, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)

/datum/equipment_preset/cmb/marshal/spanish
	name = "LatAm Colonial Marshal"
	ethnicity = LATIN_AMERICAN_ETHNICITY
	languages = list(LANGUAGE_SPANISH, LANGUAGE_ENGLISH, LANGUAGE_JAPANESE)

//*****************************************************************************************************/
/datum/equipment_preset/cmb/synth
	name = "CMB - Support Synthetic"
	paygrades = list(PAY_SHORT_CMBS = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/deputy
	role_comm_title = "CMB Synth"
	flags = EQUIPMENT_PRESET_EXTRA
	assignment = JOB_CMB_SYN
	rank = JOB_CMB_SYN
	languages = ALL_SYNTH_LANGUAGES

/datum/equipment_preset/cmb/synth/load_skills(mob/living/carbon/human/new_human)
		new_human.set_skills(/datum/skills/synthetic/cmb)
		new_human.allow_gun_usage = FALSE

/datum/equipment_preset/cmb/synth/load_name(mob/living/carbon/human/new_human, randomise)
	new_human.gender = pick(50;MALE,50;FEMALE)
	var/datum/preferences/A = new
	A.randomize_appearance(new_human)
	var/random_name = capitalize(pick(new_human.gender == MALE ? GLOB.first_names_male : GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
	var/static/list/colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "BROWN" = list(48, 38, 18),"BLUE" = list(29, 51, 65), "GREEN" = list(40, 61, 39), "STEEL" = list(46, 59, 54))
	var/static/list/hair_colors = list("BLACK" = list(15, 15, 10), "BROWN" = list(48, 38, 18), "AUBURN" = list(77, 48, 36), "BLONDE" = list(95, 76, 44))
	var/hair_color = pick(hair_colors)
	new_human.r_hair = hair_colors[hair_color][1]
	new_human.g_hair = hair_colors[hair_color][2]
	new_human.b_hair = hair_colors[hair_color][3]
	new_human.r_facial = hair_colors[hair_color][1]
	new_human.g_facial = hair_colors[hair_color][2]
	new_human.b_facial = hair_colors[hair_color][3]
	var/eye_color = pick(colors)
	new_human.r_eyes = colors[eye_color][1]
	new_human.g_eyes = colors[eye_color][2]
	new_human.b_eyes = colors[eye_color][3]
	if(new_human.gender == MALE)
		new_human.h_style = pick("Undercut", "Partly Shaved", "Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "Medium Fade", "High Fade", "Coffee House Cut")
		new_human.f_style = pick("Shaved", "Shaved", "Shaved", "3 O'clock Shadow", "3 O'clock Moustache", "5 O'clock Shadow", "5 O'clock Moustache", "7 O'clock Shadow", "7 O'clock Moustache",)
	else
		new_human.h_style = pick("Side Undercut", "Side Hang Undercut (Reverse)", "Undercut, Top", "CIA", "Mulder", "Pvt. Redding", "Pixie Cut Left", "Pixie Cut Right", "Bun")
	new_human.change_real_name(new_human, random_name)
	new_human.age = rand(20,35)

/datum/equipment_preset/cmb/synth/load_race(mob/living/carbon/human/new_human)
	new_human.set_species(SYNTH_COLONY)

/datum/equipment_preset/cmb/synth/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	//head
	if(prob(65))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/CMB, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb, WEAR_BODY)
	//jacket
	if(prob(75))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/CMB, WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/civilian, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/cmb/liaison
	name = "CMB - Interstellar Commerce Commission Liaison"
	paygrades = list(PAY_SHORT_ICCL = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/silver/cl
	role_comm_title = "ICC Rep"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_CMB_ICC
	rank = JOB_CMB_ICC
	skills = /datum/skills/civilian
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH, LANGUAGE_JAPANESE)

/datum/equipment_preset/cmb/liaison/load_gear(mob/living/carbon/human/new_human)

	//clothes
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/ICC, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/windbreaker/windbreaker_blue, WEAR_JACKET)
	//holding
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pouches
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/notepad/blue, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/folder/white, WEAR_IN_R_STORE)
//backpack and stuff in it
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)

//*****************************************************************************************************/

/datum/equipment_preset/cmb/observer
	name = "CMB - Interstellar Human Rights Observer"
	paygrades = list(PAY_SHORT_IHRO = JOB_PLAYTIME_TIER_0)
	idtype = /obj/item/card/id/lanyard
	role_comm_title = "Observer"
	flags = EQUIPMENT_PRESET_EXTRA

	assignment = JOB_CMB_OBS
	rank = JOB_CMB_OBS
	skills = /datum/skills/civilian
	languages = list(LANGUAGE_ENGLISH, LANGUAGE_SPANISH, LANGUAGE_RUSSIAN)

/datum/equipment_preset/cmb/observer/load_gear(mob/living/carbon/human/new_human)
	//clothes
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/ICC, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/liaison_suit/black, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/blue, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/windbreaker/windbreaker_yellow, WEAR_JACKET)
	//holding
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pouches
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full/alternate, WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/notepad/blue, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/folder/white, WEAR_IN_R_STORE)

//*****************************************************************************************************/

/datum/equipment_preset/cmb/fbi

	name = "FBI - Special Agent"
	paygrades = list(PAY_SHORT_FBI = JOB_PLAYTIME_TIER_0)
	faction = FACTION_MARSHAL
	faction_group = list(FACTION_MARSHAL, FACTION_MARINE)
	assignment = "FBI Special Agent"
	role_comm_title = "FBI Agent"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/cmb
	idtype = /obj/item/card/id/lanyard

/datum/equipment_preset/cmb/fbi/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/clue_scanner, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/evidence, WEAR_IN_BACK)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_BODY)
	var/random_outfit = pick(
		/obj/item/clothing/under/liaison_suit/black,
		/obj/item/clothing/under/liaison_suit/brown,
		/obj/item/clothing/under/liaison_suit/ivy,
		/obj/item/clothing/under/liaison_suit/field,
	)

	new_human.equip_to_slot_or_del(new random_outfit(new_human), WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/revolver/spearhead, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/red, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/corporate/black, WEAR_JACKET)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses, WEAR_EYES)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/laceup, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)

//*****************************************************************************************************/
//Coast Guard Presets - they're bunched with CMBs since they're both law enforcement and probably cooperate a lot

/datum/equipment_preset/cmb/usccg/crew

	name = "US Coast Guard Crewman"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_NE2 = JOB_PLAYTIME_TIER_0)
	faction = FACTION_MARSHAL
	faction_group = list(FACTION_MARSHAL, FACTION_MARINE)
	assignment = "US Colonial Coast Guard Crewman"
	role_comm_title = "USCCG-CR"
	skills = /datum/skills/ship_crew
	idtype = /obj/item/card/id/

/datum/equipment_preset/cmb/usccg/crew/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB, WEAR_L_EAR)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/navy/e2, WEAR_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/marine/brown/fingerless, WEAR_HANDS)

/datum/equipment_preset/cmb/usccg/investigator

	name = "US Coast Guard Investigator"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_NO2 = JOB_PLAYTIME_TIER_0)
	faction = FACTION_MARSHAL
	faction_group = list(FACTION_MARSHAL, FACTION_MARINE)
	assignment = "US Colonial Coast Guard Law Enforcement Specialist"
	role_comm_title = "USCCG-IV"
	skills = /datum/skills/cmb
	idtype = /obj/item/card/id/

/datum/equipment_preset/cmb/usccg/investigator/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel/black, WEAR_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/tnr, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/tool/crowbar/tactical, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/flare, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/reagent_container/food/drinks/flask/detflask, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/device/clue_scanner, WEAR_IN_BACK)
	new_human.equip_to_slot_or_del(new /obj/item/storage/box/evidence, WEAR_IN_BACK)
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB/limited, WEAR_L_EAR)
	var/random_invesigator_glasses = rand(1,4)
	switch(random_invesigator_glasses)
		if(1 to 2)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses, WEAR_EYES)
		if(3)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/aviator, WEAR_EYES)
		if(4)
			new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/sunglasses/big/classic, WEAR_EYES)
	//head
	if(prob(70))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/head/cmcap/corrections, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb/usccg, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/navy/o2, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/forensics/blue, WEAR_JACKET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/storage/holster/waist, WEAR_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/weapon/gun/pistol/vp70/flashlight, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70/extended, WEAR_IN_ACCESSORY)
	new_human.equip_to_slot_or_del(new /obj/item/ammo_magazine/pistol/vp70/extended, WEAR_IN_ACCESSORY)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/security/MP/CMB/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/taperecorder, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tool/pen/clicky, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/firstaid/full(new_human), WEAR_L_STORE)

/datum/equipment_preset/cmb/usccg/investigator/nco
	name = parent_type::name + " (Lesser Rank)"
	paygrades = list(PAY_SHORT_NE7 = JOB_PLAYTIME_TIER_0)

/datum/equipment_preset/cmb/usccg/CO
	name = "US Coast Guard Commanding Officer"
	assignment = "US Colonial Coast Guard Commanding Officer"
	rank = JOB_CMB_TL
	paygrades = list(PAY_SHORT_NO5)
	role_comm_title = "USCCG-CO"
	flags = EQUIPMENT_PRESET_EXTRA
	skills = /datum/skills/navycommander
	idtype = /obj/item/card/id/gold

/datum/equipment_preset/cmb/usccg/CO/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB, WEAR_L_EAR)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/marine/peaked/captain/white, WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/cmb/usccg, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/navy/o5, WEAR_ACCESSORY)
	if(prob(50))
		new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/storage/jacket/marine/dress/officer/bomber(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/gun/m4a3/m1911(new_human), WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife, WEAR_FEET)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/device/binoculars/range/designator(new_human), WEAR_L_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/medium(new_human), WEAR_R_STORE)

/datum/equipment_preset/cmb/usccg/eva

	name = "US Coast Guard EVA Technician"
	flags = EQUIPMENT_PRESET_EXTRA
	paygrades = list(PAY_SHORT_NE4 = JOB_PLAYTIME_TIER_0)
	faction = FACTION_MARSHAL
	faction_group = list(FACTION_MARSHAL, FACTION_MARINE)
	assignment = "US Colonial Coast Guard EVA Technician"
	role_comm_title = "USCCG-EVA"
	skills = /datum/skills/eng_tech
	idtype = /obj/item/card/id/

/datum/equipment_preset/cmb/usccg/eva/load_gear(mob/living/carbon/human/new_human)
	new_human.undershirt = "undershirt"
	//back
	new_human.equip_to_slot_or_del(new /obj/item/tank/oxygen/red, WEAR_BACK) //replace with a Jetpack once the PRs are properly merged
	//face
	new_human.equip_to_slot_or_del(new /obj/item/device/radio/headset/distress/CMB, WEAR_L_EAR)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/glasses/meson, WEAR_EYES)
	//head
	new_human.equip_to_slot_or_del(new /obj/item/clothing/head/helmet/space/pressure/red(new_human), WEAR_HEAD)
	//uniform
	new_human.equip_to_slot_or_del(new /obj/item/clothing/under/marine/officer/engi, WEAR_BODY)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/accessory/ranks/navy/e4, WEAR_ACCESSORY)
	//jacket
	new_human.equip_to_slot_or_del(new /obj/item/clothing/suit/space/pressure/red(new_human), WEAR_JACKET)
	//waist
	new_human.equip_to_slot_or_del(new /obj/item/storage/belt/utility/full, WEAR_WAIST)
	//limbs
	new_human.equip_to_slot_or_del(new /obj/item/clothing/shoes/marine/army/knife, WEAR_FEET)
	new_human.equip_to_slot_or_del(new /obj/item/clothing/gloves/yellow, WEAR_HANDS)
	//pockets
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/general/large, WEAR_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/tank/emergency_oxygen/double, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/analyzer, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/device/flashlight/combat, WEAR_IN_R_STORE)
	new_human.equip_to_slot_or_del(new /obj/item/storage/pouch/flare/full, WEAR_L_STORE)
