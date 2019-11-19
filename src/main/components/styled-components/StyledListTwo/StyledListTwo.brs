sub init()
    m.top.observeField("itemFocused", "colorRand")
end sub

sub colorRand(event as object)
    colorArray = m.top.colors
    colorArrayLength = colorArray.count()
    color = colorArray[Rnd(colorArrayLength) - 1]
    m.top.focusBitmapBlendColor = color
end sub