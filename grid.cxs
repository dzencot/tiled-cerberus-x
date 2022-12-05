Strict

Class Grid

  Field test:String

	Method New(a:Int, b:Int, c:Int)
		Self.x = a
		Self.y = b
		Self.z = c
		Self.cells = New Int[a][][]
		For Local i:int = 0 Until a
			Self.cells[i] = New Int[b][]
			For Local j:Int = 0 Until b
				Self.cells[i][j] = New Int[c]
			Next
		Next
	End

	Method AddLayer:Void(layer:String)
		For Local i:Int = 0 Until Self.layers.Length()
			If Self.layers[i] = layer Return
		Next
		Self.layers = Self.layers.Resize(Self.layers.Length() +1)
		Self.layers[Self.layers.Length() -1] = layer
	End

	Method GetNameLayer:String(index:Int)
		If index >= 0 And index < Self.layers.Length()
			Return Self.layers[index]
		EndIf
		Return ""
	End

	Method SetValue:Void(a:Int, b:Int, layer:String, value:Int)
		If a >= 0 And a <= Self.x And b >= 0 And b <= Self.y
			For Local j:Int = 0 Until Self.layers.Length()
				If Self.layers[j] = layer
          Self.cells[a][b][j] = value
          Return
        EndIf
			Next
      AddLayer(layer)
			Self.cells[a][b][Self.GetZ() -1] = value
		EndIf
	End

	Method GetValue:Int(a:Int, b:Int, layer:String)
		For Local i:Int = 0 Until Self.layers.Length()
			If Self.layers[i] = layer And a >= 0 And a <= Self.x - 1 And b >= 0 And b <= Self.y - 1 Then
				Return Self.cells[a][b][i]
			EndIf
		Next
		Return 0
	End

	Method Copy:Void(_fromX:Int, _fromY:Int, _toX:Int, _toY:Int)
		If _fromX >= 0 And _fromX <= Self.x And _fromY >= 0 And _fromY <= Self.y And _toX >= 0 And _toX <= Self.x And _toY >= 0 And _toY <= Self.y
			For Local i:Int = 0 Until Self.z
				Self.cells[_toX][_toY][i] = Self.cells[_fromX][_fromY][i]
			Next
		EndIf
	End

	Method GetX:Int()
		Return Self.x
	End

	Method GetY:Int()
		Return Self.y
	End

	Method GetZ:Int()
		Return Self.z
	End


	Field cells:Int[][][]
	Field x:Int, y:Int, z:Int
	Field layers:String[]

End Class
