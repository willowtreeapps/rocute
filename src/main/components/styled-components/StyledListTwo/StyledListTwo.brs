sub init()
    m.top.observeField("itemFocused", "colorRand")
    m.top.content = m.top.listContents
end sub

sub colorRand()
    colorArray = m.top.colors
    colorArrayLength = colorArray.count()
    color = colorArray[Rnd(colorArrayLength) - 1]
    m.top.focusBitmapBlendColor = color
end sub

sub updateContents()
    m.top.content = m.top.listContents
end sub