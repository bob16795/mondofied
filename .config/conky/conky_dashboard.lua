require 'cairo'

-- Color theme
cBackground=0x2A3238
cNormal=0x2A3238
cWarning=0x2A3238
cCritical=0x2A3238

-- Alphas
aBackground=0.4
aForeground=0.35

-- Limits
lWarning=0.80
lCritical=0.90

-- Rings
settings_table = {
 -- "name" is the type of stat to display; you can choose from 'cpu', 'memperc', 'fs_used_perc', 'battery_used_perc'.
 -- "arg" is the argument to the stat type, e.g. if in Conky you would write ${cpu cpu0}, 'cpu0' would be the argument. If you would not use an argument in the Conky variable, use ''.
 -- "max" is the maximum value of the ring. If the Conky variable outputs a percentage, use 100.
 -- "bg_colour" is the colour of the base ring.
 -- "bg_alpha" is the alpha value of the base ring.
 -- "fg_colour" is the colour of the indicator part of the ring.
 -- "fg_alpha" is the alpha value of the indicator part of the ring.
 -- "x" and "y" are the x and y coordinates of the centre of the ring, relative to the top left corner of the Conky window.
 -- "radius" is the radius of the ring.
 -- "thickness" is the thickness of the ring, centred around the radius.
 -- "start_angle" is the starting angle of the ring, in degrees, clockwise from top. Value can be either positive or negative.
 -- "end_angle" is the ending angle of the ring, in degrees, clockwise from top. Value can be either positive or negative, but must be larger than start_angle.

{
	 -- CPU secondary
  name='cpu', arg='cpu',
  max=100,
  bg_colour=cBackground, bg_alpha=aBackground,
  fg_colour=cNormal, fg_alpha=aForeground,
  x=200, y=150,
  radius=120, thickness=24,
  start_angle=-90, end_angle=270
 },

  {
	 -- CPU main
  name='hwmon 0', arg='temp 1',
  max=60,
  bg_colour=cBackground, bg_alpha=aBackground,
  fg_colour=cNormal, fg_alpha=aForeground,
  x=200, y=150,
  radius=155, thickness=30,
  start_angle=90, end_angle=135
 },

 {
	 -- RAM
  name='memperc', arg='',
  max=100,
  bg_colour=cBackground, bg_alpha=aBackground,
  fg_colour=cNormal, fg_alpha=aForeground,
  x=200, y=150,
  radius=96, thickness=24,
  start_angle=-90, end_angle=270
 },

 {
	 -- BATTERY
  name='battery_percent', arg='BAT0',
  max=100,
  bg_colour=cBackground, bg_alpha=aBackground,
  fg_colour=cNormal, fg_alpha=aForeground,
  x=200, y=150,
  radius=72, thickness=24,
  start_angle=-90, end_angle=270
 },

}

function rgb_to_r_g_b(colour,alpha)
 return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end

function draw_ring(cr,t,pt)
 local w,h=conky_window.width,conky_window.height
 local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
 local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

 local angle_0=sa*(2*math.pi/360)-math.pi/2
 local angle_f=ea*(2*math.pi/360)-math.pi/2
 local t_arc=t*(angle_f-angle_0)

 -- Check for limit values inducing color changes
 if t>lCritical then
  fgc=cCritical
 elseif t>lWarning then
  fgc=cWarning
 else
  fgc=cNormal
 end

 -- Draw background ring
 cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
 cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
 cairo_set_line_width(cr,ring_w)
 cairo_stroke(cr)

 -- Draw indicator ring
 cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
 cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
 cairo_stroke(cr)        
end

function conky_init_rings()
 local function setup_rings(cr,pt)
  local str=''
  local value=0

  str=string.format('${%s %s}',pt['name'],pt['arg'])
  str=conky_parse(str)
  value=tonumber(str)
  
  -- Preventing overflow
  if value>pt['max'] then
   pct=1
  else
   pct=(value or 0)/pt['max']
  end

  draw_ring(cr,pct,pt)
 end

 -- Check that Conky has been running for at least 5s
 if conky_window==nil then return end

 local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)
 local cr=cairo_create(cs)    
 --~ cairo_surface_destroy(cs) -- What does THIS do ?!

 local updates=conky_parse('${updates}')
 update_num=tonumber(updates)

 if update_num>5 then
  for i in pairs(settings_table) do
   setup_rings(cr,settings_table[i])
  end
 end

	cairo_destroy(cr)
end
