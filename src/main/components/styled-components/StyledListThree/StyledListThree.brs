sub init()
    m.top.observeField("itemFocused", "colorRand")
end sub

sub colorRand()
    colorArray = m.top.colors
    colorArrayLength = colorArray.count()
    color = colorArray[Rnd(colorArrayLength) - 1]
    m.top.focusedColor = color
end sub