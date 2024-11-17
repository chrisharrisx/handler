local STATE = {}

function STATE:new()
  local S = setmetatable({}, { __index = STATE })
  S.clock_div = 0.5
  S.step = 1
  S.instrument = 1              -- which device is being edited
  S.instrument_select = true    -- is the cursor on the home screen highlighting an instrument
  S.selected_device = 1         -- what device is the encoder currently highlighting on the select device screen
  S.selected_device_port = nil  -- what port is the selected device on
  S.attached_devices = {}       -- table listing names and ports of attached physical midi devices, refreshed when select device screen is rendered
  S.slot = 0
  S.selected_slot = 0           -- which slot was selected when the add event screen was entered
  S.selected_event = 1          -- what event type is the encoder currently highlighting on the add event screen
  S.scene_select = false
  S.mode = 0                    -- UI state: HOME, DEVICE_SELECT, etc.
  S.home_index = 1
  return S
end

return STATE:new()