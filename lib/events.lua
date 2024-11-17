--[[
  
  Event Types:
    - Sequencer (euclidean)
    - MIDI cc
    - MIDI program change
    - MIDI stop/start
    - GOTO (slot/scene)
    - REPEAT (slot)
    - Crow?
  
]]

local SEQUENCER = {}
function SEQUENCER:new()
  local S = setmetatable({}, { __index = SEQUENCER })
  S.name = 'SEQ'
  S.channel = 1
  S.length = 16
  S.scale = nil
  S.direction = 'forward' -- backward, ping-pong, drunk, random
  S.follow = false -- follow song key
  S.notes = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }
  return S
end

local MIDI_CC = {}
function MIDI_CC:new()
  local CC = setmetatable({}, { __index = MIDI_CC })
  CC.name = 'CC'
  CC.channel = 1
  CC.number = 1
  CC.length = 16
  CC.direction = 'forward'
  CC.values = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }
  return CC
end

local MIDI_PC = {}
function MIDI_PC:new()
  local PC = setmetatable({}, { __index = MIDI_PC })
  PC.name = 'PC'
  PC.channel = 1
  PC.length = 16
  PC.direction = 'forward'
  PC.values = { nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil, nil }
  return PC
end

local TRANSPORT = {}
function TRANSPORT:new()
  local T = setmetatable({}, { __index = TRANSPORT })
  T.name = 'TRAN'
  T.channel = 1
  T.send_clock = true
  T.send_transport = true
  return T
end

local GOTO = {}
function GOTO:new()
  local G = setmetatable({}, { __index = GOTO })
  G.name = 'GOTO'
  return G
end

local REPEAT = {}
function REPEAT()
  local R = setmetatable({}, { __index = REPEAT })
  R.name = 'REP'
  return R
end

local EVENT_TYPES = {
  SEQUENCER,
  MIDI_CC,
  MIDI_PC,
  TRANSPORT,
  GOTO,
  REPEAT
}

return EVENT_TYPES

-- -- --------------------------------------------------

-- local EVENT = {}

-- function EVENT:new(device)
--   local E = setmetatable({}, { __index = EVENT })
--   E.type = nil
--   E.types = { SEQUENCER, MIDI_CC, MIDI_PC, TRANSPORT }
--   return E
-- end  

-- return EVENT
  