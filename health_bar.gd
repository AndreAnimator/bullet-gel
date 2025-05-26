extends CanvasLayer

func _on_node_2d_hp_changed(new_hp):
    $HealthBar.value = new_hp * 100/3

