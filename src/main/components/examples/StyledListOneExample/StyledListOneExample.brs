sub init()
    ' Setup
    list = m.top.findNode("StyledListOneExample")
    m.top.list = list
    ' TODO: Generate a rowHeights list dynamically based off your content
    m.top.list.rowHeights = "[50, 50, 50, 50, 50, 50]"
    ' Call function on list scroll
    m.top.list.observeField("itemFocused", "focusControl")
end sub

sub focusControl()
    focused = m.top.list.itemFocused
    unfocused = m.top.list.itemUnfocused
    heights = m.top.list.rowHeights
    heights[focused] = 100
    heights[unfocused] = 50
    m.top.list.rowHeights = heights
end sub