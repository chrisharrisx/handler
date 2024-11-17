-- Handler
-- v0.0.1 @chrisharrisx
-- llllllll.co/handler
--
-- Event System
--

local timeline = include('lib/timeline')
local state = include('lib/state')
local instruments = include('lib/instruments')
local view = include('lib/view')
local events = include('lib/events')

local tab = require('tabutil')

local HOME = 0
local EDIT_DEVICE = 1
local EDIT_EVENTS = 2
local EDIT_EVENT = 3

function init()
  clock.run(tick)
end

function tick()
  while true do
    clock.sync(state.clock_div)
    local step = timeline:advance()
    state.step = step
    for i = 1, #instruments do
      instruments[i]:next(step)
    end
    if state.mode == HOME then
      redraw()
    end
    -- if instruments[state.instrument].device ~= nil then
    --   instruments[state.instrument].device:note_on(60, 64, 2)
    -- end
  end
end

function redraw()
  -- print(state.mode)
  view:redraw(state.mode, state, instruments)
end

function enc(n, d)
  if n == 2 and state.mode == HOME then
    state.instrument = util.clamp(state.instrument + d, 1, 4)
  end
  if n == 3 and state.mode == HOME then
    state.home_index = util.clamp(state.home_index + d, 1, 10)
    if state.home_index == 1 then
      state.instrument_select = true
      state.scene_select = false
      state.selected_slot = 0
    elseif state.home_index == 2 then
      state.scene_select = true
      state.instrument_select = false
      state.selected_slot = 0
    else
      state.instrument_select = false
      state.scene_select = false
      state.selected_slot = state.home_index - 2
    end
  end
  
  if n == 2 and state.mode == EDIT_DEVICE then
    state.selected_device = util.clamp(state.selected_device + d, 1, state.attached_device_count)
  end
 
  if n == 2 and state.mode == EDIT_EVENTS then
    if state.selected_event < 9 then
      state.selected_event = state.selected_event + 8
    else
      state.selected_event = state.selected_event - 8
    end
  end
  if n == 3 and state.mode == EDIT_EVENTS then
    state.selected_event = util.clamp(state.selected_event + d, 1, 16)
  
    --[[
    local inst_num = state.instrument
    local inst = instruments[state.instrument]
    local scene = inst.scenes[inst.scene]
    
    local message = string.format('inst:%d scene:%s', inst_num, inst.scenes[inst.scene].name)
    local slot = 0
    
    if state.selected_slot ~= 0 then
      slot = scene.slots[state.selected_slot]
      message = message .. string.format(' slot:%d', state.selected_slot)
      local event = slot.events[state.selected_event]
      if event.name == nil then
        event = 'none'
      else
        event = event.name
      end
      message = message .. string.format(' event:%d name:%s', state.selected_event, event)
    end
    print(message)
    ]]
  end
  redraw()
end

function key(n, z)
  if n == 3 and z == 1 and state.mode == HOME and state.selected_slot < 1 then
    if state.device_select then
      state.mode = EDIT_DEVICE
    end
  elseif n == 3 and z == 1 and state.mode == EDIT_DEVICE then
    -- error check this
    instruments[state.instrument]:assign_device(midi.connect(state.attached_devices[state.selected_device].port))
    state.mode = HOME
  elseif n == 3 and z == 1 and state.selected_slot > 0 and state.mode == HOME then
    state.mode = EDIT_EVENTS
  elseif n == 3 and z == 1 and state.mode == EDIT_EVENTS then
    instruments[state.instrument]:add_event(state, events[1])
  elseif n == 2 and z == 1 and state.mode == EDIT_DEVICE then
    state.mode = HOME
  elseif n == 2 and z == 1 and state.mode == EDIT_EVENTS then
    state.mode = HOME
  end
  redraw()
end