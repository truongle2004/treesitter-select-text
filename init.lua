local ts_utils = require("nvim-treesitter.ts_utils")
local api = vim.api
local M = {}

local function t(value)
	print(vim.inspect(value))
end

local get_master_node = function()
	local node = ts_utils.get_node_at_cursor()
	if node == nil then
		error("No Treesitter parser found")
	end

	local start_row = node:start()
	local parent = node:parent()

	while parent ~= nil and parent:start() == start_row do
		node = parent
		parent = node:parent()
	end

	return node
end

M.select = function()
	local node = get_master_node()
	local bufnr = api.nvim_get_current_buf()
	ts_utils.update_selection(bufnr, node)
end

return M
