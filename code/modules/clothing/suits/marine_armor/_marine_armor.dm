#define DEBUG_ARMOR_PROTECTION 0

#if DEBUG_ARMOR_PROTECTION
/mob/living/carbon/human/verb/check_overall_protection()
	set name = "Get Armor Value"
	set category = "Debug"
	set desc = "Shows the armor value of the bullet category."

	var/armor = 0
	var/counter = 0
	for(var/X in H.limbs)
		var/obj/limb/E = X
		armor = getarmor_organ(E, ARMOR_BULLET)
		to_chat(src, SPAN_DEBUG("<b>[E.name]</b> is protected with <b>[armor]</b> armor against bullets."))
		counter += armor
	to_chat(src, SPAN_DEBUG("The overall armor score is: <b>[counter]</b>."))
#endif

//=======================================================================\\
//=======================================================================\\

#define ALPHA 1
#define BRAVO 2
#define CHARLIE 3
#define DELTA 4
#define ECHO 5
#define CRYO 6
#define SOF 7
#define NOSQUAD 8

// MARINE STORAGE ARMOR

/obj/item/clothing/suit/storage/marine
	name = "\improper M3 pattern marine armor"
	desc = "Standard USCMC issue M3 Pattern Personal Armor. Composite ballistic armor, integral biomonitoring system, and brackets for the IMP system as well as the TNR Shoulder Lamp. \nHas some extra pouches on the sides for storage."
	icon = 'icons/obj/items/clothing/cm_suits.dmi'
	icon_state = "1"
	item_state = "marine_armor" //Make unique states for Officer & Intel armors.
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/suit_1.dmi'
	)
	flags_atom = FPRINT|CONDUCT
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	min_cold_protection_temperature = HELMET_MIN_COLD_PROT
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	blood_overlay_type = "armor"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	movement_compensation = SLOWDOWN_ARMOR_LIGHT
	storage_slots = 3
	siemens_coefficient = 0.7
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/prop/prop_gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/type47,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/flaregun,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
		/obj/item/storage/belt/gun/m39,
		/obj/item/storage/belt/gun/xm51,
	)
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_PONCHO)

	light_power = 3
	light_range = 4
	light_color = LIGHT_COLOR_TUNGSTEN
	light_system = MOVABLE_LIGHT

	var/flashlight_cooldown = 0 //Cooldown for toggling the light
	var/locate_cooldown = 0 //Cooldown for SL locator
	var/armor_overlays[]
	actions_types = list(/datum/action/item_action/toggle)
	var/flags_marine_armor = ARMOR_SQUAD_OVERLAY|ARMOR_LAMP_OVERLAY
	var/specialty = "M3 pattern marine" //Same thing here. Give them a specialty so that they show up correctly in vendors. speciality does NOTHING if you have NO_NAME_OVERRIDE
	w_class = SIZE_HUGE
	uniform_restricted = null
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/suit_monkey_1.dmi')
	time_to_unequip = 20
	time_to_equip = 20
	pickup_sound = "armorequip"
	drop_sound = "armorequip"
	equip_sounds = list('sound/handling/putting_on_armor1.ogg')
	has_light = TRUE
	var/armor_variation = 0
	/// The dmi where the grayscale squad overlays are contained
	var/squad_overlay_icon = 'icons/mob/humans/onmob/suit_1.dmi'

	var/atom/movable/marine_light/light_holder

/obj/item/clothing/suit/storage/marine/Initialize(mapload)
	. = ..()
	if(!(flags_atom & NO_NAME_OVERRIDE))
		name = "[specialty] armor"

	if(!(flags_atom & NO_SNOW_TYPE))
		select_gamemode_skin(type)
	armor_overlays = list("lamp") //Just one for now, can add more later.
	if(armor_variation && mapload)
		set_armor_style("Random")
	update_icon()
	pockets.max_w_class = SIZE_SMALL //Can contain small items AND rifle magazines.
	pockets.bypass_w_limit = list(
		/obj/item/ammo_magazine/rifle,
		/obj/item/ammo_magazine/smg,
		/obj/item/ammo_magazine/sniper,
	)
	pockets.max_storage_space = 8

	light_holder = new(src)

/obj/item/clothing/suit/storage/marine/Destroy()
	QDEL_NULL(light_holder)
	return ..()

/obj/item/clothing/suit/storage/marine/update_icon(mob/user)
	var/image/I
	armor_overlays["lamp"] = null
	if(flags_marine_armor & ARMOR_LAMP_OVERLAY)
		if(flags_marine_armor & ARMOR_LAMP_ON)
			I = image('icons/obj/items/clothing/cm_suits.dmi', src, "lamp-on")
		else
			I = image('icons/obj/items/clothing/cm_suits.dmi', src, "lamp-off")
		armor_overlays["lamp"] = I
		overlays += I
	else armor_overlays["lamp"] = null
	if(user) user.update_inv_wear_suit()


/obj/item/clothing/suit/storage/marine/post_vendor_spawn_hook(mob/living/carbon/human/user) //used for randomizing/selecting a variant for armors.
	if(!armor_variation)
		return

	if(user?.client?.prefs)
		// Set the armor style to the user's preference.
		set_armor_style(user.client.prefs.preferred_armor)
	else
		// Or if that isn't possible, just pick a random one.
		set_armor_style("Random")
	update_icon(user)

