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
script_name = aegisub.gettext "简单双边框"
script_description = aegisub.gettext "为选中的行添加双边框"
script_author = "Amaki.M (PCC-Studio)"
script_version = "2.4"
dialog_config = {
	{x = 0, y = 0, width = 1, class = "label", label = "字体颜色"},
	{x = 1, y = 0, width = 1, class = "color", name = "lyrt1c"},
	{x = 2, y = 0, width = 1, class = "label", label = "字体大小"},
	{x = 3, y = 0, width = 1, class = "floatedit", name = "fs"},
	{x = 0, y = 1, width = 1, class = "label", label = "内框颜色"},
	{x = 1, y = 1, width = 1, class = "color", name = "lyrt3c"},
	{x = 2, y = 1, width = 1, class = "label", label = "内框尺寸"},
	{x = 3, y = 1, width = 1, class = "floatedit", name = "lyrtbd"},
	{x = 0, y = 2, width = 1, class = "label", label = "外框颜色"},
	{x = 1, y = 2, width = 1, class = "color", name = "lyrb3c"},
	{x = 2, y = 2, width = 1, class = "label", label = "外框尺寸"},
	{x = 3, y = 2, width = 1, class = "floatedit", name = "lyrbbd"},
	{x = 0, y = 3, width = 1, class = "label", label = "绝对定位"},
	{x = 1, y = 3, width = 1, class = "edit", name = "pos", text = "540,960", hint = "绝对定位,默认取视频中央\n格式为x,y,支持浮点值"},
	{x = 2, y = 3, width = 1, class = "label", label = "边缘模糊"},
	{x = 3, y = 3, width = 1, class = "floatedit", name = "blur"},
	{x = 0, y = 4, width = 2, class = "label", label = "简单双边框 By Amaki.M"},
	{x = 2, y = 4, width = 1, class = "label", label = "版本Ver" .. script_version}
}

function double_border(subs, sel)
	xres, yres = aegisub.video_size()
	dialog_config[14].text = xres / 2 .. "," .. yres / 2
	btn, res = aegisub.dialog.display(dialog_config, {"OK", "Cancel"}, {ok = "OK", cancel = "Cancel"})
	if btn then
		lyrtsty =
			"{\\pos(" ..
			res.pos ..
				")\\1c" ..
					res.lyrt1c:gsub("#(%x%x)(%x%x)(%x%x)", "&H%3%2%1&") ..
						"\\3c" ..
							res.lyrt3c:gsub("#(%x%x)(%x%x)(%x%x)", "&H%3%2%1&") ..
								"\\fs" .. res.fs .. "\\bord" .. res.lyrtbd .. "\\shad0\\blur0}"
		lyrbsty =
			"{\\pos(" ..
			res.pos ..
				")\\3c" ..
					res.lyrb3c:gsub("#(%x%x)(%x%x)(%x%x)", "&H%3%2%1&") ..
						"\\bord" .. res.lyrbbd .. "\\fs" .. res.fs .. "\\blur" .. res.blur .. "\\shad0}"

		for z = #sel, 1, -1 do
			i = sel[z]

			linet = subs[i]
			linet.layer = linet.layer + 1
			linet.text = lyrtsty .. linet.text
			subs.insert(i + 1, linet)

			lineb = subs[i]
			lineb.text = lyrbsty .. lineb.text
			subs[i] = lineb
		end
	end
end

aegisub.register_macro(script_name, script_description, double_border)
