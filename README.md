## Introduction

[Tiled](https://thorbjorn.itch.io/tiled) is a simpliest map editor

This is the module for [Cerberus-X](https://www.cerberus-x.com/) for using exported maps from Tiled

## Requirements

* [Cerberus-X](https://www.cerberus-x.com/cxDocs/Tutorials_Getting%20started.html)

This module requires Cerberus-X modules (mojo and brl)

## Installation

Clone this repo in your directory Cerberus-X modules_ext

```sh
git clone https://github.com/dzencot/tiled-cerberus-x.git ${CERBERUSDIR}/modules_ext/tiled
```

## Usage

* Create the map in Tiled Editor
* Export map to json

#### Map

`Local tiled = new Tiled()`

---

`tiled.ParseJSON(dataLevel:string)`

* `dataLevel:string` - json-file content

---

`tiled.GetWidthMap:Int():Int`

---

`GetHeightMap:Int()`

#### Tiles

`tiled.GetIdTile(x:Int, y:Int, nameLayer:String):Int`

* `x:Int` - x-coordinate
* `y:Int` - y-coordinate
* `nameLayer:String` - layer


`GetWidthTile:Int():Int`

---

`GetHeightTile:Int():Int`

---

`GetCountLayers:Int():Int`

---

`GetNameLayer:String(index:Int):String`

---

`SetIdTile:Void(x:Int, y:Int, nameLayer:String, idTile:Int)`

---

`RenderTile:Void(idTile:Int, coorX:Int, coorY:Int)`

## Example

```
Strict

Import tiled
Import mojo
Import myArray.array_push

Class Level Extends Tiled

  Field speed:Int = 5

  Method LoadLevel:Void(name:String, _cWidth:Int, _cHeight:Int)
    Local dataLevel:String = LoadString(name)
    Self.ParseJSON(dataLevel)
    Self.cWidth = _cWidth
    Self.cHeight = _cHeight
    Self.SetCamera()
    Self.SetWindowTiles()
    Self.mapWidthPx = Self.GetWidthMap() * Self.GetWidthTile()
    Self.mapHeightPx = Self.GetHeightMap() * Self.GetHeightTile()
  End Method

  Method Render:Void()
    For Local y:Int = Self.minimumTileYOnMap Until Self.maximumTileYOnMap
      For Local x:Int = Self.minimumTileXOnMap Until Self.maximumTileXOnMap
        Local idTile:Int = Self.GetIdTile(x, y, "background")
        Local drawCoorX:Int = x * Self.GetWidthTile()
        Local drawCoorY:Int = y * Self.GetHeightTile()
        Self.RenderTile(idTile, drawCoorX, drawCoorY)
      Next
    Next
  End Method

  Method Update:Void()
    If KeyDown(KEY_LEFT)
      If Self.coorXCamera > 0
        Self.coorXCamera -= Self.speed
        If Self.coorXCamera < 0 Self.coorXCamera = 0
      End If
    Else If KeyDown(KEY_RIGHT)
      If Self.coorXCamera < Self.mapWidthPx
        Self.coorXCamera += Self.speed
        If Self.coorXCamera > Self.mapWidthPx Self.coorXCamera = Self.mapWidthPx
      End If
    Else If KeyDown(KEY_UP)
      If Self.coorYCamera > 0
        Self.coorYCamera -= Self.speed
        If Self.coorYCamera < 0 Self.coorYCamera = 0
      End If
    Else If KeyDown(KEY_DOWN)
      If Self.coorYCamera < Self.mapHeightPx
        Self.coorYCamera += Self.speed
        If Self.coorYCamera > Self.mapHeightPx Self.coorYCamera = Self.mapHeightPx
      End If
    End If

  End Method

  Private

  Method SetCamera:Void()
    Self.coorXCamera = 0;
    Self.coorYCamera = 0;
  End Method

  Method SetWindowTiles:Void()
    Local tileCoorX:Int = Self.coorXCamera / Self.GetWidthTile()
    Local tileCoorY:Int = Self.coorYCamera / Self.GetHeightTile()
    Self.minimumTileXOnMap = Max(0, tileCoorX - 1)
    Self.maximumTileXOnMap = Min(Self.GetWidthMap(), tileCoorX + (Self.cWidth / Self.GetWidthTile()) + 1)
    Self.minimumTileYOnMap = Max(0, tileCoorY - 1)
    Self.maximumTileYOnMap = Min(Self.GetHeightMap(), tileCoorY + (Self.cHeight / Self.GetHeightTile()) + 1)
  End Method

  Field coorXCamera:Int
  Field coorYCamera:Int

  Field minimumTileXOnMap:Int
  Field maximumTileXOnMap:Int

  Field minimumTileYOnMap:Int
  Field maximumTileYOnMap:Int

  Field mapWidthPx:Int
  Field mapHeightPx:Int

  Field cWidth:Int
  Field cHeight:Int

  Method RenderAllLayers:Void()
  End Method

End Class
```
