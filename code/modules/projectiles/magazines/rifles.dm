


//-------------------------------------------------------
//M41A (MK2) PULSE RIFLE AMMUNITION

/obj/item/ammo_magazine/rifle
	name = "\improper M41A magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine."
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "m41a"
	item_state = "generic_mag"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/m41a
	ammo_band_icon = "+m41a_band"
	ammo_band_icon_empty = "+m41a_band_e"

/obj/item/ammo_magazine/rifle/extended
	name = "\improper M41A extended magazine (10x24mm)"
	desc = "A 10mm assault extended rifle magazine."
	icon_state = "m41a_extended"
	max_rounds = 60
	bonus_overlay = "m41a_ex"

/obj/item/ammo_magazine/rifle/incendiary
	name = "\improper M41A incendiary magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine."
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/explosive
	name = "\improper M41A explosive magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine. Oh god... just don't hit friendlies with it."
	default_ammo = /datum/ammo/bullet/rifle/explosive
	ammo_band_color = AMMO_BAND_COLOR_EXPLOSIVE

/obj/item/ammo_magazine/rifle/heap
	name = "\improper M41A HEAP magazine (10x24mm)"
	desc = "A 10mm armor piercing high explosive magazine."
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/ap
	name = "\improper M41A AP magazine (10x24mm)"
	desc = "A 10mm armor piercing magazine."
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/le
	name = "\improper M41A LE magazine (10x24mm)"
	desc = "A 10mm armor shredding magazine."
	default_ammo = /datum/ammo/bullet/rifle/le
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/rifle/penetrating
	name = "\improper M41A wall-penetrating magazine (10x24mm)"
	desc = "A 10mm wall-penetrating magazine."
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/toxin
	name = "\improper M41A toxin magazine (10x24mm)"
	desc = "A 10mm toxin magazine."
	default_ammo = /datum/ammo/bullet/rifle/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN


/obj/item/ammo_magazine/rifle/rubber
	name = "M41A Rubber Magazine (10x24mm)"
	desc = "A 10mm magazine filled with rubber bullets."
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/tracer
	name = "\improper M41A tracer magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine filled with tracer bullets."
	default_ammo = /datum/ammo/bullet/rifle/tracer

//-------------------------------------------------------
//M41A (MK1) TRUE AND ORIGINAL

/obj/item/ammo_magazine/rifle/m41aMK1
	name = "\improper M41A magazine (10x24mm)"
	desc = "A long rectangular box magazine for the M41A. Holds 99 caseless 10x24mm rounds."
	icon_state = "m41a_mk1"
	max_rounds = 99
	gun_type = /obj/item/weapon/gun/rifle/m41aMK1
	default_ammo = /datum/ammo/bullet/rifle
	ammo_band_icon = "+m41a_mk1_band"
	ammo_band_icon_empty = "+m41a_mk1_band_e"
	bonus_overlay = "m41a_mk1_overlay"

/obj/item/ammo_magazine/rifle/m41aMK1/rubber
	name = "\improper M41A rubber magazine"
	desc = "A long rectangular box magazine for the M41A. Holds 99 caseless 10x24mm less lethal rubber bullets. Be careful, they're LESS, lethal, not NON, lethal."
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/m41aMK1/ap
	name = "\improper M41A AP magazine (10x24mm)"
	desc = "A long rectangular box magazine for the M41A. Holds 99 caseless 10x24mm steelcore armor piercing rounds."
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/m41aMK1/heap
	name = "\improper M41A HEAP magazine (10x24mm)"
	desc = "A long rectangular box magazine for the M41A. Holds 99 caseless 10x24mm M309 Armor Piercing High Explosive rounds."
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/m41aMK1/incendiary
	name = "\improper M41A MK1 incendiary magazine (10x24mm)"
	desc = "A long rectangular box magazine for the M41A. Holds 99 caseless 10x24mm incendiary rounds."
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/m41aMK1/toxin
	name = "\improper M41A MK1 toxin magazine (10x24mm)"
	desc = "A long rectangular box of rounds that is only compatible with the older M41A MK1. Holds up to 99 rounds. This one contains toxic bullets."
	default_ammo = /datum/ammo/bullet/rifle/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/rifle/m41aMK1/penetrating
	name = "\improper M41A MK1 wall-penetrating magazine (10x24mm)"
	desc = "A long rectangular box of rounds that is only compatible with the older M41A MK1. Holds up to 99 rounds. This one contains wall-penetrating bullets."
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/m41aMK1/recon
	icon_state = "m41a_mk1_recon"
	current_rounds = 95
	bonus_overlay = "m41a_mk1_recon_overlay"