/obj/item/clothing/suit/storage/marine/attack_self(mob/user)
	..()

	if(!isturf(user.loc))
		to_chat(user, SPAN_WARNING("You cannot turn the light [light_on ? "off" : "on"] while in [user.loc].")) //To prevent some lighting anomalies.
		return

	if(flashlight_cooldown > world.time)
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src)
		return

	turn_light(user, !light_on)

/obj/item/clothing/suit/storage/marine/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != WEAR_JACKET)
		return FALSE
	return TRUE //only give action button when armor is worn.

/obj/item/clothing/suit/storage/marine/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_range(initial(light_range))
	set_light_power(floor(initial(light_power) * 0.5))
	set_light_on(toggle_on)
	flags_marine_armor ^= ARMOR_LAMP_ON

	light_holder.set_light_flags(LIGHT_ATTACHED)
	light_holder.set_light_range(initial(light_range))
	light_holder.set_light_power(initial(light_power))
	light_holder.set_light_on(toggle_on)

	if(!toggle_on)
		playsound(src, 'sound/handling/click_2.ogg', 50, 1)

	playsound(src, 'sound/handling/suitlight_on.ogg', 50, 1)
	update_icon(user)

	for(var/X in actions)
		var/datum/action/A = X
		A.update_button_icon()

/obj/item/clothing/suit/storage/marine/mob_can_equip(mob/living/carbon/human/M, slot, disable_warning = 0)
	. = ..()
	if (.)
		if(issynth(M) && M.allow_gun_usage == FALSE && !(flags_marine_armor & SYNTH_ALLOWED))
			M.visible_message(SPAN_DANGER("Your programming prevents you from wearing this!"))
			return 0

/**
 * Updates the armor's `icon_state` to the style represented by `new_style`.
 *
 * Arguments:
 * * new_style - The new armor style. May only be one of `GLOB.armor_style_list`'s keys, or `"Random"`.
 */
/obj/item/clothing/suit/storage/marine/proc/set_armor_style(new_style)
	// Regex to match one or more digits.
	var/static/regex/digits = new("\\d+")
	// Integer for the new armor style's `icon_state`.
	var/new_look

	if(new_style == "Random")
		// The style icon states are all numbers between 1 and `armor_variation`, so this picks a random one.
		new_look = rand(1, armor_variation)
	else
		new_look = GLOB.armor_style_list[new_style]

	// Replace the digits in the current icon state with `new_look`. (E.g. "L6" -> "L2")
	icon_state = digits.Replace(icon_state, new_look)

/obj/item/clothing/suit/storage/marine/medium/rto
	icon_state = "io"
	armor_variation = 0
	name = "\improper M4 pattern marine armor"
	desc = "A well tinkered and crafted hybrid of Smart-Gunner mesh and M3 pattern plates. Robust, yet nimble, with room for all your pouches."
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	storage_slots = 4
	light_range = 5 //slightly higher
	specialty = "M4 pattern marine"

/obj/item/clothing/suit/storage/marine/MP
	name = "\improper M2 pattern MP armor"
	desc = "A standard Colonial Marines M2 Pattern Chestplate. Protects the chest from ballistic rounds, bladed objects and accidents. It has a small leather pouch strapped to it for limited storage."
	icon_state = "mp_armor"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_LOW
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMLOW
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_LIGHT
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/ammo_magazine/,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/weapon/baton,
		/obj/item/restraint/handcuffs,
		/obj/item/explosive/grenade,
		/obj/item/device/binoculars,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/device/hailer,
		/obj/item/storage/belt/gun,
		/obj/item/weapon/sword/ceremonial,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
	)
	specialty = "M2 pattern MP"
	item_state_slots = list(WEAR_JACKET = "mp_armor")
	black_market_value = 20

/obj/item/clothing/suit/storage/marine/MP/warden
	name = "\improper M3 pattern warden MP armor"
	desc = "A well-crafted suit of M3 Pattern Armor typically distributed to Wardens. Useful for letting your men know who is in charge."
	icon_state = "warden"
	specialty = "M3 pattern warden MP"
	item_state_slots = list(WEAR_JACKET = "warden")

/obj/item/clothing/suit/storage/marine/MP/WO
	name = "\improper M3 pattern chief MP armor"
	desc = "A well-crafted suit of M3 Pattern Armor typically distributed to Chief MPs. Useful for letting your men know who is in charge."
	icon_state = "warrant_officer"
	specialty = "M3 pattern chief MP"
	item_state_slots = list(WEAR_JACKET = "warrant_officer")
	black_market_value = 30

/obj/item/clothing/suit/storage/marine/MP/general
	name = "\improper M3 pattern general officer armor"
	desc = "A well-crafted suit of M3 Pattern Armor with a gold shine. It looks very expensive, but shockingly fairly easy to carry and wear."
	icon_state = "general"
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUM
	specialty = "M3 pattern general"
	item_state_slots = list(WEAR_JACKET = "general")
	w_class = SIZE_MEDIUM

