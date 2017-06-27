local icosphere = require 'icosphere'
local mesh

function lovr.load()
  local vertices, indices = icosphere(2)
  mesh = lovr.graphics.newMesh(vertices, 'triangles')
  mesh:setVertexMap(indices)
end

function lovr.draw()
  lovr.graphics.setWireframe(true)
  mesh:draw(0, 0, -1, .3, lovr.timer.getTime() * .3)
end
