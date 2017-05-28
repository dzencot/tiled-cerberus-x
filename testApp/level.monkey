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
    DrawText("layers = " + test2, 0, 0)
  End Method

  Private

  Method RenderAllLayers:Void()
  End Method

  Private

  Field dataLevel:String

End Class

