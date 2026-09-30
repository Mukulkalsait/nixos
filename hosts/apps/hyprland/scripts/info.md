
```json 
// Y: floating_window  => while right screen

❯ hyprctl clients -j | jq '.[] | select(.class=="floating_window")'
{
  "address": "0x5790f5a269a0",
  "mapped": true,
  "hidden": false,
  "visible": true,
  "acceptsInput": true,
  "at": [
    960,
    660
  ],
  "size": [
    940,
    528
  ],
  "workspace": {
    "address": "2",
    "id": 2,
    "type": "normal",
    "name": "2"
  },
  "floating": true,
  "monitor": 0,
  "class": "floating_window",
  "title": "Floating Window ☠️",
  "initialClass": "floating_window",
  "initialTitle": "Floating Window ☠️",
  "pid": 144574,
  "xwayland": false,
  "pinned": false,
  "pinFullscreened": false,
  "fullscreen": 0,
  "fullscreenClient": 0,
  "fullscreenHandler": "default",
  "allowedOverFullscreen": true,
  "grouped": [],
  "tags": [],
  "swallowing": "0x0",
  "focusHistoryID": 1,
  "inhibitingIdle": false,
  "xdgTag": "",
  "xdgDescription": "",
  "contentType": "none",
  "tearingHint": false,
  "stableId": "1800001a"
}

// Y: wiremix => while full screen

❯ hyprctl clients -j | jq '.[] | select(.class=="wiremix")'
{
  "address": "0x5790f5b7d050",
  "mapped": true,
  "hidden": false,
  "visible": true,
  "acceptsInput": true,
  "at": [
    2,
    2
  ],
  "size": [
    1916,
    1196
  ],
  "workspace": {
    "address": "3",
    "id": 3,
    "type": "normal",
    "name": "3"
  },
  "floating": true,
  "monitor": 0,
  "class": "wiremix",
  "title": "WireMix-Audio 📢",
  "initialClass": "wiremix",
  "initialTitle": "WireMix-Audio 📢",
  "pid": 150267,
  "xwayland": false,
  "pinned": false,
  "pinFullscreened": false,
  "fullscreen": 1,
  "fullscreenClient": 1,
  "fullscreenHandler": "default",
  "allowedOverFullscreen": true,
  "grouped": [],
  "tags": [],
  "swallowing": "0x0",
  "focusHistoryID": 3,
  "inhibitingIdle": false,
  "xdgTag": "",
  "xdgDescription": "",
  "contentType": "none",
  "tearingHint": false,
  "stableId": "1800001b"
}



```


















