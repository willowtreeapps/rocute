# CircularImageClip

### Description
 A circular border to be placed on images, which will stretch to oval bounds if proper 
 heights and widths are provided.
To utilize this tool,
 - Ensure the CircularImageClip directory is in your code.
 - Provide a CircularImageClip component the required props.

### Usage
| Field | Type | Default | Options | Required | Access Permission | Description |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| id | string | none | any string | true | READ_WRITE | The id of the component. |
| imageUri | uri | none | any uri | true | READ_WRITE | The uri of an image. |
| height | int | 0 | any int | false | READ_WRITE | The height of the image |
| width | int | 0 | any int | false | READ_WRITE | The width of the image |
| translation | intarray | [0, 0] | any array of two ints | false | READ_WRITE | The location of the image on the screen. |