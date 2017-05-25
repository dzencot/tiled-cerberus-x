Strict
Import mojo
Import level

Function Main:Int()
  New Game()
  Return 0
End

Class Game Extends App
  Field level:Level

  Method OnCreate:Int()
    level = New Level("level.json")
    SetUpdateRate(30)
    Return 0
  End

  Method OnUpdate:Int()
    Return 0
  End

  Method OnRender:Int()
    Cls()
    level.Render()
    Return 0
  End

End