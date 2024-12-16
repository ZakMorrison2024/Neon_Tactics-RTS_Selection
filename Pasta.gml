
//
// Character selecting 
//
// select
if device_mouse_check_button_pressed(0,mb_left)  // intial press
{if device_mouse_x_to_gui(0) < 930 and hide == true or 
	device_mouse_x_to_gui(0) < 630 and hide == false {
if gui_mouse == false {
		
	ds_list_clear(ds_select); // clear selected list
	
for(chara = 0; chara < instance_number(obj_player); chara ++)
{if instance_find(obj_player,chara).selected == true
	{instance_find(obj_player,chara).selected = false;}} // deselect unit


select_mouse_start_x = device_mouse_x(0); // start pos x
select_mouse_start_y = device_mouse_y(0); // start pos y
}}}

if device_mouse_check_button_released(0,mb_left) // release
{if device_mouse_x_to_gui(0) < 930 and hide == true or device_mouse_x_to_gui(0) < 630 and hide == false
{if gui_mouse == false {
select_mouse_finish_x = device_mouse_x(0); // finish pos x
select_mouse_finish_y = device_mouse_y(0); // finish pos y

collision_rectangle_list(select_mouse_start_x,select_mouse_start_y,select_mouse_finish_x,select_mouse_finish_y,obj_player,0,0,ds_select,0)	
// add colliding isnatnces to list

}}}

