extends Control

# Gameboy Node
export (NodePath) var gameboy_path
onready var gameboy = get_node(gameboy_path)

# 4 Colors TextureFrame
export (NodePath) var four_colors_path
onready var four_colors = get_node(four_colors_path)

# Gameboy Grid TextureFrame
export (NodePath) var gameboy_grid_path
onready var gameboy_grid = get_node(gameboy_grid_path)

# 4 Colors Checkbox
export (NodePath) var four_colors_checkbox_path
onready var four_colors_checkbox = get_node(four_colors_checkbox_path)

# Grid CheckBox
export (NodePath) var grid_checkbox_path
onready var grid_checkbox = get_node(grid_checkbox_path)

# 4 Colors Slider
export (NodePath) var four_colors_slider_path
onready var four_colors_slider = get_node(four_colors_slider_path)

# Grid Slider
export (NodePath) var grid_slider_path
onready var grid_slider = get_node(grid_slider_path)

# Color Picker 1
export (NodePath) var color_picker_1_path
onready var color_picker_1 = get_node(color_picker_1_path)

# Color Picker 2
export (NodePath) var color_picker_2_path
onready var color_picker_2 = get_node(color_picker_2_path)

# Color Picker 3
export (NodePath) var color_picker_3_path
onready var color_picker_3 = get_node(color_picker_3_path)

# Color Picker 4
export (NodePath) var color_picker_4_path
onready var color_picker_4 = get_node(color_picker_4_path)

# Gameboy Border TextureFrame
export (NodePath) var gameboy_border_path
onready var gameboy_border = get_node(gameboy_border_path)

# Gameboy Border Color Picker
export (NodePath) var gameboy_border_color_picker_path
onready var gameboy_border_color_picker = get_node(gameboy_border_color_picker_path)

# Info Box Node2D
export (NodePath) var info_box_path
onready var info_box = get_node(info_box_path)

# Info TextureButton
export (NodePath) var info_button_path
onready var info_button = get_node(info_button_path)

# Info Text Edit
export (NodePath) var info_text_edit_path
onready var info_text_edit = get_node(info_text_edit_path)

# Copy LinkButton
export (NodePath) var copy_link_button_path
onready var copy_link_button = get_node(copy_link_button_path)

# Visibility TextureButton
export (NodePath) var visibility_button_path
onready var visibility_button = get_node(visibility_button_path)


# Start
func _ready():
	# Setup connections
	setup_connections()
	
	# Update Gameboy Grid checkbox & Brightness
	grid_checkbox.set_pressed(false) if (gameboy_grid.is_hidden()) else grid_checkbox.set_pressed(true)
	grid_slider.set_value(gameboy_grid.get_material().get_shader_param("brightness"))
	
	# Update 4 Colors checkbox & Offset
	four_colors_checkbox.set_pressed(false) if (four_colors.is_hidden()) else four_colors_checkbox.set_pressed(true)
	four_colors_slider.set_value(four_colors.get_material().get_shader_param("offset"))
	
	# Get current colors and set them to the color pickers
	var material = four_colors.get_material()
	color_picker_1.set_color(material.get_shader_param("color_1"))
	color_picker_2.set_color(material.get_shader_param("color_2"))
	color_picker_3.set_color(material.get_shader_param("color_3"))
	color_picker_4.set_color(material.get_shader_param("color_4"))
	gameboy_border_color_picker.set_color(gameboy_border.get_modulate())
	# Update border according to the last color - brightest color
	gameboy_border.set_modulate(material.get_shader_param("color_4"))


# Setup the connections for the menu elements
func setup_connections():
	# Grid Checkbox
	grid_checkbox.connect("toggled", self, "_on_grid_toggled")
	
	# Grid Brightness Slider
	grid_slider.connect("value_changed", self, "_on_brightness_value_changed" )
	
	# 4 Colors Checkbox
	four_colors_checkbox.connect("toggled", self, "_on_4_colors_toggled")
	
	# 4 Colors Offset Slider
	four_colors_slider.connect("value_changed", self, "_on_offset_value_changed" )
	
	# Slider for Color 1
	color_picker_1.connect("color_changed", self, "_on_color_1_changed")
	
	# Slider for Color 2
	color_picker_2.connect("color_changed", self, "_on_color_2_changed")
	
	# Slider for Color 3
	color_picker_3.connect("color_changed", self, "_on_color_3_changed")
	
	# Slider for Color 4
	color_picker_4.connect("color_changed", self, "_on_color_4_changed")
	
	# Slider for Gameboy Border Color
	gameboy_border_color_picker.connect("color_changed", self, "_on_gameboy_border_color_changed")
	
	# Info Button
	info_button.connect("pressed", self, "_on_info_button_pressed")
	
	# Copy LinkButton
	copy_link_button.connect("pressed", self, "_on_copy_button_pressed")
	
	# Visibility TextureButton
	visibility_button.connect("toggled", self, "_on_visibility_button_toggled")


