sub Log(section, output)
	print Substitute("{RSGC | {0}} ^1", section, output)
end sub

function LoadState() as Object
	state = {
		clock: 0,
		screen: invalid,
		font: invalid,

		general: {
			render_resolution_width: 1280,
			render_resolution_height: 720,
			opad: 15,
			ipad: 5
		}
	}

	registry = CreateObject("roRegistry")

	sections = registry.GetSectionList()
	Log("State", Substitute("Section count: ^0", sections.Count().ToStr()))

	
	' General section
	general_section = CreateObject("roRegistrySection", "General")

	'' General.render_resolution
	if general_section.Exists("render_resolution_width")
		state.general.render_resolution_width = Val(general_section.Read("render_resolution_width"), 10)
	else
		general_section.Write("render_resolution_width", Str(state.general.render_resolution_width))
	endif

	if general_section.Exists("render_resolution_height")
		state.general.render_resolution_height = Val(general_section.Read("render_resolution_height"), 10)
	else
		general_section.Write("render_resolution_height", Str(state.general.render_resolution_height))
	endif

	Log("State", Substitute("Render resolution: {0} x {1}", Str(state.general.render_resolution_width), Str(state.general.render_resolution_height)))

	'' General.opad
	if general_section.Exists("opad")
		state.general.opad = Val(general_section.Read("opad"), 10)
	else
		general_section.Write("opad", Str(state.general.opad))
	endif

	Log("State", Substitute("Outside padding: {0}", Str(state.general.opad)))

	'' General.ipad
	if general_section.Exists("ipad")
		state.general.ipad = Val(general_section.Read("ipad"), 10)
	else
		general_section.Write("ipad", Str(state.general.ipad))
	endif

	Log("State", Substitute("Inner padding: {0}", Str(state.general.ipad)))

	if general_section.Flush()
		Log("State", "General settings flushed?: true")
	else
		Log("State", "General settings flushed?: false")
	endif

	return state
end function