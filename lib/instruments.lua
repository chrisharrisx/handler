local SLOT = {}

function SLOT:new(length)
  local S = setmetatable({}, { __index = SLOT })
  S.events = { {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} }
  S.length = length
  S.step = 1
  return S
end

local SCENE = {}

function SCENE:new(name)
  local S = setmetatable({}, { __index = SCENE })
  S.name = name
  S.slot = 1
  S.slots = { SLOT:new(16), SLOT:new(16), SLOT:new(16), SLOT:new(16), SLOT:new(16), SLOT:new(16), SLOT:new(16), SLOT:new(16) }
  return S
end

local INSTRUMENT = {}

function INSTRUMENT:new(name)
  local I = setmetatable({}, { __index = INSTRUMENT })
  I.device = nil
  I.name = name
  I.scene = 1
  I.scenes = { SCENE:new('A'), SCENE:new('B'), SCENE:new('C'), SCENE:new('D') }
  return I
end

function INSTRUMENT:next(step)
  local scene = self.scenes[self.scene]
  local slot = scene.slots[scene.slot]
  
  if slot.step < slot.length then
    slot.step = slot.step + 1
  else
    slot.step = 1
    if scene.slot < #scene.slots then
      scene.slot = scene.slot + 1
    else
      scene.slot = 1
    end
  end
end

function INSTRUMENT:set_current_slot_length(len)
  local current_scene = self.scenes[self.scene]
  local current_slot = current_scene.slots[current_scene.slot]
  current_slot.length = len
end

function INSTRUMENT:set_slot_lengths_for_current_scene(lengths)
  local current_scene = self.scenes[self.scene]
  for i = 1, #lengths do
    current_scene.slots[i].length = lengths[i]
  end
end

function INSTRUMENT:add_event(state, event)
  print('in add_event', state.selected_slot)
  local current_scene = self.scenes[self.scene]
  tab.print(current_scene)
  local current_slot = current_scene.slots[state.selected_slot]
  tab.print(current_slot)
  
  -- if #current_slot.events < 16 then
    print(string.format('inserting event for scene %d, slot %d, event %d', self.scene, state.selected_slot, state.selected_event))

    table.remove(current_slot.events, state.selected_event)
    table.insert(current_slot.events, state.selected_event, event:new())
    tab.print(current_slot.events[1])
    
    -- table.insert(current_slot.events, event:new())
  -- end
  -- tab.print(current_slot.events[1])
  -- local e = EVENT_TYPES[event]:new()
end

function INSTRUMENT:assign_device(midi_device)
  self.device = midi_device
end

local instrument_1 = INSTRUMENT:new('Instrument 1')
local instrument_2 = INSTRUMENT:new('Instrument 2')
local instrument_3 = INSTRUMENT:new('Instrument 3')
local instrument_4 = INSTRUMENT:new('Instrument 4')

-- instrument_1:set_current_slot_length(4)
-- instrument_1:set_slot_lengths_for_current_scene({ 4, 4, 4, 4, 4, 4, 4, 4 })

local INSTRUMENTS = {
  instrument_1,
  instrument_2,
  instrument_3,
  instrument_4
}

return INSTRUMENTS
