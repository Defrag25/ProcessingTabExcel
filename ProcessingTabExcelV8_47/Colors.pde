/**
 * Load the UI colour scheme
 *
 * @param  mode Select the colour scheme to load
 */
 
 
 int colorScheme = 2;
 // Define UI colour variables
color c_background;
color c_backgroundSel;
color c_tabbar_h;
color c_idletab;
color c_tabbar_text;
color c_idletab_text;
color c_sidebar;
color c_sidebar_h;
color c_sidebar_heading;
color c_sidebar_text;
color c_sidebar_button;
color c_sidebar_divider;
color c_sidebar_accent;
color c_terminal_text;
color c_message_text;
color c_graph_axis;
color c_graph_gridlines;
color c_graph_border;
color c_serial_message_box;
color c_message_box_outline;
color c_alert_message_box;
color c_info_message_box;
color c_status_bar;
color c_highlight_background;


// Predefined colors
final color c_white = color(255, 255, 255);
final color c_blue = color(96, 200, 220);
final color c_purple = color(147, 111, 212);
final color c_red = color(208, 38, 98);
final color c_yellow = color(215, 196, 96);
final color c_green = color(35, 205, 65);
final color c_orange = color(230, 85, 37);
final color c_lightgrey = color(134, 134, 138);
final color c_grey = color(111, 108, 90);
final color c_darkgrey = color(49, 50, 44);
final color c_black = color(0, 0, 0);

void loadColorScheme(int mode) {
  switch (mode) {
    // Light mode - Celeste
    case 0:
    c_background = color(255, 255, 255);          // Background
    c_backgroundSel = color(229, 229, 229);              // 
      c_tabbar_h = color(217, 217, 217);
      c_idletab = color(240, 240, 240);
      c_tabbar_text = color(50, 50, 50);
      c_idletab_text = color(140, 140, 140);
      c_sidebar = color(229, 229, 229);
      c_sidebar_h = color(217, 217, 217);
      c_sidebar_heading = color(34, 142, 195);
      c_sidebar_text = color(50, 50, 50);
      c_sidebar_button = color(255, 255, 255);
      c_sidebar_divider = color(217, 217, 217);
      c_sidebar_accent = color(255, 108, 160);
    c_terminal_text = color(136, 136, 136);
    c_message_text = c_grey;
      c_graph_axis = color(150, 150, 150);
      c_graph_gridlines = color(229, 229, 229);
      c_graph_border = c_graph_gridlines;
      c_serial_message_box = c_idletab;
      c_message_box_outline = c_tabbar_h;
     //_alert_message_box = c_tabbar;
      c_info_message_box = color(229, 229, 229);
      c_status_bar = c_message_text;
   //   c_highlight_background = c_tabbar;
      break;

    // Dark mode - One Dark Gravity
    case 1:
      c_background = color(40, 44, 52);
      c_backgroundSel = color(24, 26, 31);
      c_tabbar_h = color(19, 19, 28);
      c_idletab = color(33, 36, 43);
      c_tabbar_text = c_white;
      c_idletab_text = color(152, 152, 152);
      c_sidebar = color(24, 26, 31); //color(55, 56, 60);
      c_sidebar_h = color(55, 56, 60);
      c_sidebar_heading = color(97, 175, 239);
      c_sidebar_text = c_white;
      c_sidebar_button = color(76, 77, 81);
      c_sidebar_divider = c_grey;
      c_sidebar_accent = c_red;
      c_terminal_text = color(171, 178, 191);
      c_message_text = c_white;
      c_graph_axis = c_lightgrey;
      c_graph_gridlines = c_darkgrey;
      c_graph_border = color(60, 64, 73);
      c_serial_message_box = c_idletab;
      c_message_box_outline = c_tabbar_h;
  //  c_alert_message_box = c_tabbar;
 //   c_info_message_box = c_tabbar;
      c_status_bar = c_terminal_text;
      c_highlight_background = color(61, 67, 80);//c_tabbar;
      break;

    // Dark mode - Monokai (default)
    case 2:
    default:
      c_background = color(40, 41, 35);
      c_backgroundSel = color(24, 25, 21);
      c_tabbar_h = color(19, 19, 18);
      c_idletab = color(32, 33, 28);
      c_tabbar_text = c_white;
      c_idletab_text = color(152, 152, 152);
  //    c_sidebar = c_tabbar;
      c_sidebar_h = c_tabbar_h;
      c_sidebar_heading = color(103, 216, 239);
      c_sidebar_text = c_white;
      c_sidebar_button = color(92, 93, 90);
      c_sidebar_divider = c_grey;
      c_sidebar_accent = c_red;
      c_terminal_text = c_lightgrey;
      c_message_text = c_white;
      c_graph_axis = c_lightgrey;
      c_graph_gridlines = c_darkgrey;
      c_graph_border = c_graph_gridlines;
      c_serial_message_box = c_darkgrey;
      c_message_box_outline = c_tabbar_h;
  //  c_alert_message_box = c_tabbar;
      c_info_message_box = c_darkgrey;
      c_status_bar = c_lightgrey;
  //  c_highlight_background = c_tabbar;
      break;
  }


} 