/obj/item/ammo_magazine/rifle/m41aMK1/tracer
	name = "\improper M41A MK1 tracer magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine filled with tracer bullets."
	default_ammo = /datum/ammo/bullet/rifle/tracer

//-------------------------------------------------------
//M49A, l42 reskin, same stats as before but different, lore friendly, shell.

/obj/item/ammo_magazine/rifle/m49a
	name = "\improper M49A magazine (10x28mm)"
	desc = "A magazine of standard 10x28mm rounds for use in the M49A battle rifle."
	icon_state = "m49a"
	caliber = "10x28mm"
	default_ammo = /datum/ammo/bullet/rifle/heavy
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/m49a
	ammo_band_icon = "+m49a_band"
	ammo_band_icon_empty = "+m49a_band_e"

/obj/item/ammo_magazine/rifle/m49a/ap
	name = "\improper M49A armor-piercing magazine (10x28mm)"
	desc = "A magazine of armor-piercing 10x28mm rounds for use in the M49A battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/heavy/ap
	max_rounds = 30
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/m49a/ext
	name = "\improper M49A extended magazine (10x28mm)"
	desc = "A magazine of armor-piercing 10x28mm rounds for use in the M49A battle rifle. Holds an additional 10 rounds, up to 40."
	icon_state = "m49a_extended"
	bonus_overlay = "m49a_ex"
	max_rounds = 40

/obj/item/ammo_magazine/rifle/m49a/rubber
	name = "M49A rubber magazine (10x28mm)"
	desc = "A magazine of less than lethal rubber 10x28mm rounds for use in the M49A battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/m49a/heap
	name = "\improper M49A high-explosive armor-piercing magazine (10x28mm)"
	desc = "A magazine of high explosive armor piercing 10x28mm rounds for use in the M49A battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/heavy/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/m49a/penetrating
	name = "\improper M49A wall-penetrating magazine (10x28mm)"
	desc = "A magazine of wall-penetrating 10x28mm rounds for use in the M49A battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/m49a/incendiary
	name = "\improper M49A incendiary magazine (10x28mm)"
	desc = "A magazine of incendiary 10x28mm rounds for use in the M49A battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/m49a/pve
	name = "\improper M49A depleted uranium magazine (10x28mm)"
	desc = "A magazine of wall-penetrating, body-penetrating, toxic 10x28mm rounds for use in the M49A-R2 battle rifle."
	icon_state = "m49a"
	default_ammo = /datum/ammo/bullet/rifle/heavy/du
	gun_type = /obj/item/weapon/gun/rifle/m49a/pve
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

//-------------------------------------------------------
//XM40 AKA SOF RIFLE FROM HELL (It's an EM-2, a prototype of the real world L85A1 way back from the 1940s. We've given it a blue plastic shell and an integral suppressor)
/obj/item/ammo_magazine/rifle/xm40
	name = "\improper XM40 magazine (10x24mm)"
	desc = "A stubby and wide, high-capacity double stack magazine used in the XM40 pulse rifle. Fires 10x24mm Armor Piercing rounds, holding up to 60 + 1 in the chamber."
	icon_state = "m40_sd"
	max_rounds = 60
	gun_type = /obj/item/weapon/gun/rifle/m41aMK1/xm40
	default_ammo = /datum/ammo/bullet/rifle/ap

/obj/item/ammo_magazine/rifle/xm40/heap
	name = "\improper XM40 HEAP magazine (10x24mm)"
	desc = "A stubby and wide, high-capacity double stack magazine used in the XM40 pulse rifle. Fires 10x24mm High Explosive Armor Piercing rounds, holding up to 60 + 1 in the chamber."
	icon_state = "m40_sd_heap"
	max_rounds = 60
	default_ammo = /datum/ammo/bullet/rifle/heap

