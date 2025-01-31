local config = require("dapui.config")
local util = require("dapui.util")
local Canvas = require("dapui.render.canvas")

return function(client)
  local dapui = { elements = {} }

  ---@class dapui.elements.scopes
  ---@toc_entry Variable Scopes
  ---@text
  --- Displays the available scopes and variables within them.
  ---
  --- Mappings:
  --- - `edit`: Edit the value of a variable
  --- - `expand`: Toggle showing any children of variable.
  --- - `repl`: Send variable to REPL
  dapui.elements.scopes = {}

  local send_ready = util.create_render_loop(function()
    dapui.elements.scopes.render()
  end)

  local scopes = require("dapui.components.scopes")(client, send_ready)

  local buf = util.create_buffer("DAP Scopes", {
    filetype = "dapui_scopes",
  })

  ---@nodoc
  function dapui.elements.scopes.render()
    local canvas = Canvas.new()
    scopes.render(canvas)
    canvas:render_buffer(buf, config.element_mapping("scopes"))
  end

  ---@nodoc
  function dapui.elements.scopes.buffer()
    return buf
  end

  return dapui.elements.scopes
end