if ds_list_size(ds_select) > 0 // if selected
{
	//selecting players
	for (selected = 0; selected < ds_list_size(ds_select); selected ++) // check how many selected
	{ds_list_find_value(ds_select,selected).selected = true} // make all players selected
	
	if device_mouse_check_button_pressed(0,mb_right){ // right pressed (move marker){
	
	// check if right pressed on enemy or obtainable
	
	//
	// Marker Placement
	//
	
	marker[tap] = instance_create_depth(device_mouse_x(0),device_mouse_y(0),200,obj_marker); // place marker
	marker[tap].no_selected = ds_list_size(ds_select);
	
	
	for (selected_list_size = 0; selected_list_size < ds_list_size(ds_select); selected_list_size ++)
	{marker[tap].belongs_to[selected_list_size] = ds_list_find_value(ds_select,selected_list_size)}
	
// check existing markers for player id and then remove in favour of new marker	
	if array_length(marker) > 0 // if marker list greater than 0
	{for(j = 0; j < array_length(marker); j++) // check all markers before
	{for (check = 0; check < 4; check ++) // cycle "belongs_to" array
		{for(sec_check = 0; sec_check < 4; sec_check++)
			{if instance_exists(marker[j]) and marker[j] > 0
			{if marker[j] != marker[tap] // if marker checked isn't the same as marker placed
			{if marker[j].belongs_to[check] == marker[tap].belongs_to[sec_check] // if marker checked "belongs to" array contains the markers placed belongs to id
	{marker[j].belongs_to[check] = 0; // change to noone
		if !instance_exists(marker[j])
		{marker[j] = 0;}
	}}}}}}}

// formatioms

 if array_length(marker[tap].belongs_to) > 0
 {
	 marker[tap].primary = true;
	 
with(marker[tap])
{
	if primary == true
	{
		for(find_tank = 0; find_tank < array_length(belongs_to); find_tank ++)
		{if belongs_to[find_tank] > 0 and belongs_to[find_tank].tank = true
		{tank = belongs_to[find_tank].id;
		if belongs_to[0] != tank
		{
		belongs_to[find_tank] = belongs_to[0];
		belongs_to[0] = tank;
		}}
		else
		{tank = 0;}}
	
position_direction = point_direction(belongs_to[0].x, belongs_to[0].y, x, y);

if obj_control.formation == 0
{
    sec_mark_left_dir_x_100 = x + random_range(-150,150);
    sec_mark_left_dir_y_100 = y + random_range(-150,150);
    sec_mark_right_dir_x_100 = x + random_range(-150,150);
    sec_mark_right_dir_y_100 = y + random_range(-150,150);
    sec_mark_left_dir_x_200 = x + random_range(-150,150);
    sec_mark_left_dir_y_200 = y + random_range(-150,150);
    sec_mark_right_dir_x_200 = x + random_range(-150,150);
    sec_mark_right_dir_y_200 = y + random_range(-150,150);
}
if obj_control.formation == 1
{
	var offset_angle = 45; // Offset angle for secondary marks
	
if (position_direction >= 315 || position_direction < 45) {
    sec_mark_left_dir_x_100 = x - lengthdir_x(150, position_direction + offset_angle);
    sec_mark_left_dir_y_100 = y - lengthdir_y(150, position_direction + offset_angle);
    sec_mark_right_dir_x_100 = x - lengthdir_x(150, position_direction - offset_angle);
    sec_mark_right_dir_y_100 = y - lengthdir_y(150, position_direction - offset_angle);
    sec_mark_left_dir_x_200 = x - lengthdir_x(300, position_direction + offset_angle);
    sec_mark_left_dir_y_200 = y - lengthdir_y(300, position_direction + offset_angle);
    sec_mark_right_dir_x_200 = x - lengthdir_x(300, position_direction - offset_angle);
    sec_mark_right_dir_y_200 = y - lengthdir_y(300, position_direction - offset_angle);
}
else if (position_direction >= 45 && position_direction < 135) {
    sec_mark_left_dir_x_100 = x + lengthdir_x(150, position_direction + offset_angle);
    sec_mark_left_dir_y_100 = y - lengthdir_y(150, position_direction + offset_angle);
    sec_mark_right_dir_x_100 = x + lengthdir_x(150, position_direction - offset_angle);
    sec_mark_right_dir_y_100 = y - lengthdir_y(150, position_direction - offset_angle);
    sec_mark_left_dir_x_200 = x + lengthdir_x(300, position_direction + offset_angle);
    sec_mark_left_dir_y_200 = y - lengthdir_y(300, position_direction + offset_angle);
    sec_mark_right_dir_x_200 = x + lengthdir_x(300, position_direction - offset_angle);
    sec_mark_right_dir_y_200 = y - lengthdir_y(300, position_direction - offset_angle);
}
else if (position_direction >= 135 && position_direction < 225) {
    sec_mark_left_dir_x_100 = x + lengthdir_x(150, position_direction/180 + offset_angle);
    sec_mark_left_dir_y_100 = y + lengthdir_y(150, position_direction/180 + offset_angle);
    sec_mark_right_dir_x_100 = x + lengthdir_x(150, position_direction/180 - offset_angle);
    sec_mark_right_dir_y_100 = y + lengthdir_y(150, position_direction/180 - offset_angle);
    sec_mark_left_dir_x_200 = x + lengthdir_x(300, position_direction/180 + offset_angle);
    sec_mark_left_dir_y_200 = y + lengthdir_y(300, position_direction/180 + offset_angle);
    sec_mark_right_dir_x_200 = x + lengthdir_x(300, position_direction/180 - offset_angle);
    sec_mark_right_dir_y_200 = y + lengthdir_y(300, position_direction/180 - offset_angle);
}
else if (position_direction >= 225 && position_direction < 315) {
    sec_mark_left_dir_x_100 = x + lengthdir_x(150, position_direction + offset_angle);
    sec_mark_left_dir_y_100 = y - lengthdir_y(150, position_direction + offset_angle);
    sec_mark_right_dir_x_100 = x + lengthdir_x(150, position_direction - offset_angle);
    sec_mark_right_dir_y_100 = y - lengthdir_y(150, position_direction - offset_angle);
    sec_mark_left_dir_x_200 = x + lengthdir_x(300, position_direction + offset_angle);
    sec_mark_left_dir_y_200 = y - lengthdir_y(300, position_direction + offset_angle);
    sec_mark_right_dir_x_200 = x + lengthdir_x(300, position_direction - offset_angle);
    sec_mark_right_dir_y_200 = y - lengthdir_y(300, position_direction - offset_angle);
}
}
if obj_control.formation == 2
{
// (position_direction >= 315 || position_direction < 45) {
 sec_mark_left_dir_x_100 = x - lengthdir_x(150, position_direction-90);
    sec_mark_left_dir_y_100 = y - lengthdir_y(150, position_direction-90);
    sec_mark_right_dir_x_100 = x + lengthdir_x(150, position_direction-90);
    sec_mark_right_dir_y_100 = y + lengthdir_y(150, position_direction-90);
    sec_mark_left_dir_x_200 = x - lengthdir_x(300, position_direction-90);
    sec_mark_left_dir_y_200 = y - lengthdir_y(300, position_direction-90);
    sec_mark_right_dir_x_200 = x + lengthdir_x(300, position_direction-90);
    sec_mark_right_dir_y_200 = y + lengthdir_y(300, position_direction-90);
}
if obj_control.formation == 3
{
// (position_direction >= 315 || position_direction < 45) {
 sec_mark_left_dir_x_100 = x - lengthdir_x(150, position_direction-45);
    sec_mark_left_dir_y_100 = y - lengthdir_y(150, position_direction-45);
    sec_mark_right_dir_x_100 = x + lengthdir_x(150, position_direction-45);
    sec_mark_right_dir_y_100 = y + lengthdir_y(150, position_direction-45);
    sec_mark_left_dir_x_200 = x - lengthdir_x(150, position_direction-135);
    sec_mark_left_dir_y_200 = y - lengthdir_y(150, position_direction-135);
    sec_mark_right_dir_x_200 = x + lengthdir_x(150, position_direction-135);
    sec_mark_right_dir_y_200 = y + lengthdir_y(150, position_direction-135);
}

		draw = true;
		
		for (unit_quanity = 1; unit_quanity < array_length(belongs_to); unit_quanity ++)
		{
			if obj_control.formation == 0 || obj_control.formation == 1 || obj_control.formation == 2 || obj_control.formation == 3 // arrow
			{	
				if sec_mark[0] = 0
				{sec_mark[0] = instance_create_depth(sec_mark_left_dir_x_100,sec_mark_left_dir_y_100,depth,obj_marker);}
				if sec_mark[1] = 0
				{sec_mark[1] = instance_create_depth(sec_mark_right_dir_x_100,sec_mark_right_dir_y_100,depth,obj_marker);}
				if sec_mark[2] = 0
		        {sec_mark[2] = instance_create_depth(sec_mark_left_dir_x_200,sec_mark_left_dir_y_200,depth,obj_marker);}
				if sec_mark[3] = 0
				{sec_mark[3] = instance_create_depth(sec_mark_right_dir_x_200,sec_mark_right_dir_y_200,depth,obj_marker);}
				
				if belongs_to[unit_quanity] > 0 and belongs_to[unit_quanity].tank != true
				{
				sec_mark[unit_quanity-1].belongs_to[unit_quanity] = belongs_to[unit_quanity];
				sec_mark[unit_quanity-1].belongs_to[unit_quanity].formation = unit_quanity - 1
				
				belongs_to[unit_quanity] = 0;
			    }	}
			}
		}
	}
	}// formations end
tap ++; // increase marker cycle

}// cycle end
 
 

}// click end
