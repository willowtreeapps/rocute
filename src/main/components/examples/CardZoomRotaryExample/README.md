# CardZoomRotary

### Description
An overlapping card rotator where cards are visually pulled from the back to the front center.
To utilize this tool,
 - Include a CardZoomRotary component in your xml.
 - In BrightScript, assign focus as outlined under 'Initial Setup & Focus Control' in the CardZoomRotaryExample.brs file.
 - In the same BrightScript file, dynamically generate a ContentNode containing relevant content, which may include title, SDPosterUrl, textColor, rectColor and textCords.
    - title: string, the title string to display on the card.
    - SDPosterUrl: uri, the image to display on the card.
    - textColor: color hex string, the color of the title text.
    - rectColor: color hex string, the color of the rectangle.
    - textCords: translation int array, the location of the title on the card.
 - In the same BrightScript file, create and assign dimensions to the three rectangle spots on the screen. This is to be done in a TargetSet object on the targetRects property.
 - Assign the TargetSet and ContentNode onto the CardZoomRotary.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |