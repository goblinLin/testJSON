-----------------------------------------------------------------------------------------
--
-- main.lua
-- 本範例示範怎麼進行JSON編碼轉換
-- Author: Zack Lin
-- Time: 2015/4/15
-----------------------------------------------------------------------------------------

--=======================================================================================
--引入各種函式庫
--=======================================================================================
display.setStatusBar( display.HiddenStatusBar )
--需要json library
local json = require('json')
--=======================================================================================
--宣告各種變數
--=======================================================================================
_SCREEN = {
	WIDTH = display.viewableContentWidth,
	HEIGHT = display.viewableContentHeight
}
_SCREEN.CENTER = {
	X = display.contentCenterX,
	Y = display.contentCenterY
}

local t = {
    ["name"] = "江湖小蝦米",
    ["data"] = { 1, false, true, 90.32, "蓋世大俠" },
    weapon = json.null
}
local encoded
local decoded

local decode
local encode
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function (  )
	encoded = encode(t)
	decoded = decode(encoded)

	if (t.data[3] == decoded.data[3]) then
		print('編碼成功')
	else
		print('編碼有問題')
	end
end

--=======================================================================================
--定義其他函式
--=======================================================================================
decode = function(str)
    --將JSON字串轉換為Table
	local aTable = json.decode(str)
	print(aTable)
	return aTable
end

encode = function(table)
	--將Table轉換為JSON字串
	local str_json = json.encode(table)
	print('str_json:' .. str_json)
	return str_json
end
--=======================================================================================
--呼叫主函式
--=======================================================================================
main()

