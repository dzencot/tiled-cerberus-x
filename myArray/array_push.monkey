Function IntArrayPush:Int[](_array:Int[], _value:Int)
  Local _length:Int = _array.Length()
  _array = _array.Resize(_length + 1)
  _array[_length] = _value
  Return _array
End

Function StringArrayPush:String[](_array:String[], _value:String)
  Local _length:Int = _array.Length()
  _array = _array.Resize(_length + 1)
  _array[_length] = _value
  Return _array
End
