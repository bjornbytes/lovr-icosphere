lovr-icosphere
===

A small library to generate icospheres with Lua and [LÖVR](https://github.com/bjornbytes/lovr).
Inspired by [this blog post](http://blog.andreaskahler.com/2009/06/creating-icosphere-mesh-in-code.html).

> Note: In LÖVR 0.7.1 and on, you can use the `lovr.graphics.sphere` function to draw filled
> spheres.  This library is still useful for drawing wireframe spheres or "low-poly" spheres.

Usage
---

```lua
local icosphere = require 'icosphere'

function lovr.load()
  local vertices, indices = icosphere(2)

  mesh = lovr.graphics.newMesh(vertices, 'triangles')
  mesh:setVertexMap(indices)
end

function lovr.draw()
  lovr.graphics.setWireframe(true)
  mesh:draw(0, 0, -1, .3, lovr.timer.getTime() * .3)
end
```

Documentation
---

```lua
vertices, indices = icosphere(n)
```

The library exports a single function.  The function accepts a single integer parameter `n`
representing the number of times to subdivide the sphere.  Higher numbers will yield smoother
geometry, but each subdivision will quadruple the number of vertices.  If `n` is zero or `nil`,
an the function will generate a regular convex icosahedron with 12 vertices and 20 triangles.

The list of vertices can be passed directly to `lovr.graphics.newMesh`, and list of indices can
be used as the Mesh's vertex map.

License
---

MIT, see [LICENSE](LICENSE) for details.