/obj/item/clothing/suit/storage/marine/MP/SO
	name = "\improper M3 pattern officer armor"
	desc = "A well-crafted suit of M3 Pattern Armor typically found in the hands of higher-ranking officers. Useful for letting your men know who is in charge when taking to the field."
	icon_state = "officer"
	storage_slots = 3
	flags_atom = null
	specialty = "M3 pattern officer"
	item_state_slots = list(WEAR_JACKET = "officer")

//Making a new object because we might want to edit armor values and such.
//Or give it its own sprite. It's more for the future.
/obj/item/clothing/suit/storage/marine/MP/CO
	name = "\improper M3 pattern commanding officer armor"
	desc = "A robust, well-polished suit of armor for the Commanding Officer. Custom-made to fit its owner with special straps to operate a smartgun. Show those Marines who's really in charge."
	icon_state = "co_officer"
	item_state = "co_officer"
	armor_bullet = CLOTHING_ARMOR_HIGH
	storage_slots = 3
	flags_atom = NO_SNOW_TYPE
	flags_inventory = BLOCKSHARPOBJ|SMARTGUN_HARNESS
	specialty = "M3 pattern captain"
	item_state_slots = list(WEAR_JACKET = "co_officer")
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_RANK, ACCESSORY_SLOT_DECOR, ACCESSORY_SLOT_PONCHO)
	black_market_value = 35


/obj/item/clothing/suit/storage/marine/MP/CO/jacket
	name = "\improper M3 pattern commanding officer armored coat"
	desc = "A robust, well-polished suit of armor for the Commanding Officer. Custom-made to fit its owner with special straps to operate a smartgun. Show those Marines who's really in charge. This one has a coat over it for added warmth."
	icon_state = "bridge_coat_armored"
	item_state = "bridge_coat_armored"
	item_state_slots = list(WEAR_JACKET = "bridge_coat_armored")
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_RANK)

/obj/item/clothing/suit/storage/marine/medium/leader
	name = "\improper B12 pattern marine armor"
	desc = "Semi-experimental body armor system similar to M3, incorporating primarily carbon fiber instead of boron carbide. \nDesigned in a lovely olive green, slightly improved protection against blunt impact and biological hazards."
	icon_state = "7"
	armor_variation = 0
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	specialty = "B12 pattern marine"
	light_range = 5

/obj/item/clothing/suit/storage/marine/tanker
	name = "\improper M3 pattern tanker armor"
	desc = "Armored vest sometimes worn by USCMC armor crews. More bulky than a flak vest or service jacket, but substantially improved protection should the wearer need to dismount."
	icon_state = "tanker"
	specialty = "M3 pattern tanker"
	storage_slots = 2

//===========================//PFC ARMOR CLASSES\\================================\\
//=================================================================================\\

// M3 pattern marine armor
/obj/item/clothing/suit/storage/marine/medium
	armor_variation = 6
	light_power = 4

/obj/item/clothing/suit/storage/marine/medium/padless_lines
	name = "M3 pattern ridged marine armor"
	icon_state = "2"
	armor_variation = 0
	specialty = "M3 pattern ridged marine"

/obj/item/clothing/suit/storage/marine/medium/smooth
	name = "M3 pattern smooth marine armor"
	icon_state = "3"
	armor_variation = 0
	specialty = "M3 pattern smooth marine"

// M3-L pattern light armor
/obj/item/clothing/suit/storage/marine/light
	name = "\improper M3-L pattern light armor"
	desc = "A lighter, cut down version of the standard M3 pattern armor. It sacrifices durability for more speed."
	specialty = "\improper M3-L pattern light"
	icon_state = "L1"
	armor_variation = 6
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW
	storage_slots = 2

/obj/item/clothing/suit/storage/marine/light/padless_lines
	icon_state = "L2"
	armor_variation = 0

/obj/item/clothing/suit/storage/marine/light/smooth
	icon_state = "L3"
	armor_variation = 0

/obj/item/clothing/suit/storage/marine/light/standard
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/light/vest
	name = "\improper M3-VL pattern ballistics vest"
	desc = "Up until 2182 USCM non-combat personnel were issued non-standardized ballistics vests, though the lack of IMP compatibility and suit lamps proved time and time again inefficient. This modified M3-L shell is the result of a 6-year R&D program; It provides utility, protection, AND comfort to all USCM non-combat personnel."
	icon_state = "VL"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE
	flags_marine_armor = ARMOR_LAMP_OVERLAY //No squad colors when wearing this since it'd look funny.
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_energy = CLOTHING_ARMOR_LOW
	armor_bomb = CLOTHING_ARMOR_LOW
	armor_bio = CLOTHING_ARMOR_VERYLOW
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	storage_slots = 1
	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS
	siemens_coefficient = 0.7

/obj/item/clothing/suit/storage/marine/light/vest/dcc
	name = "\improper M3-VL pattern flak vest"
	desc = "Effectively a combination of the M3-VL ballistics vest and M70 flak jacket, this armor is used by primarily by flight personnel because of its combined flak and ballistic defense and high mobility. It is also typically worn by military police officers as a result of the blunt force protection offered by the aforementioned armor layering."
	icon_state = "VL_FLAK"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	storage_slots = 2

