local cache = {}
cache.assets = {}
cache.sounds = {}

-- Allow to only load an asset once
function cache:getOrLoadImage(path)
  if cache.assets[path] then
    return cache.assets[path]
  else
    local asset = love.graphics.newImage(path)
    asset:setFilter("nearest","nearest")

    cache.assets[path] = asset

    return asset
  end
end

function cache:getOrLoadSound(path)
  if cache.sounds[path] then
    return cache.sounds[path]
  else
    local sound = love.audio.newSource(path)
    cache.sounds[path] = sound

    return sound
  end
end

return cache
