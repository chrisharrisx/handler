-- Handler
-- v0.0.1 @chrisharrisx
-- llllllll.co/handler
--
-- MIDI timeline event system
--

local midihub_a = midi.connect(1)
local m8 = midi.connect(5)

local timeline = include('lib/timeline')

local ER = require('er')

local state = {
  clock_div = 0.5
}

function init()
  clock.run(tick)
end

function tick()
  local er_table = ER.gen(7, 16, 0)
  local er_table2 = ER.gen(9, 17, 0)
  local programs = { 56, 58, 72, 80 }
  local programs2 = { 83, 84, 87, 92 }
  local notes = { 60, 62, 67, 71 }
  local notes2 = { 65, 67, 72, 76 }
  local bars = 0
  
  m8_started = false
  
  while true do
    clock.sync(state.clock_div)
    if not m8_started then
      m8:start()
      m8_started = true
    end
    local step = timeline:advance()
    local note = step % 4 ~= 0 and step % 4 or 4
    
    if step == 16 then
      bars = bars + 1
    end
    if bars % 4 == 0 then
      current_notes = notes2
    end
    if bars % 8 == 0 then
      current_notes = notes
    end
    
    midihub_1:note_on(current_notes[note], 64, 2)
    
    if step % 4 == 0 then
      midihub_a:program_change(programs[math.random(1, 4)], 1)
      midihub_a:program_change(programs2[math.random(1, 4)], 3)
    end
    
    if er_table[step] then
      midihub_a:note_on(current_notes[math.random(1, 4)], 64, 1)
    end
    
    if er_table2[step] then
      midihub_a:note_on(current_notes[math.random(1, 4)], 64, 3)
    end
  end
end