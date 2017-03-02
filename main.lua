local icosphere = require 'icosphere'
local buffer

function lovr.load()
  local vertices, indices = icosphere(2)
  buffer = lovr.graphics.newBuffer(vertices, 'triangles')
  buffer:setVertexMap(indices)
end

function lovr.draw()
  lovr.graphics.setWireframe(true)
  buffer:draw(0, 0, -1, .3, lovr.timer.getTime() * .3)
end