/obj/item/clothing/suit/storage/marine/light/synvest
	name = "\improper M3A1 Synthetic Utility Vest"
	desc = "This variant of the ubiquitous M3 pattern vest has been extensively modified, providing no protection in exchange for maximum mobility and added storage. Synthetic programming compliant."
	icon_state = "VL_syn_camo"
	flags_atom = NO_NAME_OVERRIDE
	flags_marine_armor = ARMOR_LAMP_OVERLAY|SYNTH_ALLOWED //No squad colors + can be worn by synths.
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	storage_slots = 3
	slowdown = SLOWDOWN_ARMOR_SUPER_LIGHT
	time_to_unequip = 0.5 SECONDS
	time_to_equip = 1 SECONDS

/obj/item/clothing/suit/storage/marine/light/synvest/grey
	icon_state = "VL_syn"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/light/synvest/jungle
	icon_state = "VL_syn_camo"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/light/synvest/snow
	icon_state = "s_VL_syn_camo"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/light/synvest/desert
	icon_state = "d_VL_syn_camo"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/light/synvest/dgrey
	icon_state = "c_VL_syn_camo"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/light/recon
	name = "M3-R pattern light armor"
	desc = "Special issue light armor for forward reconnaissance Marines. Offers similar protection as M3 armor but none of the slowdown."
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	movement_compensation = SLOWDOWN_ARMOR_LIGHT

// M3-EOD pattern heavy armor
/obj/item/clothing/suit/storage/marine/heavy
	name = "\improper M3-H pattern heavy armor"
	desc = "M3 armor vest with a rheological liner behind the chestplate, additional armor over the limbs to improve protection ballistic and blast protections. \nMarginal improvement in other areas, and the mass of the extra plates degrades agility, especially in null-gee."
	desc_lore = "This configuration of the iconic armor was developed during the Canton War in 2160 between the UPP and USCM - Designed in response to a need for higher protection for ComTechs assigned as EODs during the conflict, this is the pinnacle of protection for your average marine. The shoulders and kneepads have both been expanded upon heavily, covering up the arteries on each limb. A special spall liner was developed for this suit, with the same technology being used in the M70 Flak Jacket being developed at the same time."
	specialty = "\improper M3-H pattern"
	icon_state = "H1"
	armor_variation = 6
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_energy = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	storage_slots = 2
	slowdown = SLOWDOWN_ARMOR_LOWHEAVY
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM
	light_power = 4
	light_range = 5

/obj/item/clothing/suit/storage/marine/heavy/padless_lines
	icon_state = "H2"
	armor_variation = 0

/obj/item/clothing/suit/storage/marine/heavy/smooth
	icon_state = "H3"
	armor_variation = 0

//===========================//SPECIALIST\\================================\\
//=======================================================================\\

/obj/item/clothing/suit/storage/marine/specialist
	name = "\improper B18 defensive armor"
	desc = "A heavy, rugged set of armor plates for when you really, really need to not die horribly. Slows you down though.\nComes with two tricord injectors in each arm guard."
	icon_state = "xarmor"
	armor_melee = CLOTHING_ARMOR_HIGH
	armor_bullet = CLOTHING_ARMOR_HIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	armor_energy = CLOTHING_ARMOR_MEDIUM
	storage_slots = 2
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	slowdown = SLOWDOWN_ARMOR_HEAVY
	specialty = "B18 defensive"
	unacidable = TRUE
	var/injections = 4

/obj/item/clothing/suit/storage/marine/specialist/verb/inject()
	set name = "Create Injector"
	set category = "Object"
	set src in usr

	if(usr.is_mob_incapacitated())
		return 0

	if(!injections)
		to_chat(usr, "Your armor is all out of injectors.")
		return 0

	if(usr.get_active_hand())
		to_chat(usr, "Your active hand must be empty.")
		return 0

	to_chat(usr, "You feel a faint hiss and an injector drops into your hand.")
	var/obj/item/reagent_container/hypospray/autoinjector/skillless/O = new(usr)
	usr.put_in_active_hand(O)
	injections--
	playsound(src,'sound/machines/click.ogg', 15, 1)
	return

/obj/item/clothing/suit/storage/marine/M3G
	name = "\improper M3-G4 grenadier armor"
	desc = "A custom set of M3 armor packed to the brim with padding, plating, and every form of ballistic protection under the sun. Used exclusively by USCM Grenadiers."
	icon_state = "grenadier"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_VERYHIGH
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	flags_inventory = BLOCKSHARPOBJ|BLOCK_KNOCKDOWN
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS|BODY_FLAG_FEET
	slowdown = SLOWDOWN_ARMOR_HEAVY
	specialty = "M3-G4 grenadier"
	unacidable = TRUE
	light_range = 5

/obj/item/clothing/suit/storage/marine/M3T
	name = "\improper M3-T light armor"
	desc = "A custom set of M3 armor designed for users of long-ranged explosive weaponry."
	icon_state = "demolitionist"
	armor_bomb = CLOTHING_ARMOR_HIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
	specialty = "M3-T light"
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE
	unacidable = TRUE

