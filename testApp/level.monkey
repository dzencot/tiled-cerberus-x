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
    DrawText("hi " + testGrid.GetX() + " " + testGrid.GetY() + " " + testGrid.GetZ(), 0, 0)
    Local idTile:Int = GetIdTile(0, 0, "background")
    DrawText("idTile x=0 y=0 background : " + idTile, 0, 10)
    DrawText("tileProperties collision: " + GetPropertieTile(idTile, "collision"), 0, 20)
  End Method

  Private

  Method RenderAllLayers:Void()
  End Method

  Private

  Field dataLevel:String

End Class

