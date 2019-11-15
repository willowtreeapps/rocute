sub init()
    m.top.vertFocusAnimationStyle = "floatingFocus"
    m.top.drawFocusFeedback = "true"
    m.top.rowHeights = "[50, 50, 50, 50, 50, 50]"
    m.top.observeField("itemFocused", "focusControl")
end sub

sub focusControl()
    focused = m.top.itemFocused
    unfocused = m.top.itemUnfocused
    heights = m.top.rowHeights
    heights[focused] = 100
    heights[unfocused] = 50
    m.top.rowHeights = heights
end sub