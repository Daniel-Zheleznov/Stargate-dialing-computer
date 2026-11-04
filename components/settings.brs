function onKeyEvent(key, press) as Boolean
    ' Documentation: https://developer.roku.com/docs/references/scenegraph/component-functions/onkeyevent.md

    root = m.top.findNode("root")
    ' On press
    if press = true then
        if key = "back" then
            return false
        elseif key = "right" or key = "OK" then
            if root.findNode("sectionListLabel").hasFocus() = true then
                root.findNode("sectionInfoLabel").setFocus(true)
                root.findNode("sectionListAnimationOut").control = "start"
            elseif root.findNode("sectionInfoLabel").hasFocus() = true then
                root.findNode("sectionDetailsLabel").setFocus(true)
            endif
        elseif key = "left" then
            if root.findNode("sectionDetailsLabel").hasFocus() = true then
                root.findNode("sectionInfoLabel").setFocus(true)
            elseif root.findNode("sectionInfoLabel").hasFocus() = true then
                root.findNode("sectionListLabel").setFocus(true)
                root.findNode("sectionListAnimationIn").control = "start"
            endif    
        endif
    endif

    return true
endfunction

function onStateChange_sectionListAnimationOut(value)
    print "SectionList out"
    value = value.getData()
    if value = "running" then
        m.top.findNode("sectionInfoAnimationOut").control = "start"
        m.top.findNode("sectionDetailsAnimationOut").control = "start"
    endif
endfunction

function onStateChange_sectionListAnimationIn(value)
    print "SectionList in"

    value = value.getData()
    if value = "running" then
        m.top.findNode("sectionInfoAnimationIn").control = "start"
        m.top.findNode("sectionDetailsAnimationIn").control = "start"
    endif
endfunction

function onFocused_sectionList(value)
    item = value.getData()
    print "SectionList focused: " + str(item)

    ' Remove all children
    sectionInfoContent = m.top.findNode("sectionInfoContent")
    sectionInfoContent.removeChildrenIndex(sectionInfoContent.getChildCount(), 0)

    if item = 0 then
        fadeInterval = sectionInfoContent.createChild("ContentNode")
        fadeInterval.title = "Interval"
        fadeInterval.description = "The time it takes until the screensaver fades in/out."

        fadeLength = sectionInfoContent.createChild("ContentNode")
        fadeLength.title = "Length"
        fadeLength.description = "The time it takes for the screensaver to fade in/out."
    elseif item = 1 then
        sgcStatic = sectionInfoContent.createChild("ContentNode")
        sgcStatic.title = "Static"
        sgcStatic.description = "Should the SGC RSGC_Logo move?"

        sgcRotate = sectionInfoContent.createChild("ContentNode")
        sgcRotate.title = "Rotate"
        sgcRotate.description = "Should the SGC RSGC_Logo rotate?"
    elseif item = 2 then
        consoleInterval = sectionInfoContent.createChild("ContentNode")
        consoleInterval.title = "Interval"
        consoleInterval.description = "The time it takes for the console to output a program."
    elseif item = 3 then
        generalOuterMargin = sectionInfoContent.createChild("ContentNode")
        generalOuterMargin.title = "Outer margin"
        generalOuterMargin.description = "The amount of pixels between the widgets and the edges of the screen."

        generalInnerMargin = sectionInfoContent.createChild("ContentNode")
        generalInnerMargin.title = "Inner margin"
        generalInnerMargin.description = "The amount of pixels between the widgets."
    endif
endfunction

function onFocused_sectionInfo(value)
	sectionList_item = m.top.findNode("sectionListLabel").itemFocused

    item = value.getData()
    print "SectionInfo focused: " + str(item)

    ' Remove all children
    sectionDetailsContent = m.top.findNode("sectionDetailsContent")
    sectionDetailsContent.removeChildrenIndex(sectionDetailsContent.getChildCount(), 0)

    if sectionList_item = 0 then
		if item = 0 then
			' fade1min = sectionDetailsContent.createChild("ContentNode")
			' fade1min.title = "1 minute"
        
			fade5min = sectionDetailsContent.createChild("ContentNode")
			fade5min.title = "5 minutes"
        
			fade10min = sectionDetailsContent.createChild("ContentNode")
			fade10min.title = "10 minutes"
        
			' fade15min = sectionDetailsContent.createChild("ContentNode")
			' fade15min.title = "15 minutes"
        
			fade20min = sectionDetailsContent.createChild("ContentNode")
			fade20min.title = "20 minutes"
        
			' fade25min = sectionDetailsContent.createChild("ContentNode")
			' fade25min.title = "25 minutes"
        
			fade30min = sectionDetailsContent.createChild("ContentNode")
			fade30min.title = "30 minutes"
        
			fadeNever = sectionDetailsContent.createChild("ContentNode")
			fadeNever.title = "Never"
		elseif item = 1 then
			times = [5, 10, 15, 20, 25, 30]
			for each time in times
				child = sectionDetailsContent.createChild("ContentNode")
				child.title = str(time) + " seconds"
			endfor
		endif
    elseif sectionList_item = 1 then
		if item = 0 then
			truecontnet = sectionDetailsContent.createChild("ContentNode")
			truecontnet.title = "True"

			falsecontnet = sectionDetailsContent.createChild("ContentNode")
			falsecontnet.title = "False"
		elseif item = 1 then
			truecontnet = sectionDetailsContent.createChild("ContentNode")
			truecontnet.title = "True"

			falsecontnet = sectionDetailsContent.createChild("ContentNode")
			falsecontnet.title = "False"
		endif
    elseif sectionList_item = 2 then
		if item = 0 then
			times = [5, 10, 15, 20, 30]
			for each time in times
				child = sectionDetailsContent.createChild("ContentNode")
				child.title = str(time) + " seconds"
			endfor
		endif
	elseif sectionList_item = 3 then
		if item = 0 then
			times = [5, 10, 20]
			for each time in times
				child = sectionDetailsContent.createChild("ContentNode")
				child.title = str(time) + " pixels"
			endfor
		elseif item = 1 then
			times = [5, 10, 20]
			for each time in times
				child = sectionDetailsContent.createChild("ContentNode")
				child.title = str(time) + " pixels"
			endfor
		endif
	endif
endfunction