/obj/item/clothing/suit/storage/marine/M3S
	name = "\improper M3-S light armor"
	desc = "A custom set of M3 armor designed for USCM Scouts."
	icon_state = "scout_armor"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LIGHT
	specialty = "M3-S light"
	flags_item = MOB_LOCK_ON_EQUIP|NO_CRYO_STORE
	unacidable = TRUE

//==================Combat Correspondent==================\\

/obj/item/clothing/suit/storage/marine/light/reporter
	name = "press body armor"
	desc = "Body armor used by war correspondents in battles and wars across the universe."
	icon_state = "cc_armor"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

//==================USASF & ARMY==================\\

/obj/item/clothing/suit/storage/marine/medium/rto/navy
	name = "\improper M4 pattern naval-deployment armor"
	desc = "A set of USASF acquired M4 armor, modified to fit the needs of the members that see deployment on the surface of worlds. Robust, yet very nimble, with room for all your pouches."
	movement_compensation = SLOWDOWN_ARMOR_LIGHT	//carbon fibre and shit in the plates rather than heavy stuff, so the swabbies stay nimble
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/storage/marine/medium/rto/army
	name = "\improper M4 pattern trooper armor"
	desc = "Whilst it saw limited field-testing amongst the USCMC, the US Army adopted the M4 series pattern armor across the board. Surprisingly uncomfortable, even compared to the old M3 series armor."
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

//===========================//CUSTOM ARMOR\\================================\\
//=======================================================================\\
//base armor, copies everything from the storage armor for the same traits
/obj/item/clothing/suit/marine
	name = "\improper M3 pattern marine armor"
	desc = "Standard USCMC issue M3 Pattern Personal Armor. Composite ballistic armor, integral biomonitoring system, and brackets for the IMP system as well as the TNR Shoulder Lamp."
	icon = 'icons/obj/items/clothing/cm_suits.dmi'
	icon_state = "1"
	item_state = "marine_armor" //Make unique states for Officer & Intel armors.
	item_icons = list(
		WEAR_JACKET = 'icons/mob/humans/onmob/suit_1.dmi'
	)
	flags_atom = FPRINT|CONDUCT
	flags_inventory = BLOCKSHARPOBJ
	flags_armor_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_cold_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_heat_protection = BODY_FLAG_CHEST|BODY_FLAG_GROIN|BODY_FLAG_ARMS|BODY_FLAG_LEGS
	flags_bodypart_hidden = BODY_FLAG_CHEST
	min_cold_protection_temperature = HELMET_MIN_COLD_PROT
	max_heat_protection_temperature = HELMET_MAX_HEAT_PROT
	blood_overlay_type = "armor"
	armor_melee = CLOTHING_ARMOR_MEDIUM
	armor_bullet = CLOTHING_ARMOR_MEDIUM
	armor_laser = CLOTHING_ARMOR_MEDIUMLOW
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_MEDIUMLOW
	armor_bio = CLOTHING_ARMOR_MEDIUM
	armor_rad = CLOTHING_ARMOR_MEDIUMLOW
	armor_internaldamage = CLOTHING_ARMOR_MEDIUM
	movement_compensation = SLOWDOWN_ARMOR_LIGHT
	siemens_coefficient = 0.7
	slowdown = SLOWDOWN_ARMOR_MEDIUM
	allowed = list(
		/obj/item/weapon/gun,
		/obj/item/prop/prop_gun,
		/obj/item/tank/emergency_oxygen,
		/obj/item/device/flashlight,
		/obj/item/storage/fancy/cigarettes,
		/obj/item/tool/lighter,
		/obj/item/storage/bible,
		/obj/item/attachable/bayonet,
		/obj/item/storage/backpack/general_belt,
		/obj/item/storage/large_holster/machete,
		/obj/item/storage/belt/gun/type47,
		/obj/item/storage/belt/gun/m4a3,
		/obj/item/storage/belt/gun/m44,
		/obj/item/storage/belt/gun/smartpistol,
		/obj/item/storage/belt/gun/flaregun,
		/obj/item/device/motiondetector,
		/obj/item/device/walkman,
		/obj/item/storage/belt/gun/m39,
	)
	valid_accessory_slots = list(
		ACCESSORY_SLOT_MEDAL,
		ACCESSORY_SLOT_PAINT,
		ACCESSORY_SLOT_M3UTILITY,
		ACCESSORY_SLOT_PONCHO,
		ACCESSORY_SLOT_DECORNECK,
		ACCESSORY_SLOT_DECORARMOR,
		ACCESSORY_SLOT_DECORBRACER,
		ACCESSORY_SLOT_DECORGROIN,
		ACCESSORY_SLOT_DECORKNEE,
		ACCESSORY_SLOT_DECORSHIN,
	)
	restricted_accessory_slots = list(
		ACCESSORY_SLOT_M3UTILITY,
		ACCESSORY_SLOT_PAINT,
		ACCESSORY_SLOT_DECORNECK,
		ACCESSORY_SLOT_DECORARMOR,
		ACCESSORY_SLOT_DECORBRACER,
		ACCESSORY_SLOT_DECORGROIN,
		ACCESSORY_SLOT_DECORKNEE,
		ACCESSORY_SLOT_DECORSHIN,
	)

	light_power = 3
	light_range = 4
	light_system = MOVABLE_LIGHT

	var/flashlight_cooldown = 0 //Cooldown for toggling the light
	var/locate_cooldown = 0 //Cooldown for SL locator
	var/armor_overlays[]
	actions_types = list(/datum/action/item_action/toggle)
	var/flags_marine_armor = ARMOR_SQUAD_OVERLAY|ARMOR_LAMP_OVERLAY
	var/specialty = "M3 pattern marine" //Same thing here. Give them a specialty so that they show up correctly in vendors. speciality does NOTHING if you have NO_NAME_OVERRIDE
	w_class = SIZE_HUGE
	uniform_restricted = null
	sprite_sheets = list(SPECIES_MONKEY = 'icons/mob/humans/species/monkeys/onmob/suit_monkey_1.dmi')
	time_to_unequip = 20
	time_to_equip = 20
	drag_unequip = TRUE
	pickup_sound = "armorequip"
	drop_sound = "armorequip"
	equip_sounds = list('sound/handling/putting_on_armor1.ogg')
	has_light = TRUE
	var/armor_variation = 0
	/// The dmi where the grayscale squad overlays are contained
	var/squad_overlay_icon = 'icons/mob/humans/onmob/suit_1.dmi'

	var/atom/movable/marine_light/light_holder