//-------------------------------------------------------
//MAR-40 AK CLONE //AK47 and FN FAL together as one.

/obj/item/ammo_magazine/rifle/mar40
	name = "\improper MAR magazine (8.8x29mm)"
	desc = "A 8.8x29mm magazine for the MAR series of firearms."
	caliber = "8.8x29mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "mar40"
	default_ammo = /datum/ammo/bullet/rifle/mar40
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/mar40
	w_class = SIZE_MEDIUM

/obj/item/ammo_magazine/rifle/mar40/extended
	name = "\improper MAR extended magazine (8.8x29mm)"
	desc = "A 8.8x29mm magazine, this one carries more rounds than the average magazine."
	max_rounds = 60
	bonus_overlay = "mar40_ex"
	icon_state = "mar40_extended"

/obj/item/ammo_magazine/rifle/mar40/lmg
	name = "\improper MAR drum magazine (8.8x29mm)"
	desc = "A 8.8x29mm drum magazine for the MAR-50 LMG."
	caliber = "8.8x29mm"
	icon_state = "mar50"
	max_rounds = 100
	gun_type = /obj/item/weapon/gun/rifle/mar40/lmg

//-------------------------------------------------------
//M16 RIFLE

/obj/item/ammo_magazine/rifle/m16
	name = "\improper M16 magazine"
	desc = "An FMJ 5.56x45mm magazine for the M16 assault rifle and its clones. Holds 20 rounds."
	caliber = "5.56x45mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "m16"
	default_ammo = /datum/ammo/bullet/rifle/m16
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/m16
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+m16_band"
	ammo_band_icon_empty = "+m16_band_e"

/obj/item/ammo_magazine/rifle/m16/extended
	name = "\improper M16 extended magazine"
	desc = "An FMJ 5.56x45mm magazine for the M16 assault rifle and its clones. Holds 30 rounds."
	caliber = "5.56x45mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "m16"
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/m16
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+m16_band"
	ammo_band_icon_empty = "+m16_band_e"

/obj/item/ammo_magazine/rifle/m16/ap
	name = "\improper M16 AP magazine"
	desc = "An AP 5.56x45mm magazine for the M16 assault rifle and its clones. Holds 20 rounds."
	caliber = "5.56x45mm"
	default_ammo = /datum/ammo/bullet/rifle/m16/ap
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/m16
	w_class = SIZE_MEDIUM
	ammo_band_color = AMMO_BAND_COLOR_AP

//-------------------------------------------------------
//AR10 RIFLE

/obj/item/ammo_magazine/rifle/ar10
	name = "\improper AR10 magazine (7.62x51mm)"
	desc = "A 7.62x51mm magazine for the AR10 assault rifle."
	caliber = "7.62x51mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "ar10"
	default_ammo = /datum/ammo/bullet/rifle/ar10
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/ar10
	w_class = SIZE_MEDIUM

//-------------------------------------------------------
//UPP TYPE 71 RIFLE

/obj/item/ammo_magazine/rifle/type71
	name = "\improper Type 71 magazine (10x27mm)"
	desc = "A 10x27mm high-capacity casket magazine for the Type 71 rifle."
	caliber = "10x27mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "type71"
	ammo_band_icon = "+type71_band"
	ammo_band_icon_empty = "+type71_band_e"
	default_ammo = /datum/ammo/bullet/rifle/upp
	max_rounds = 60
	gun_type = /obj/item/weapon/gun/rifle/type71

/obj/item/ammo_magazine/rifle/type71/ap
	name = "\improper Type 71 AP magazine (10x27mm)"
	desc = "A 10x27mm high-capacity casket magazine containing armor piercing rounds for the Type 71 rifle."
	default_ammo = /datum/ammo/bullet/rifle/upp/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/type71/heap
	name = "\improper Type 71 HEAP magazine (10x27mm)"
	desc = "A 10x27mm high-capacity casket magazine containing the standard high explosive armor piercing rounds for the Type 71 rifle."
	default_ammo = /datum/ammo/bullet/rifle/upp/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

