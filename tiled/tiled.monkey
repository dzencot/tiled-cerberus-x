Strict
Import brl.json
Import mojo.graphics

Import grid

Class Tiled

  Field test:Int

	Method New()
		widthMap = 0
		heightMap = 0
		tileWidth = 0
		tileHeight = 0
		tiles = New List<Tile>
		grid = New Grid
	End

	Method LoadJSON:Void(dataMapString:String)
		If dataMapString.Length() = 0 Return
		Local js:= New JsonObject(dataMapString)
		Self.widthMap = js.GetInt("width")
		Self.heightMap = js.GetInt("height")
		Self.tileWidth = js.GetInt("tilewidth")
		Self.tileHeight = js.GetInt("tileheight")
		Local allFrameCount:Int = 0
		Local tilesets:= JsonArray(JsonObject(js).Get("tilesets"))
		Local indexTile:Int = 0
		For Local i:Int = 0 Until tilesets.Length()
			Local d:= JsonObject(tilesets.Get(i))
      If (Self.tileWidth = 0 Or Self.tileHeight = 0)
        Local message:String = "tileWidth and tileHeight must be not zero: " + Self.tileWidth + " " + Self.tileHeight
        Print(message)
        Error(message)
      EndIf
			Local countFrame:Int = d.GetInt("imagewidth") * d.GetInt("imageheight") / (Self.tileWidth * Self.tileHeight)
			allFrameCount += countFrame
			Local pathImage:String = d.GetString("image")
			pathImage = pathImage.Replace("/", "")
			pathImage = pathImage.Replace("..", "")
			Self.images = Self.images.Resize(images.Length() +1)
			Self.images[i] = LoadImage(pathImage, tileWidth, tileHeight, countFrame)
			Self.imagesFrames = Self.imagesFrames.Resize(imagesFrames.Length() +1)
			Self.imagesFrames[i] = countFrame
			Local tileProperties:= JsonObject(d.Get("tileproperties"))
			If tileProperties Then
				For Local js1:= EachIn tileProperties.GetData()
					Local newTile:= New Tile
					Local key:= js1.Key
					newTile.id = Int(key) + indexTile + 1
					Local jsNV:= JsonObject(js1.Value())
					For Local newJS:= EachIn jsNV.GetData()
						Local nameParJS:String = newJS.Key
						Local valueParJS:Int = Int(jsNV.GetString(nameParJS))
						newTile.AddParametr(nameParJS, valueParJS)
					Next
					tiles.AddLast(newTile)
				Next
			EndIf
			indexTile += countFrame
		Next
		Local dataLayers:= JsonArray(JsonObject(js).Get("layers"))
		Self.grid.Create(widthMap, widthMap, dataLayers.Length())
		For Local i:Int = 0 Until dataLayers.Length()
			Local d:= JsonObject(dataLayers.Get(i))
			Local name:String = d.GetString("name")
			Local dataMap:= JsonArray(d.Get("data"))
			Self.grid.AddLayer(name)
			Local _i:Int = 0
			For Local y:Int = 0 Until Self.heightMap
				For Local x:Int = 0 Until Self.widthMap
					Local value:Int = dataMap.GetInt(_i)
					Self.grid.SetValue(x, y, name, value)
					_i += 1
				Next
			Next
		Next
	End

	Method GetValue:Int(x:Int, y:Int, layer:String)
		Return Self.grid.GetValue(x, y, layer)
	End

	Method GetFrame:Image(x:Int, y:Int, layer:String)
		Local value:Int = Self.grid.GetValue(x, y, layer)
		For Local i:Int = 0 Until Self.images.Length()
			If value > Self.imagesFrames[i]
				value = value - Self.imagesFrames[i]
			Else
				Return Self.images[i-1].GrabImage(0, 0, tileWidth, tileHeight, value)
			EndIf
		Next
    Error("Image not found")
    Return New Image
	End

	Method GetTileParametr:Int(id:Int, parametr:String)
		For Local i:Int = 0 Until Self.tiles.Count()
			If i = id
				For Local j:Int = 0 Until Self.tiles.parametrs.Length()
					If Self.tiles.parametrs[j] = parametr
						Return Self.tiles.parametrs_value[j]
					EndIf
				Next
			EndIf
		Next
	End

  Method GetWidth:Int()
    Return Self.widthMap
  End

  Method GetHeight:Int()
    Return Self.heightMap
  End

  Method GetTileWidth:Int()
    Return Self.tileWidth
  End

  Method GetTileHeight:Int()
    Return Self.tileHeight
  End

  Method GetCountLayers:Int()
    Return Self.grid.GetZ()
  End

  Method GetNameLayer:String(index:Int)
    Return Self.grid.GetNameLayer(index)
  End


	Field widthMap:Int
	Field heightMap:Int
	Field tileWidth:Int
	Field tileHeight:Int
	Field images:Image[]
	Field imagesFrames:Int[]
	Field tiles:List<Tile>
	Field grid:Grid

End

Private

Class Tile
	Field id:Int
	Field parametrs:String[]
	Field parametrs_value:Int[]

	Method AddParametr:Void(_parametr:String, _value:Int)
		For Local i:Int = 0 Until parametrs.Length()
			If parametrs[i] = _parametr Then
				parametrs_value[i] = _value
				Return
			EndIf
		Next
		parametrs = parametrs.Resize(parametrs.Length() +1)
		parametrs[parametrs.Length() -1] = _parametr
		parametrs_value = parametrs_value.Resize(parametrs_value.Length() +1)
		parametrs_value[parametrs_value.Length() -1] = _value
		Return
	End

	Method GetParametr:Int(_parametr:String)
		For Local i:Int = 0 Until parametrs.Length()
			If _parametr = parametrs[i] Then
				Return parametrs_value[i]
			EndIf
		Next
		Return 0
	End
End
