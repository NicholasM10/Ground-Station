/* In this file:
 * Wood floor
 * Grass floor
 * Carpet floor
 */

/turf/open/floor/wood
	icon_state = "wood"
	floor_tile = /obj/item/stack/tile/wood
	broken_states = list("wood-broken", "wood-broken2", "wood-broken3", "wood-broken4", "wood-broken5", "wood-broken6", "wood-broken7")

/turf/open/floor/wood/attackby(obj/item/C, mob/user, params)
	if(..())
		return
	if(istype(C, /obj/item/weapon/screwdriver))
		if(broken || burnt)
			return
		user << "<span class='danger'>You unscrew the planks.</span>"
		new floor_tile(src)
		make_plating()
		playsound(src, 'sound/items/Screwdriver.ogg', 80, 1)
		return

/turf/open/floor/wood/cold
	temperature = 255.37

/turf/open/floor/wood/airless
	initial_gas_mix = "TEMP=2.7"

/turf/open/floor/grass
	name = "grass patch"
	icon_state = "grass"
	initial_gas_mix = "o2=22;n2=82;TEMP=293.15"
	planetary_atmos = TRUE
	baseturf = /turf/open/floor/dirt
	floor_tile = /obj/item/stack/tile/grass
	broken_states = list("sand")
	var/ore_type = /obj/item/weapon/ore/glass

/turf/open/floor/dirt
	name = "dirt"
	icon_state = "dirt"
	baseturf = /turf/open/floor/dirt

/turf/open/floor/grass/New()
	..()
	spawn(1)
		update_icon()

/turf/open/floor/grass/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/shovel) && params)
		new ore_type(src)
		new ore_type(src) //Make some sand if you shovel grass
		user << "<span class='notice'>You shovel [src].</span>"
		make_plating()
	if(..())
		return

/turf/open/floor/grass/snow
	name = "snow"
	icon = 'icons/turf/snow.dmi'
	desc = "Looks cold."
	icon_state = "snow"
	ore_type = /obj/item/stack/sheet/mineral/snow
	planetary_atmos = TRUE
	floor_tile = null
	initial_gas_mix = "o2=22;n2=82;TEMP=180"
	slowdown = 2


/turf/open/floor/grass/snow/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/weapon/crowbar))//You need to dig this turf out instead of crowbarring it
		return
	..()

/turf/open/floor/grass/snow/basalt //By your powers combined, I am captain planet
	name = "volcanic floor"
	icon = 'icons/turf/floors.dmi'
	icon_state = "basalt"
	ore_type = /obj/item/weapon/ore/glass/basalt
	initial_gas_mix = "o2=14;n2=23;TEMP=300"
	slowdown = 0

/turf/open/floor/grass/snow/basalt/New()
	..()
	if(prob(15))
		icon_state = "basalt[rand(0, 12)]"
		switch(icon_state)
			if("basalt1", "basalt2", "basalt3")
				SetLuminosity(1, 1)


/turf/open/floor/carpet
	name = "Carpet"
	icon = 'icons/turf/floors/carpet.dmi'
	icon_state = "carpet"
	floor_tile = /obj/item/stack/tile/carpet
	broken_states = list("damaged")
	smooth = SMOOTH_TRUE
	canSmoothWith = null

/turf/open/floor/carpet/New()
	..()
	spawn(1)
		update_icon()

/turf/open/floor/carpet/update_icon()
	if(!..())
		return 0
	if(!broken && !burnt)
		if(smooth)
			queue_smooth(src)
	else
		make_plating()
		if(smooth)
			queue_smooth_neighbors(src)

/turf/open/floor/carpet/narsie_act()
	return

/turf/open/floor/carpet/break_tile()
	broken = 1
	update_icon()

/turf/open/floor/carpet/burn_tile()
	burnt = 1
	update_icon()

/turf/open/floor/carpet/carpetsymbol
	icon_state = "carpetsymbol"
	smooth = SMOOTH_FALSE

/turf/open/floor/carpet/carpetsymbol2
	icon_state = "carpetstar"
	smooth = SMOOTH_FALSE


/turf/open/floor/fakespace
	icon = 'icons/turf/space.dmi'
	icon_state = "0"
	floor_tile = /obj/item/stack/tile/fakespace
	broken_states = list("damaged")

/turf/open/floor/fakespace/New()
	..()
	icon_state = "[rand(0,25)]"