//-------------------------------------------------------
//UPP AG80 RIFLE

/obj/item/ammo_magazine/rifle/ag80
	name = "\improper AG80 magazine (9.7x16mm)"
	desc = "A 9.7x16mm high-capacity magazine for the AG80 rifle."
	caliber = "9.7x16mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "ag80"
	ammo_band_icon = "+ag80_band"
	ammo_band_icon_empty = "+ag80_band_e"
	default_ammo = /datum/ammo/bullet/rifle/ag80 //need to reference the actual ammo designed for the carbine
	max_rounds = 99
	gun_type = /obj/item/weapon/gun/rifle/ag80

//-------------------------------------------------------
//CANC LW-317 RIFLE

/obj/item/ammo_magazine/rifle/lw317
	name = "\improper LW-317 magazine (6x38mm)"
	desc = "A 6x38mm high-capacity top-loading magazine for the LW-317 carbine."
	caliber = "6x38mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/upp.dmi'
	icon_state = "lw317"
	ammo_band_icon = "+lw317_band"
	ammo_band_icon_empty = "+lw317_band_e"
	default_ammo = /datum/ammo/bullet/rifle/lw317
	max_rounds = 55
	gun_type = /obj/item/weapon/gun/rifle/lw317

/obj/item/ammo_magazine/rifle/lw317/ap
	name = "\improper LW-317 AP magazine (6x38mm)"
	desc = "A 6x38mm high-capacity top-loading armor-piercing magazine for the LW-317 carbine."
	default_ammo = /datum/ammo/bullet/rifle/lw317/ap
	ammo_band_color = AMMO_BAND_COLOR_AP
	bonus_overlay = "lw317apoverlay"
//-------------------------------------------------------
//L42A Battle Rifle

/obj/item/ammo_magazine/rifle/l42a
	name = "\improper L42A magazine (10x24mm)"
	desc = "A 10mm battle rifle magazine."
	caliber = "10x24mm"
	icon_state = "l42mk1"
	bonus_overlay = "l42_mag_overlay"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 25
	gun_type = /obj/item/weapon/gun/rifle/l42a
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+l42mk1_band"
	ammo_band_icon_empty = "+l42mk1_band_e"

/obj/item/ammo_magazine/rifle/l42a/ap
	name = "\improper L42A AP magazine (10x24mm)"
	desc = "A 10mm battle rifle armor piercing magazine."
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/l42a/le
	name = "\improper L42A LE magazine (10x24mm)"
	desc = "A 10mm battle rifle armor shredding magazine."
	default_ammo = /datum/ammo/bullet/rifle/le
	ammo_band_color = AMMO_BAND_COLOR_LIGHT_EXPLOSIVE

/obj/item/ammo_magazine/rifle/l42a/rubber
	name = "L42A rubber magazine (10x24mm)"
	default_ammo = /datum/ammo/bullet/rifle/rubber
	ammo_band_color = AMMO_BAND_COLOR_RUBBER

/obj/item/ammo_magazine/rifle/l42a/heap
	name = "\improper L42A HEAP (10x24mm)"
	desc = "A 10mm battle rifle high explosive armor piercing magazine."
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/l42a/penetrating
	name = "\improper L42A wall-penetrating magazine (10x24mm)"
	default_ammo = /datum/ammo/bullet/rifle/ap/penetrating
	ammo_band_color = AMMO_BAND_COLOR_PENETRATING

/obj/item/ammo_magazine/rifle/l42a/toxin
	name = "\improper L42A toxin magazine (10x24mm)"
	desc = "A 10mm battle rifle toxin magazine."
	default_ammo = /datum/ammo/bullet/rifle/ap/toxin
	ammo_band_color = AMMO_BAND_COLOR_TOXIN

/obj/item/ammo_magazine/rifle/l42a/extended
	name = "\improper L42A extended magazine (10x24mm)"
	desc = "A 10mm battle rifle extended magazine."
	caliber = "10x24mm"
	icon_state = "l42mk1_extended"
	bonus_overlay = "l42_ex_overlay"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 35
	gun_type = /obj/item/weapon/gun/rifle/l42a
	w_class = SIZE_MEDIUM

