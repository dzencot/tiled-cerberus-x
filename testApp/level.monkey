Strict

Import tiled
Import mojo.app

Class Level Extends Tiled

  Field dataLevel:String

  Method New(name:String)
    dataLevel = LoadString(name)
    Self.LoadJSON(dataLevel);
    Local _tileWidth:Int = Self.GetTileWidth()
    Local _tileHeight:Int = Self.GetTileHeight()
    Self.displayWidthTiles = DeviceWidth() / _tileWidth
    Self.displayHeightTiles = DeviceHeight() / _tileHeight
  End

  Method Render:Void()
    'DrawText(test, 0, 0)
    RenderAllLayers()
    'DrawText(images.Length(), 0, 0)
  End

  Private

  Method RenderAllLayers:Void()
    For Local y:Int = 0 Until grid.GetY()
      For Local x:Int = 0 Until grid.GetX()
        Local drawCoorX:Int = x * tileWidth
        Local drawCoorY:Int = y * tileHeight
        Local nameLayer:String = grid.GetNameLayer(0)
        Local value:Int = GetValue(x, y, nameLayer)
        Local image:Image = GetFrame(x, y, nameLayer)
        DrawImage(image, drawCoorX, drawCoorY)
        DrawText(value, drawCoorX, drawCoorY)
      Next
    Next
  End

  Field cameraCoorX:Int
  Field cameraCoorY:Int

  Field displayWidthTiles:Int
  Field displayHeightTiles:Int

End Class

