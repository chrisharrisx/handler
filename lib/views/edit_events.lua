local DIM = 3
local REGULAR = 8
local BOLD = 11

function draw_edit_events(state, instruments)
  screen.clear()
  screen.level(2)
  
  local start_x = 9
  local current_x = 9
  local start_y = 20
  local current_y = 20
  local inst = instruments[state.instrument]
  local scene = inst.scenes[inst.scene]
  local slot = scene.slots[state.selected_slot]
  local events = slot.events
  
  screen.move(start_x, start_y)
  
  for i = 1, #events do
      if i == state.selected_event then
        screen.level(REGULAR)
      else
        screen.level(DIM)
      end
      
      current_x = current_x + 11
      
      if i == 9 then
        current_x = start_x + 11
        current_y = start_y + 11
      end
        
      screen.move(current_x, current_y)
      screen.rect(current_x, current_y - 6, 8, 8)
      screen.stroke()
      screen.close()
      
      if events[i].name ~= nil then
        screen.rect(current_x + 1, current_y - 5, 5, 5)
        screen.fill()
        screen.close()
      end
      if events[i].name ~= nil and i == state.selected_event then
        screen.level(DIM)
        screen.move(20, 51)
        screen.text(events[i].name)
      end
  end
  screen.update()
end

return draw_edit_events