/obj/item/ammo_magazine/rifle/l42a/incendiary
	name = "\improper L42A incendiary magazine (10x24mm)"
	desc = "A 10mm battle rifle incendiary magazine."
	caliber = "10x24mm"
	default_ammo = /datum/ammo/bullet/rifle/incendiary
	max_rounds = 20
	gun_type = /obj/item/weapon/gun/rifle/l42a
	w_class = SIZE_MEDIUM
	ammo_band_color = AMMO_BAND_COLOR_INCENDIARY

/obj/item/ammo_magazine/rifle/l42a/abr40
	name = "\improper ABR-40 magazine (10x24mm)"
	desc = "An ABR-40 magazine loaded with full metal jacket ammunition, for use at the firing range or while hunting. Theoretically cross-compatible with an L42A battle rifle."
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "abr40"
	bonus_overlay = "abr40_mag_overlay"
	max_rounds = 12
	w_class = SIZE_SMALL
	ammo_band_icon = "+abr40_band"
	ammo_band_icon_empty = "+abr40_band_e"

/obj/item/ammo_magazine/rifle/l42a/abr40/holo_target
	name = "\improper ABR-40 holotargeting magazine (10x24mm)"
	desc = "An ABR-40 magazine loaded with holo-targeting ammunition, primarily utilized to highlight hunting targets for easier target capture. Theoretically cross-compatible with an L42A battle rifle."
	default_ammo = /datum/ammo/bullet/rifle/holo_target/hunting
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING

//M20A

/obj/item/ammo_magazine/rifle/m20a
	name = "\improper M20A magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine."
	caliber = "10x24mm"
	icon_state = "m20a"
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 40
	gun_type = /obj/item/weapon/gun/rifle/m20a
	w_class = SIZE_MEDIUM
	ammo_band_icon = "+m20a_band"
	ammo_band_icon_empty = "+m20a_band_e"
//-------------------------------------------------------
// NSG 23 ASSAULT RIFLE - PMC PRIMARY RIFLE

/obj/item/ammo_magazine/rifle/nsg23
	name = "\improper NSG 23 magazine (10x24mm)"
	desc = "An NSG 23 assault rifle magazine."
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/wy.dmi'
	icon_state = "nsg23"
	item_state = "nsg23"
	bonus_overlay = "nsg23_mag_overlay" //needs to be an overlay, as the mag has a hole that would be filled over by the ext overlay
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/nsg23
	ammo_band_icon = "+nsg23_band"
	ammo_band_icon_empty = "+nsg23_band_e"

/obj/item/ammo_magazine/rifle/nsg23/extended
	name = "\improper NSG 23 extended magazine (10x24mm)"
	desc = "An NSG 23 assault rifle magazine. This one contains 45 bullets."
	icon_state = "nsg23_ext"
	item_state = "nsg23_ext"
	bonus_overlay = "nsg23_ext_overlay"
	max_rounds = 45

/obj/item/ammo_magazine/rifle/nsg23/ap
	name = "\improper NSG 23 armor-piercing magazine (10x24mm)"
	desc = "An NSG 23 assault rifle magazine. This one is armor piercing."
	default_ammo = /datum/ammo/bullet/rifle/ap
	ammo_band_color = AMMO_BAND_COLOR_AP

/obj/item/ammo_magazine/rifle/nsg23/heap
	name = "\improper NSG 23 HEAP magazine (10x24mm)"
	desc = "An NSG 23 assault rifle magazine. This one is loaded with armor-piercing explosive tipped rounds."
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

//--------------------------------------------------------
//Bolt action rifle ammo
/obj/item/ammo_magazine/rifle/boltaction
	name = "\improper Basira-Armstrong magazine (6.5mm)"
	desc = "A magazine for the Basira-Armstrong hunting rifle. Compliant with the 15-cartridge limit on civilian hunting rifles."
	caliber = "6.5mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/colony.dmi'
	icon_state = "hunting"
	default_ammo = /datum/ammo/bullet/sniper/crude
	max_rounds = 10
	gun_type = /obj/item/weapon/gun/boltaction
	w_class = SIZE_SMALL

