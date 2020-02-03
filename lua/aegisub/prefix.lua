--[[
Copyright (c) 2019 PCC-Studio

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
associated documentation files (the "Software"), to deal in the Software without restriction, 
including without limitation the rights to use, copy, modify, merge, publish, distribute, 
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial 
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT 
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN 
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]
script_name = aegisub.gettext "添加内容到选中的行首"
script_description = aegisub.gettext "添加内容到选中的行首"
script_author = "Amaki.M (PCC-Studio)"
script_version = "1.2"

dialog_config = {
	{class = "edit", name = "prefix", width = 15, height = 5, items = {}, value = ""}
}

function add_prefix(subtitles, selected_lines, active_line)
	btn, res = aegisub.dialog.display(dialog_config, {"OK", "Cancel"}, {ok = "OK", cancel = "Cancel"})
	if btn then
		local prefix = res["prefix"]
		for z, i in ipairs(selected_lines) do
			local l = subtitles[i]
			l.text = prefix .. l.text
			subtitles[i] = l
		end
		aegisub.set_undo_point(script_name)
	end
end

aegisub.register_macro(script_name, script_description, add_prefix)
