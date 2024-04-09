local icosphere = require 'icosphere'
local mesh

function lovr.load()
  local vertices, indices = icosphere(2)
  mesh = lovr.graphics.newMesh(vertices)
  mesh:setIndices(indices)
end

function lovr.draw(pass)
  pass:setWireframe(true)
  pass:draw(mesh, 0, 1.7, -1, .3, lovr.timer.getTime() * .3)
end