/obj/item/ammo_magazine/rifle/boltaction/vulture
	name = "\improper M707 \"Vulture\" magazine (20x102mm)"
	desc = "A magazine for the M707 \"Vulture\" anti-matieriel rifle. Contains up to 4 massively oversized rounds."
	caliber = "20x102mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/uscm.dmi'
	icon_state = "vulture"
	handful_state = "vulture_bullet"
	default_ammo = /datum/ammo/bullet/sniper/anti_materiel/vulture
	max_rounds = 4
	gun_type = /obj/item/weapon/gun/boltaction/vulture
	w_class = SIZE_MEDIUM // maybe small? This shit's >4 inches long mind you
	ammo_band_icon = "+vulture_band"
	ammo_band_icon_empty = "+vulture_band_e"

/obj/item/ammo_magazine/rifle/boltaction/vulture/holo_target
	name = "\improper M707 \"Vulture\" holo-target magazine (20x102mm)"
	desc = "A magazine for the M707 \"Vulture\" anti-matieriel rifle. Contains up to 4 massively oversized <b>IFF-CAPABLE</b> holo-targeting rounds, which excel at marking heavy targets to be attacked by allied ground forces. The logistical requirements for such capabilities heavily hinder the performance and stopping power of this round."
	default_ammo =  /datum/ammo/bullet/sniper/anti_materiel/vulture/holo_target
	ammo_band_color = AMMO_BAND_COLOR_HOLOTARGETING

//=ROYAL MARINES=\\

/obj/item/ammo_magazine/rifle/rmc_f90
	name = "\improper F903 magazine (10x24mm)"
	desc = "A 10mm assault rifle magazine used by the royal marines."
	caliber = "10x24mm"
	icon = 'icons/obj/items/weapons/guns/ammo_by_faction/twe_ammo.dmi'
	icon_state = "aug"
	item_state = "aug"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/rifle
	max_rounds = 30
	gun_type = /obj/item/weapon/gun/rifle/rmc_f90
	ammo_band_icon = "+aug_band"
	ammo_band_icon_empty = "+aug_band_e"

/obj/item/ammo_magazine/rifle/rmc_f90/marksman
	name = "\improper F903A1 Marksman magazine (10x24mm)"
	desc = "A 10mm armor-piercing assault rifle magazine used by the royal marines."
	icon_state = "aug_dmr"
	item_state = "aug_dmr"
	default_ammo = /datum/ammo/bullet/rifle/ap
	gun_type = /obj/item/weapon/gun/rifle/rmc_f90/scope
	max_rounds = 20
	ammo_band_color = AMMO_BAND_COLOR_AP
	ammo_band_icon = "+aug_dmr_band"
	ammo_band_icon_empty = "+aug_dmr_band_e"

/obj/item/ammo_magazine/rifle/rmc_f90/heap
	name = "\improper F903 HEAP magazine (10x24mm)"
	desc = "A 10mm armor piercing high explosive assault rifle magazine used by the royal marines."
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

/obj/item/ammo_magazine/rifle/rmc_f90/marksman/heap
	name = "\improper F903A1 Marksman magazine (10x24mm)"
	desc = "A 10mm armor piercing high explosive assault rifle magazine used by the royal marines."
	icon_state = "aug_dmr"
	item_state = "aug_dmr"
	default_ammo = /datum/ammo/bullet/rifle/heap
	ammo_band_color = AMMO_BAND_COLOR_HEAP

//--------------------------------------------------------
//XM51 BREACHING SHOTGUN

/obj/item/ammo_magazine/rifle/xm51
	name = "\improper M1771 magazine (16g)"
	desc = "A 16 gauge pump-action shotgun magazine."
	icon_state = "xm51"
	caliber = "16g"
	w_class = SIZE_MEDIUM
	default_ammo = /datum/ammo/bullet/shotgun/buckshot/light
	max_rounds = 12
	gun_type = /obj/item/weapon/gun/rifle/xm51
	transfer_handful_amount = 6