/obj/item/clothing/suit/marine/Initialize(mapload)
	. = ..()
	if(!(flags_atom & NO_NAME_OVERRIDE))
		name = "[specialty] armor"

	if(!(flags_atom & NO_SNOW_TYPE))
		select_gamemode_skin(type)
	armor_overlays = list("lamp") //Just one for now, can add more later.
	if(armor_variation && mapload)
		post_vendor_spawn_hook()
	update_icon()

	light_holder = new(src)

/obj/item/clothing/suit/marine/Destroy()
	QDEL_NULL(light_holder)
	return ..()

/obj/item/clothing/suit/marine/update_icon(mob/user)
	var/image/I
	armor_overlays["lamp"] = null
	if(flags_marine_armor & ARMOR_LAMP_OVERLAY)
		if(flags_marine_armor & ARMOR_LAMP_ON)
			I = image('icons/obj/items/clothing/cm_suits.dmi', src, "lamp-on")
		else
			I = image('icons/obj/items/clothing/cm_suits.dmi', src, "lamp-off")
		armor_overlays["lamp"] = I
		overlays += I
	else armor_overlays["lamp"] = null
	if(user) user.update_inv_wear_suit()

/obj/item/clothing/suit/marine/MouseDrop(obj/over_object as obj)
	if (ishuman(usr))
		//makes sure that the clothing is equipped so that we can't drag it into our hand from miles away.
		if ((flags_item & NODROP) || loc != usr)
			return

		if (!usr.is_mob_incapacitated() && !(usr.buckled))
			if(over_object)
				switch(over_object.name)
					if("r_hand")
						if(usr.drop_inv_item_on_ground(src))
							usr.put_in_r_hand(src)
					if("l_hand")
						if(usr.drop_inv_item_on_ground(src))
							usr.put_in_l_hand(src)
				add_fingerprint(usr)

/obj/item/clothing/suit/marine/post_vendor_spawn_hook(mob/living/carbon/human/user) //used for randomizing/selecting a variant for armors.
	var/new_look //used for the icon_state text replacement.

	if(!user?.client?.prefs)
		new_look = rand(1,armor_variation)

	else if(user.client.prefs.preferred_armor == "Random")
		new_look = rand(1,armor_variation)

	else
		new_look = GLOB.armor_style_list[user.client.prefs.preferred_armor]

	icon_state = replacetext(icon_state,"1","[new_look]")
	update_icon(user)

/obj/item/clothing/suit/marine/attack_self(mob/user)
	..()

	if(!isturf(user.loc))
		to_chat(user, SPAN_WARNING("You cannot turn the light [light_on ? "off" : "on"] while in [user.loc].")) //To prevent some lighting anomalies.
		return

	if(flashlight_cooldown > world.time)
		return
	if(!ishuman(user))
		return

	var/mob/living/carbon/human/H = user
	if(H.wear_suit != src)
		return

	turn_light(user, !light_on)

/obj/item/clothing/suit/marine/item_action_slot_check(mob/user, slot)
	if(!ishuman(user))
		return FALSE
	if(slot != WEAR_JACKET)
		return FALSE
	return TRUE //only give action button when armor is worn.

/obj/item/clothing/suit/marine/turn_light(mob/user, toggle_on)
	. = ..()
	if(. != CHECKS_PASSED)
		return
	set_light_range(initial(light_range))
	set_light_power(FLOOR(initial(light_power) * 0.5, 1))
	set_light_on(toggle_on)
	flags_marine_armor ^= ARMOR_LAMP_ON

	light_holder.set_light_flags(LIGHT_ATTACHED)
	light_holder.set_light_range(initial(light_range))
	light_holder.set_light_power(initial(light_power))
	light_holder.set_light_on(toggle_on)

	if(!toggle_on)
		playsound(src, 'sound/handling/click_2.ogg', 50, 1)

	playsound(src, 'sound/handling/suitlight_on.ogg', 50, 1)
	update_icon(user)

	for(var/X in actions)
		var/datum/action/A = X
		A.update_button_icon()

