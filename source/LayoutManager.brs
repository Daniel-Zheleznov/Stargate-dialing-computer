' Layout Manager
function LayoutManagerP_CheckIfInside(side_info, slot)
    side = LCase(slot.preferred.side)
    if side = "left" or side = "right"
        return side_info.y + slot.preferred.height <= side_info.height
    elseif side = "top" or side = "bottom"
        return side_info.x + slot.preferred.width <= side_info.width
    endif
endfunction

function LayoutManagerP_SlotCommit(slot_id, x, y, width, height)
    breath = m.slots[slot_id].breath
    if breath <> invalid
        m.slots[slot_id].actual = {
            x: x + breath,
            y: y + breath,
            width: width - (breath * 2),
            height: height - (breath * 2)
        }
    else
        m.slots[slot_id].actual = {
            x: x,
            y: y,
            width: width,
            height: height
        }

        m.slots[slot_id].base = m.slots[slot_id].actual
    endif
endfunction

' LayoutManager.png
sub LayoutManager_Allocate(window_id, preferred)
    ' Does slots exist?
    if m.slots = invalid
        m.slots = {}
    endif

    slot = {
        side: "left",
        expand: true,
        height: 100,
        width: 100
    }
    
    if preferred <> invalid
        if preferred.side <> invalid
            slot.side = preferred.side
        endif

        if preferred.expand <> invalid
            slot.expand = preferred.expand
        endif

        if preferred.height <> invalid
            slot.height = preferred.height
        endif

        if preferred.width <> invalid
            slot.width = preferred.width
        endif
    endif

    m.slots[window_id] = {preferred: slot, actual: {}}
endsub

