local draw_home = include('lib/views/home')
local draw_edit_device = include('lib/views/edit_device')
local draw_edit_events = include('lib/views/edit_events')

local VIEW = {}

function VIEW:new()
  local V = setmetatable({}, { __index = VIEW })
  return V
end

function VIEW:redraw(mode, state, instruments)
  if mode == 0 then
    draw_home(state, instruments)
  elseif mode == 1 then
    draw_edit_device(state)
  elseif mode == 2 then
    draw_edit_events(state, instruments)
  elseif mode == 3 then
    draw_edit_event(state, instruments)
  end
end

return VIEW:new()