# -- Grid --
# Toggle Grid
func _on_grid_toggled( pressed ):
	gameboy_grid.show() if (pressed) else gameboy_grid.hide()
	update_info_box()

# On change grid brightness
func _on_brightness_value_changed( value ):
	gameboy_grid.get_material().set_shader_param("brightness", value)
	update_info_box()


# -- 4 Colors --
# Toggle 4 Colors
func _on_4_colors_toggled( pressed ):
	four_colors.show() if (pressed) else four_colors.hide()
	update_info_box()

# On change 4 colors offset
func _on_offset_value_changed( value ):
	four_colors.get_material().set_shader_param("offset", value)
	update_info_box()


# -- Color Sliders --
# On Change Color 1
func _on_color_1_changed( color ):
	four_colors.get_material().set_shader_param("color_1", color)
	update_info_box()

# On Change Color 2
func _on_color_2_changed( color ):
	four_colors.get_material().set_shader_param("color_2", color)
	update_info_box()

# On Change Color 3
func _on_color_3_changed( color ):
	four_colors.get_material().set_shader_param("color_3", color)
	update_info_box()

# On Change Color 4
func _on_color_4_changed( color ):
	var mat = four_colors.get_material()
	mat.set_shader_param("color_4", color)
	update_info_box()

# On Gameboy Border Color
func _on_gameboy_border_color_changed( color ):
	gameboy_border.set_modulate(color)
	update_info_box()


# -- INFO --
# Toggles info box
func _on_info_button_pressed():
	info_box.show() if info_box.is_hidden() else info_box.hide()

# -- VISIBILITY --
# Toggles menu visibility by moving it infront or behind the gameboy node
func _on_visibility_button_toggled( value ):
	# Swap with GameBoy in position
	get_parent().move_child(self, gameboy.get_position_in_parent())

# Copies the entire Adds the info text to clipboard
func _on_copy_button_pressed():
	update_info_box()
	OS.set_clipboard(info_text_edit.get_text())

# Update info_box to display current settings
func update_info_box():
	# GRID
	var grid_text = "Disabled" if gameboy_grid.is_hidden() else "Enabled"
	var brightness_text = str(gameboy_grid.get_material().get_shader_param("brightness"))
	
	# 4 COLORS
	var four_colors_text = "Disabled" if four_colors.is_hidden() else "Enabled"
	var offset_text = str(four_colors.get_material().get_shader_param("offset"))
	var color_1_text = str(four_colors.get_material().get_shader_param("color_1"))
	var color_2_text = str(four_colors.get_material().get_shader_param("color_2"))
	var color_3_text = str(four_colors.get_material().get_shader_param("color_3"))
	var color_4_text = str(four_colors.get_material().get_shader_param("color_4"))
	var gameboy_border_color_text = str(gameboy_border_color_picker.get_color())
	
	# Update the edit text with shader values
	var full_text = ""
	full_text += "// Gameboy Grid Shader Values\n"
	full_text+= "uniform float brightness = " + brightness_text + ";\n\n"
	full_text += "// 4 COLORS Shader Values\n"
	full_text+= "uniform float offset = " + offset_text + ";\n"
	full_text+= "uniform color color_1 = vec4(" + color_1_text + ");\n"
	full_text+= "uniform color color_2 = vec4(" + color_2_text + ");\n"
	full_text+= "uniform color color_3 = vec4(" + color_3_text + ");\n"
	full_text+= "uniform color color_4 = vec4(" + color_4_text + ");\n\n"
	full_text += "// Gameboy Border Color\n"
	full_text+= "// " + gameboy_border_color_text + "\n"
	info_text_edit.set_text(full_text)
	