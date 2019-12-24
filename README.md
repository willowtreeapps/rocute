# rocute
beautiful ui components for roku development

## About
rocute is an open source component library to aid developers in creating beautiful roku apps in a 
timely manner. Our libary includes styled components, animations, and screensavers ready for easy 
out of the box implementation.

## Example and Setup
### Example
```xml
<!-- The SceneGraph component you are working in -->
<?xml version="1.0" encoding="utf-8" ?>
<component name="BounceEffectExampleComponent" extends="Panel" >
  <script type="text/brightscript" uri="pkg:/components/examples/BounceEffectExample/BounceEffectExample.brs"/>
  <children>
    <!-- Implementation of our component -->
    <BounceEffect id="BounceEffectExample" imageUri="pkg:/images/test.png" startPoint="[250, 250]" maxHeight="100" bounceType="descending" totalBounces="3" duration="2" repeat="false" />
  </children>
</component>
```
### Setup
#### To utilize a component:
 - Navigate to `./src/main/components` in the rocute directory.
 - Dependent on if you want a general styled component, or an animation, or a video-overlay, select either the `styled-components`, or `animations`, or `video-overlays` directory.
 - Copy the directory of the component you want into an appropriate place in your codebase.
 - For component specific documentation, refer to the ThatComponent.md file in the component's example directory.
#### For access to all components:
 - Copy the components directory out of `./src/main` into your project structure in an appropriate place.
 - Import any and all components into your project.
 - For component specific documentation, refer to the ThatComponent.md file in the component's example directory.
#### To run our app:
 - Install ukor: `npm install -g @willowtreeapps/ukor`.
 - Install [vscode.](https://code.visualstudio.com/)
 - Install [vscode brightscript.](https://marketplace.visualstudio.com/items?itemName=celsoaf.brightscript)
 - Open the root directory of our repo in vscode.
 - Modify `.vscode/launch.json` so the inputs resemble `"default": "0.0.0.0",` to your roku ip address, and `"default": "password",` to your roku password.
 - Click the debug tab in vscode.
 - Press the dropdown button next to the play button and select `Brightscript Debug: Launch`.
 - Press the play button next to the dropdown.


## Components

**ArchInterpolator -**
description

**BounceEffect -**
A customizable bounce which can be applied to any image.

**CardRotator -**
A card rotary which moves on the y axis.

**CardZoomDiagonal -**
An overlapping card rotator where cards slide from the top left to front center, and the cards
that will be shown sooner overlap the ones that will be shown later.

**CardZoomRotary -**
An overlapping card rotator where cards are visually pulled from the back to the front center.

**CircularImageClip -**
A circular border to be placed on images, which will stretch to oval bounds 
if proper heights and widths are provided.

**DatePicker -**
description

**DisappearingLogo -**
description

**DisappearingNav -**
description

**HorizontalCardRotator -**
A card rotary which moves on the x axis.

**LiveIcon -**
description

**NavBar -**
description

**Next -**
The 'Next' component is an stubbed out component for development. If you are interested in
contributing, this component is here to help. Instructions can be found in the NextExample
directory.

**RandomColoredFontList -**
RandomColoredFontList is a LabelList component that will randomly change the font color of the 
selected element.

**RandomColoredList -**
RandomColoredList is a LabelList component that will randomly change the color of the 
selected element.

**RatingIcon -**
description

**ResizeList -**
ResizeList is a LabelList component that will resize so the currently selected element 
takes up more space.

**Ticker -**
description

**TiledBackground -**
description

**TriangularCornerClip -**
TriangularCornerClip is a way to clip an image to fit into the bounds of a right triangle. 
In the event you want to clip the corner of a scene or image with another image, or want to
have an image shown as a right triangle programmatically, this component fits the use case.

**TriangularImageClip -**
TriangularImageClip is a way to clip an image to fit in a triangle. As opposed to 
TriangularCornerClip, this triangular clip component will stretch to your image and remain 
centric on the images center.

## Screensavers

**BouncingLogoScreensaver -**
A screensaver channel where a provided logo will expand and contract in the center of the screen.

**ExpandingLogoScreensaver -**
description

## Questions

## Contributing
