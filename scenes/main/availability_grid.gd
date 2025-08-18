class_name AvailabilityGrid
extends TileMapLayer

enum TILE_TYPE {
	CAN_BUILD,
	CANT_BUILD
}

const EMPTY_TILE_COORDS := Vector2i(-1, -1)

var tile_mapping: Dictionary[TILE_TYPE, Vector2] = {
	TILE_TYPE.CANT_BUILD: Vector2(0, 4),
	TILE_TYPE.CAN_BUILD: Vector2(1, 4),
}


func show_for(walls_grid: TileMapLayer) ->  void:
	var playable_area_rect := walls_grid.get_used_rect()
	var wall_positions := walls_grid.get_used_cells()

	for i in playable_area_rect.end.x:
		for j in playable_area_rect.end.y:
			var tile_pos := Vector2i(i, j)
			if walls_grid.get_cell_atlas_coords(tile_pos) != EMPTY_TILE_COORDS:
				continue
			var neighbours := get_surrounding_cells(tile_pos)
			var is_wall_nearby := false
			for neighbour in neighbours:
				if wall_positions.has(neighbour):
					is_wall_nearby = true
					break
			var tile_type = TILE_TYPE.CAN_BUILD if is_wall_nearby else TILE_TYPE.CANT_BUILD
			set_cell(tile_pos, 0, tile_mapping.get(tile_type))

	_calculate_tiles()
	show()


func _calculate_tiles() -> void:
	pass
	#	TODO finish
	#	set_cell(Vector2(4, 4), 0, tile_mapping.get(TILE_TYPE.CAN_BUILD))
