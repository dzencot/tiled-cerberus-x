Strict

Import tiled
Import mojo.app
Import myArray.array_push

Class Level Extends Tiled

  Method LoadLevel:Void(name:String)
    dataLevel = LoadString(name)
    Self.ParseJSON(dataLevel);
  End Method

  Method Render:Void()
    For Local y:Int = 0 Until Self.GetHeightMap()
      For Local x:Int = 0 Until Self.GetWidthMap()
        Local idTile:Int = Self.GetIdTile(x, y, "background")
        Local drawCoorX:Int = x * Self.GetWidthTile()
        Local drawCoorY:Int = y * Self.GetHeightTile()
        Self.RenderTile(idTile, drawCoorX, drawCoorY)
      Next
    Next
  End Method

  Private

  Method RenderAllLayers:Void()
  End Method

  Private

  Field dataLevel:String

End Class

