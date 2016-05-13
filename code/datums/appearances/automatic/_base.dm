/decl/appearance_handler
	var/list/appearance_sources

/decl/appearance_handler/New()
	..()
	appearance_sources = list()

/decl/appearance_handler/proc/AddAltAppearance(var/source, var/list/images, var/list/viewers = list())
	if(source in appearance_sources)
		return FALSE
	appearance_sources[source] = new/datum/appearance_data(images, viewers)
	destroyed_event.register(source, src, /decl/appearance_handler/proc/RemoveAltAppearance)

/decl/appearance_handler/proc/RemoveAltAppearance(var/source)
	var/datum/appearance_data/ad = appearance_sources[source]
	if(ad)
		destroyed_event.unregister(source, src)
		appearance_sources -= source
		qdel(ad)

/decl/appearance_handler/proc/DisplayAltAppearanceTo(var/source, var/viewer)
	var/datum/appearance_data/ad = appearance_sources[source]
	if(ad)
		ad.AddViewer(viewer)

/decl/appearance_handler/proc/DisplayAllAltAppearancesTo(var/viewer)
	for(var/entry in appearance_sources)
		DisplayAltAppearanceTo(entry, viewer)