return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.16.0",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 12,
  tilewidth = 64,
  tileheight = 64,
  nextobjectid = 3,
  properties = {},
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      name = "bg",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      image = "game.png",
      properties = {}
    },
    {
      type = "objectgroup",
      name = "blocks",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 576.205,
          width = 1280,
          height = 140,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "player",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 27,
          y = 500,
          width = 64,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
