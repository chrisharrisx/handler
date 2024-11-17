local DIM = 3
local REGULAR = 8
local BOLD = 11

function draw_home(state, instruments)
  screen.clear()
  screen.level(2)
  -- screen.font_face(2)
  screen.font_size(8)
  local line_height = 10
  local x_start = 0
  local y_start = 1
  
  for i = 1, #instruments do
    screen.blend_mode('xor')
    
    -- draw devices
    local current_y = y_start + i * line_height
    screen.move(x_start, current_y)
    if i == state.instrument and state.instrument_select then
      screen.level(REGULAR)
    else
      screen.level(DIM)
    end
    screen.text(i)
    screen.move(8, current_y)
    
    -- draw scenes
    local instrument = instruments[i]
    local scene = instrument.scenes[instrument.scene]
    if i == state.instrument and state.scene_select then
      screen.level(REGULAR)
    else
      screen.level(DIM)
    end
    screen.text(scene.name)
    
    -- draw slots
    -- screen.blend_mode('overlay')
    local current_x = 9
    for j = 1, 8 do
      if i == state.instrument and j == state.selected_slot then
        screen.level(REGULAR)
      else
        screen.level(DIM)
      end
      current_x = current_x + 11
      screen.move(current_x, current_y)
      
      screen.rect(current_x, current_y - 6, 8, 8)
      screen.stroke()
      screen.close()
      
      if j == scene.slot then
        screen.rect(current_x + 1, current_y - 5, 5, 5)
        screen.fill()
        screen.close()
      end
    end
  end
  
  screen.level(DIM)
  current_x = 20
  current_y = 60
  screen.move(current_x, current_y)
  
  screen.rect(current_x, current_y - 6, 8, 8)
  screen.stroke()
  screen.close()
  
  if state.step % 2 == 0 then
    screen.rect(current_x + 1, current_y - 5, 5, 5)
    screen.fill()
    screen.close()
  end
  
  screen.move(current_x + 12, current_y)
  -- screen.text(clock.get_tempo() .. 'BPM')
  
  screen.update()
end

return draw_home
