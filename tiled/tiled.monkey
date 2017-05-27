Strict
Import brl.json
Import mojo.graphics

Import grid
Import myArray.array_push

Class Tiled

  Field test:String[] = New String[0]
  Field test2:Int

	Method New()
		widthMap = 0
		heightMap = 0
		widthTile = 0
		heightTile = 0
		tiles = New List<Tile>
		grid = New Grid
	End Method

  Method ParseJSON:Void(dataString:String)
    If dataString.Length() = 0
      Error("Data is empty")
      Return
    EndIf

    Local jsonObject:JsonObject = New JsonObject(dataString)

    Self.widthMap = jsonObject.GetInt("width")
    Self.heightMap = jsonObject.GetInt("height")
    Self.widthTile = jsonObject.GetInt("tilewidth")
    Self.heightTile = jsonObject.GetInt("tileheight")
	End Method

  Method AddTile:Void(idTile:Int)
    For Local tile:Tile = EachIn Self.tiles
      If tile.GetId() = idTile
        Error("Tile " + idTile + " already exsist")
        Return
      End If
    Next
    Local tile:Tile = New Tile(idTile)
    Self.tiles.AddLast(tile)
  End Method

  Method SetPropertieTile:Void(idTile:Int, namePropertie:String, valuePropertie:Int)
    Local tile:Tile = GetTile(idTile)
    tile.SetPropertie(namePropertie, valuePropertie)
  End Method

  Method GetPropertieTile:Int(idTile:Int, namePropertie:String)
    Local tile:Tile = GetTile(idTile)
    Return tile.GetPropertie(namePropertie)
	End Method
    
  Method GetWidthMap:Int()
    Return Self.widthMap
  End Method

  Method GetHeightMap:Int()
    Return Self.heightMap
  End Method

  Method GetWidthTile:Int()
    Return Self.widthTile
  End Method

  Method GetHeightTile:Int()
    Return Self.heightTile
  End Method

  Method GetCountLayers:Int()
    Return Self.grid.GetZ()
  End Method

  Method GetNameLayer:String(index:Int)
    Return Self.grid.GetNameLayer(index)
  End Method

  Private

  Method GetTile:Tile(idTile:Int)
    For Local tile:Tile = EachIn Self.tiles
      If tile.GetId() = idTile
        Return tile
      End If
    Next
    Error("Tile " + idTile + " not found")
    Return New Tile()
  End Method



	Field widthMap:Int
	Field heightMap:Int
	Field widthTile:Int
	Field heightTile:Int
	Field images:Image[]
	Field imagesFrames:Int[]
	Field tiles:List<Tile>
	Field grid:Grid

  Method GetTilesFromJson:List<Tile>(tileSets:JsonArray)

  End Method

End Class

Private

Class Tile

  Method New(_id:Int)
    Self.id = _id
    Self.properties = New List<Propertie>
  End Method

	Method SetPropertie:Void(_namePropertie:String, _value:Int)
    For Local propertie:Propertie = EachIn properties
      If propertie.GetNamePropertie() = _namePropertie
        Error("Propertie " + _namePropertie + " already exist in tile: " + Self.id)
        Return
      End If
    Next
    Local nextPropertie:Propertie = New Propertie(_namePropertie, _value)
    Self.properties.AddLast(nextPropertie)
	End Method

	Method GetPropertie:Int(_namePropertie:String)
    For Local propertie:Propertie = EachIn properties
      If propertie.GetNamePropertie() = _namePropertie
        Return propertie.GetValuePropertie()
      End If
    Next
    Error("Propertie " + _namePropertie + " not found in tile: " + Self.id)
		Return 0
	End Method

  Method GetId:Int()
    Return Self.id
  End Method

  Private

  Field id:Int
  Field properties:List<Propertie>

End Class

Class Propertie

  Field namePropertie:String
  Field valuePropertie:Int

  Method New(_namePropertie:String, _valuePropertie:Int)
    Self.namePropertie = _namePropertie
    Self.valuePropertie = _valuePropertie
  End Method

  Method GetValuePropertie:Int()
    Return Self.valuePropertie
  End Method

  Method GetNamePropertie:String()
    Return Self.namePropertie
  End Method

End Class
