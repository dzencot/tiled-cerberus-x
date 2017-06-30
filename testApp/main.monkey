Strict
Import mojo
Import level

Function Main:Int()
  New Game()
  Return 0
End Function

Class Game Extends App
  Field level:Level

  Method OnCreate:Int()
    SetUpdateRate(30)
    level = New Level()
    level.LoadLevel("level.json", DeviceWidth(), DeviceHeight())
    Return 0
  End Method

  Method OnUpdate:Int()
    level.Update()
    Return 0
  End Method

  Method OnRender:Int()
    Cls()
    level.Render()
    Return 0
  End Method

End Class
