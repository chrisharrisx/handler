local DIM = 3
local REGULAR = 8
local BOLD = 11

function draw_edit_device(state)
  screen.clear()
  screen.level(DIM)
  screen.move(10, 10)
  local devices = midi.devices
  local devices_attached = false
  state.attached_device_count = 0
  
  for k, v in pairs(devices) do
    if v.name ~= 'virtual' then
      devices_attached = true
      state.attached_device_count = state.attached_device_count + 1
    end
  end
  
  if devices_attached == false then
    screen.text('NO DEVICES FOUND')
    screen.move(10, 20)
    screen.text('HIT K2 TO RETURN')
    screen.update()
    return
  end
  
  screen.text('CHOOSE DEVICE:')
  local count = 1
  local current_y = 20
  for k, v in pairs(devices) do
    if v.name ~= 'virtual' then
      current_y = current_y + 10
      screen.move(10, current_y)
      if count == state.selected_device then
        screen.level(REGULAR)
      else
        screen.level(DIM)
      end
      screen.text(v.port .. ' - ' .. string.upper(v.name))
      
      table.insert(state.attached_devices, 1, { port = v.port, name = v.name })
      
      count = count + 1
    end
  end
  screen.update()
end

return draw_edit_device