/obj/item/clothing/suit/marine/mob_can_equip(mob/living/carbon/human/M, slot, disable_warning = 0)
	. = ..()
	if (.)
		if(issynth(M) && M.allow_gun_usage == FALSE && !(flags_marine_armor & SYNTH_ALLOWED))
			M.visible_message(SPAN_DANGER("Your programming prevents you from wearing this!"))
			return 0

/obj/item/clothing/suit/marine/lines
	name = "M3 pattern ridged marine armor"
	icon_state = "2"
	specialty = "M3 pattern ridged marine"

/obj/item/clothing/suit/marine/smooth
	name = "M3 pattern smooth marine armor"
	icon_state = "3"
	specialty = "M3 pattern smooth marine"

/obj/item/clothing/suit/marine/light
	name = "\improper M3-L pattern light armor"
	desc = "A lighter, cut down version of the standard M3 pattern armor. It sacrifices durability for less weight."
	specialty = "\improper M3-L pattern light"
	icon_state = "L1"
	armor_variation = 3
	slowdown = SLOWDOWN_ARMOR_LIGHT
	armor_melee = CLOTHING_ARMOR_MEDIUMLOW
	armor_bullet = CLOTHING_ARMOR_MEDIUMLOW
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMLOW
	armor_rad = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_LOW
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_PAINT, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PONCHO)
	restricted_accessory_slots = list(ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PAINT)

/obj/item/clothing/suit/marine/light/lines
	name = "M3 pattern ridged marine armor"
	icon_state = "L2"
	armor_variation = 0

/obj/item/clothing/suit/marine/light/smooth
	name = "M3 pattern smooth marine armor"
	icon_state = "L3"
	armor_variation = 0

/obj/item/clothing/suit/marine/light/standard
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE


/obj/item/clothing/suit/marine/heavy
	name = "\improper M3-H pattern heavy armor"
	desc = "M3 armor vest with a rheological liner behind the chestplate, additional armor over the limbs to improve protection ballistic and blast protections. \nMarginal improvement in other areas, and the mass of the extra plates degrades agility, especially in null-gee."
	specialty = "\improper M3-H pattern"
	icon_state = "H1"
	armor_variation = 3
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bullet = CLOTHING_ARMOR_HIGHPLUS
	armor_bomb = CLOTHING_ARMOR_HIGHPLUS
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	slowdown = SLOWDOWN_ARMOR_LOWHEAVY
	movement_compensation = SLOWDOWN_ARMOR_MEDIUM

/obj/item/clothing/suit/marine/heavy/lines
	name = "M3 pattern ridged marine armor"
	icon_state = "L2"
	armor_variation = 0

/obj/item/clothing/suit/marine/heavy/smooth
	name = "M3 pattern smooth marine armor"
	icon_state = "L3"
	armor_variation = 0

/obj/item/clothing/suit/marine/rto
	icon_state = "io"
	name = "\improper M4 pattern marine armor"
	desc = "A well tinkered and crafted hybrid of Smart-Gunner mesh and M3 pattern plates. Robust, yet nimble, with room for all your pouches."
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_rad = CLOTHING_ARMOR_MEDIUM
	light_range = 5 //slightly higher
	specialty = "M4 pattern marine"
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_DECORSHIN, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PONCHO, ACCESSORY_SLOT_DECORKNEE)
	restricted_accessory_slots = list(ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_DECORSHIN, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_DECORKNEE)

/obj/item/clothing/suit/marine/rto/forecon
	name = "\improper M3-R pattern recon armor"
	desc = "A modified Colonial Marines M3 Pattern Chestplate. Protects the chest from ballistic rounds, bladed objects and accidents. Issued mostly to recon units."
	icon_state = "4"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_DECORSHIN, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_DECORNECK, ACCESSORY_SLOT_PAINT, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PONCHO, ACCESSORY_SLOT_DECORKNEE)
	restricted_accessory_slots = list(ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_DECORNECK, ACCESSORY_SLOT_DECORSHIN, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PAINT, ACCESSORY_SLOT_DECORKNEE)

/obj/item/clothing/suit/marine/leader
	name = "\improper B12 pattern marine armor"
	desc = "Semi-experimental body armor system similar to M3, incorporating primarily carbon fiber instead of boron carbide. \nDesigned in a lovely olive green, slightly improved protection against blunt impact and biological hazards."
	icon_state = "7"
	armor_melee = CLOTHING_ARMOR_MEDIUMHIGH
	armor_bomb = CLOTHING_ARMOR_MEDIUM
	armor_bio = CLOTHING_ARMOR_MEDIUMHIGH
	armor_internaldamage = CLOTHING_ARMOR_MEDIUMHIGH
	specialty = "B12 pattern marine"

/obj/item/clothing/suit/marine/guard
	desc = "Standard UACG issue M3 Pattern Personal Armor. Composite ballistic armor, integral biomonitoring system, and brackets for the IMP system as well as the TNR Shoulder Lamp."
	icon_state = "uacg"
	item_state = "uacg"
	flags_atom = NO_SNOW_TYPE
	name = "\improper M3 pattern armor"
	specialty = "M3 pattern"

