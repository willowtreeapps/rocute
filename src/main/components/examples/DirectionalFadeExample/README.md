# DirectionalFade

### Description
 Privide a fade effect onto any edge of a provided picture.
 To utilize this tool,
 - Ensure the DirectionalFade directory is in your code.
 - Provide a DirectionalFade component the required props.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |
| height | int | 0 | any int | true | READ_WRITE | The height of the image. |
| width | int | 0 | any int | true | READ_WRITE | The width of the image. |
| translation | intarray | [0, 0] | any array of two ints | false | READ_WRITE | The translation of the component. |
| fadedSide | string | "bottom" | "top" "right" "bottom" "left" | false | READ_WRITE | The side of the component to be faded. |
| offset | int | 0 | any int | false | READ_WRITE | Offset for mask, to be modified for a greater or lesser fade. |
| imageUri | uri | none | any uri path | true | READ_WRITE | The path to the image you want to fade. |