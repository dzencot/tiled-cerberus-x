Strict

Import tiled
Import mojo.app
Import myArray.array_push

Class Level Extends Tiled

  Method LoadLevel:Void(name:String)
    dataLevel = LoadString(name)
    Self.ParseJSON(dataLevel);
    AddTile(1)
    AddTile(2)
    SetPropertieTile(1, "background", 3)
    SetPropertieTile(1, "background", 2)
  End Method

  Method Render:Void()
    Local test:Int = GetPropertieTile(1, "background")
    DrawText("propertie:" + test, 0, 0)
  End Method

  Private

  Method RenderAllLayers:Void()
  End Method

  Private

  Field dataLevel:String

End Class