/obj/item/clothing/suit/marine/guard/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/pads/groin/uacg/crotchplate = new()
	src.attach_accessory(null, crotchplate, TRUE)

//Army & USASF custom-armors\\

/obj/item/clothing/suit/marine/medium/rto/navy
	name = "\improper M4-N pattern armor"
	desc = "A set of USASF acquired M4 armor, with slight modifications to better suite ship-side usage. Robust, yet very nimble, with room for all your pouches. Compatible with attachable components of the M3-pattern armor system."
	icon_state = "navy"
	item_state = "navy"
	slowdown = SLOWDOWN_ARMOR_LIGHT    //carbon fibre and shit in the plates rather than heavy stuff, so the swabbies stay nimble
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE

/obj/item/clothing/suit/marine/medium/rto/navy/heavy
	name = "\improper M4-N pattern shore-deployment armor"
	desc = "A set of USASF acquired M4 armor, modified to fit the needs of the members that see deployment on the surface of worlds. Robust, yet very nimble, with room for all your pouches. Compatible with attachable components of the M3-pattern armor system."

/obj/item/clothing/suit/marine/medium/rto/navy/heavy/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/pads/groin/navy/crotchplate = new()
	src.attach_accessory(null, crotchplate, TRUE)
	var/obj/item/clothing/accessory/pads/greaves/navy/shinguards = new()
	src.attach_accessory(null, shinguards, TRUE)
	var/obj/item/clothing/accessory/pads/navy/shoulderpads = new()
	src.attach_accessory(null, shoulderpads, TRUE)

/obj/item/clothing/suit/marine/medium/rto/army
	name = "\improper Personal Body Armor System"
	desc = "Whilst it saw limited field-testing amongst the USCMC, the US Army adopted the M4 series pattern armor across the board under the PBAS program. Surprisingly uncomfortable, even compared to the old M3 series armor. At least it's compatible with attachable suplementary armor components of the M3 series."
	icon_state = "io"
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE
	valid_accessory_slots = list(ACCESSORY_SLOT_MEDAL, ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_DECORSHIN, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_PONCHO, ACCESSORY_SLOT_DECORKNEE)
	restricted_accessory_slots = list(ACCESSORY_SLOT_DECORARMOR, ACCESSORY_SLOT_DECORGROIN, ACCESSORY_SLOT_DECORBRACER, ACCESSORY_SLOT_DECORSHIN, ACCESSORY_SLOT_M3UTILITY, ACCESSORY_SLOT_DECORKNEE)

/obj/item/clothing/suit/marine/medium/rto/army/medium

/obj/item/clothing/suit/marine/medium/rto/army/medium/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/pads/groin/crotchplate = new()
	src.attach_accessory(null, crotchplate, TRUE)
	var/obj/item/clothing/accessory/pads/greaves/shinguards = new()
	src.attach_accessory(null, shinguards, TRUE)
	var/obj/item/clothing/accessory/pads/shoulderpads = new()
	src.attach_accessory(null, shoulderpads, TRUE)

/obj/item/clothing/suit/marine/medium/rto/army/heavy

/obj/item/clothing/suit/marine/medium/rto/army/heavy/Initialize(mapload)
	. = ..()
	var/obj/item/clothing/accessory/pads/groin/crotchplate = new()
	src.attach_accessory(null, crotchplate, TRUE)
	var/obj/item/clothing/accessory/pads/greaves/shinguards = new()
	src.attach_accessory(null, shinguards, TRUE)
	var/obj/item/clothing/accessory/pads/shoulderpads = new()
	src.attach_accessory(null, shoulderpads, TRUE)
	var/obj/item/clothing/accessory/pads/bracers/armguards = new()
	src.attach_accessory(null, armguards, TRUE)
	var/obj/item/clothing/accessory/pads/kneepads/knees = new()
	src.attach_accessory(null, knees, TRUE)

//==================PLU Lamp Rig==================\\

/obj/item/clothing/suit/marine/lamp
	name = "\improper PLU lamp rig"
	icon_state = "lamp_rig"
	desc = "A lightweight rig designed to support a shoulder lamp."
	flags_atom = NO_SNOW_TYPE|NO_NAME_OVERRIDE
	blood_overlay_type = "coat"
	flags_armor_protection = BODY_FLAG_CHEST
	flags_cold_protection = BODY_FLAG_CHEST
	min_cold_protection_temperature = null
	slowdown = SLOWDOWN_ARMOR_NONE
	armor_melee = CLOTHING_ARMOR_NONE
	armor_bullet = CLOTHING_ARMOR_NONE
	armor_laser = CLOTHING_ARMOR_NONE
	armor_energy = CLOTHING_ARMOR_NONE
	armor_bomb = CLOTHING_ARMOR_NONE
	armor_bio = CLOTHING_ARMOR_NONE
	armor_rad = CLOTHING_ARMOR_NONE
	armor_internaldamage = CLOTHING_ARMOR_NONE
	time_to_unequip = 10
	time_to_equip = 10
