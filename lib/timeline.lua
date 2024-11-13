local TIMELINE = {}

function TIMELINE:new()
    local T = setmetatable({}, { __index = TIMELINE })
    T.steps = 16
    T.step = 1
    return T
end

function TIMELINE:advance()
  local current_step = self.step
  if self.step < self.steps then
    self.step = self.step + 1
  else
    self.step = 1
  end
  return current_step
end

return TIMELINE:new()