sub LayoutManager_Update()
    OUTSIDE_PADDING    = 10
    SCREEN_WIDTH       = 1280 - (2 * OUTSIDE_PADDING)
    SCREEN_HEIGHT      = 720  - (2 * OUTSIDE_PADDING)

    ' Left/Right sides only go up-down. ONLY CARES ABOUT HEIGHT
    left_side = {
        x: OUTSIDE_PADDING,
        y: OUTSIDE_PADDING,
        width: SCREEN_WIDTH / 5,
        height: SCREEN_HEIGHT,

        fixed_height: 0,
        expanders: []
    }

    right_side = {
        x: SCREEN_WIDTH - (SCREEN_WIDTH / 5) + OUTSIDE_PADDING, ' otherwise you get weird bug of like 40 px
        y: OUTSIDE_PADDING,
        width: SCREEN_WIDTH / 5,
        height: SCREEN_HEIGHT,

        fixed_height: 0,
        expanders: []
    }

    ' Top/Bottom sides only go side-to-side. ONLY CARES ABOUT WIDTH
    top_side = {
        x: OUTSIDE_PADDING + (SCREEN_WIDTH / 5),
        y: OUTSIDE_PADDING,
        width: 3 * (SCREEN_WIDTH / 5),
        height: SCREEN_HEIGHT / 5,

        fixed_width: 0,
        expanders: []
    }

    bottom_side = {
        x: OUTSIDE_PADDING + (SCREEN_WIDTH / 5),
        y: SCREEN_HEIGHT - (SCREEN_HEIGHT / 5) + OUTSIDE_PADDING,
        width: 3 * (SCREEN_WIDTH / 5),
        height: SCREEN_HEIGHT / 5,

        fixed_width: 0,
        expanders: []
    }

    ' Get the fixed sizes first
    for each slot_id in m.slots
        slot = m.slots[slot_id]
        side = LCase(slot.preferred.side)

        if side = "left"
            if slot.preferred.expand
                left_side.expanders.Push(slot_id)
            elseif LayoutManagerP_CheckIfInside(left_side, slot)
                left_side.fixed_height += slot.preferred.height
            endif
        elseif side = "right"
            if slot.preferred.expand
                right_side.expanders.Push(slot_id)
            elseif LayoutManagerP_CheckIfInside(right_side, slot)
                right_side.fixed_height += slot.preferred.height
            endif
        endif

        if side = "top"
            if slot.preferred.expand
                top_side.expanders.Push(slot_id)
            elseif LayoutManagerP_CheckIfInside(top_side, slot)
                top_side.fixed_width += slot.preferred.width
            endif
        elseif side = "bottom"
            if slot.preferred.expand
                bottom_side.expanders.Push(slot_id)
            elseif LayoutManagerP_CheckIfInside(bottom_side, slot)
                bottom_side.fixed_width += slot.preferred.width
            endif
        endif
    endfor

    ' Calculate avaiable size
    remaining_height_left_side = left_side.height - left_side.fixed_height
    used_expanded_left_side = 0
    expand_into_left_side = 0
    if left_side.expanders.Count() > 0 then expand_into_left_side = Int(remaining_height_left_side / left_side.expanders.Count())

    remaining_height_right_side = right_side.height - right_side.fixed_height
    used_expanded_right_side = 0
    expand_into_right_side = 0
    if right_side.expanders.Count() > 0 then expand_into_right_side = Int(remaining_height_right_side / right_side.expanders.Count())

    remaining_width_top_side = top_side.width - top_side.fixed_width
    used_expanded_top_side = 0
    expand_into_top_side = 0
    if top_side.expanders.Count() > 0 then expand_into_top_side = Int(remaining_width_top_side / top_side.expanders.Count())    

    remaining_width_bottom_side = bottom_side.width - bottom_side.fixed_width
    used_expanded_bottom_side = 0
    expand_into_bottom_side = 0
    if bottom_side.expanders.Count() > 0 then expand_into_bottom_side = Int(remaining_width_bottom_side / bottom_side.expanders.Count())    

    ' Provide positions
    for each slot_id in m.slots
        slot = m.slots[slot_id]
        side = LCase(slot.preferred.side)
        
        if side = "left"
            if slot.preferred.expand
                used_expanded_left_side += 1

                height = expand_into_left_side
                if used_expanded_left_side = left_side.expanders.Count()
                    height = remaining_height_left_side - (expand_into_left_side * ( left_side.expanders.Count() - 1 ))
                endif

                LayoutManagerP_SlotCommit(slot_id, left_side.x, left_side.y, left_side.width, height)
                left_side.y += height
            else
                LayoutManagerP_SlotCommit(slot_id, left_side.x, left_side.y, left_side.width, slot.preferred.height)
                left_side.y += slot.preferred.height
            endif            
        elseif side = "right"
            if slot.preferred.expand
                used_expanded_right_side += 1

                height = expand_into_right_side
                if used_expanded_right_side = right_side.expanders.Count()
                    height = remaining_height_right_side - (expand_into_right_side * ( right_side.expanders.Count() - 1 ))
                endif

                LayoutManagerP_SlotCommit(slot_id, right_side.x, right_side.y, right_side.width, height)
                right_side.y += height
            else
                LayoutManagerP_SlotCommit(slot_id, right_side.x,right_side.y, right_side.width, slot.preferred.height)
                right_side.y += slot.preferred.height
            endif   
        endif

        if side = "top"
            if slot.preferred.expand
                used_expanded_top_side += 1

                width = expand_into_top_side
                if used_expanded_top_side = top_side.expanders.Count()
                    width = remaining_width_top_side - (expand_into_top_side * ( top_side.expanders.Count() - 1 ))
                endif

                LayoutManagerP_SlotCommit(slot_id, top_side.x, top_side.y, width, top_side.height)
                top_side.x += width
            else
                LayoutManagerP_SlotCommit(slot_id, top_side.x, top_side.y, slot.preferred.width, top_side.height)
                right_side.x += slot.preferred.width
            endif 
        elseif side = "bottom"
            if slot.preferred.expand
                used_expanded_bottom_side += 1

                width = expand_into_bottom_side
                if used_expanded_bottom_side = bottom_side.expanders.Count()
                    width = remaining_width_bottom_side - (expand_into_bottom_side * ( bottom_side.expanders.Count() - 1 ))
                endif

                LayoutManagerP_SlotCommit(slot_id, bottom_side.x, bottom_side.y, width, bottom_side.height)
                bottom_side.x += width
            else
                LayoutManagerP_SlotCommit(slot_id, bottom_side.x, bottom_side.y, slot.preferred.width, bottom_side.height)
                bottom_side.x += slot.preferred.width
            endif 
        endif
    endfor
endsub

function LayoutManager_Get(slot_id)
    if m.slots[slot_id] = invalid
        return invalid
    endif

    return m.slots[slot_id]
endfunction

sub LayoutManager_Breathe()
    delta_time = GetDeltatime()
    frequency = 1/6
    DEG_TO_RAD = 2 * 3.14159

    for each slot_id in m.slots
        m.slot_phase += delta_time * frequency * DEG_TO_RAD

        raw = Sin(m.slot_phase)    ' -1.0 to  1.0
        breath = (raw + 1.0) / 0.5 '  0.0 to  3.0
        m.slots[slot_id].breath = breath

        LayoutManagerP_SlotCommit(slot_id, m.slots[slot_id].base.x, m.slots[slot_id].base.y, m.slots[slot_id].base.width, m.slots[slot_id].base.height)
    endfor
endsub
