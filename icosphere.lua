-- lovr-icosphere v0.0.1
-- https://github.com/bjornbytes/lovr-icosphere
-- MIT License

local phi = (1 + math.sqrt(5)) / 2

return function(subdivisions)
  local vertices = {
    { -1,  phi, 0 },
    {  1,  phi, 0 },
    { -1, -phi, 0 },
    {  1, -phi, 0 },

    { 0, -1,  phi },
    { 0,  1,  phi },
    { 0, -1, -phi },
    { 0,  1, -phi },

    {  phi, 0, -1 },
    {  phi, 0,  1 },
    { -phi, 0, -1 },
    { -phi, 0,  1 }
  }

  local indices = {
    1, 12, 6,
    1, 6, 2,
    1, 2, 8,
    1, 8, 11,
    1, 11, 12,

    2, 6, 10,
    6, 12, 5,
    12, 11, 3,
    11, 8, 7,
    8, 2, 9,

    4, 10, 5,
    4, 5, 3,
    4, 3, 7,
    4, 7, 9,
    4, 9, 10,

    5, 10, 6,
    3, 5, 12,
    7, 3, 11,
    9, 7, 8,
    10, 9, 2
  }

  -- Cache vertex splits to avoid duplicates
  local splits = {}

  -- Splits vertices i and j, creating a new vertex and returning the index
  local function split(i, j)
    local key = i < j and (i .. ',' .. j) or (j .. ',' .. i)

    if not splits[key] then
      local x = (vertices[i][1] + vertices[j][1]) / 2
      local y = (vertices[i][2] + vertices[j][2]) / 2
      local z = (vertices[i][3] + vertices[j][3]) / 2
      table.insert(vertices, { x, y, z })
      splits[key] = #vertices
    end

    return splits[key]
  end

  -- Subdivide
  for _ = 1, subdivisions or 0 do
    for i = #indices, 1, -3 do
      local v1, v2, v3 = indices[i - 2], indices[i - 1], indices[i - 0]
      local a = split(v1, v2)
      local b = split(v2, v3)
      local c = split(v3, v1)

      table.insert(indices, v1)
      table.insert(indices, a)
      table.insert(indices, c)

      table.insert(indices, v2)
      table.insert(indices, b)
      table.insert(indices, a)

      table.insert(indices, v3)
      table.insert(indices, c)
      table.insert(indices, b)

      table.insert(indices, a)
      table.insert(indices, b)
      table.insert(indices, c)

      table.remove(indices, i - 0)
      table.remove(indices, i - 1)
      table.remove(indices, i - 2)
    end
  end

  -- Normalize
  for i, v in ipairs(vertices) do
    local x, y, z = unpack(v)
    local length = math.sqrt(x * x + y * y + z * z)
    v[1], v[2], v[3] = x / length, y / length, z / length
  end

  return vertices, indices
end
