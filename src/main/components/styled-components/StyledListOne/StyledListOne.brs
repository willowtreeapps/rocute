sub init()
    m.top.vertFocusAnimationStyle = "floatingFocus"
    m.top.drawFocusFeedback = "true"
    m.top.observeField("itemFocused", "focusControl")
end sub

sub focusControl()
    focused = m.top.itemFocused
    unfocused = m.top.itemUnfocused
    heights = m.top.rowHeights
    heights[focused] = m.top.expandedHeight
    heights[unfocused] = 50
    m.top.rowHeights = heights
end sub

sub updateContents()
    contentsLength = m.top.listContents.count()
    generateRowHeights = []
    for incrementVal = 0 to contentsLength
        generateRowHeights.Push(50)
    end for
    m.top.rowHeights = generateRowHeights
    m.top.content = m.top.listContents
end sub