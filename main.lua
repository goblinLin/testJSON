-----------------------------------------------------------------------------------------
--
-- main.lua
-- 本範例示範怎麼進行JSON編碼轉換與URL Request
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
local codeCheck
local networkListener
--=======================================================================================
--宣告與定義main()函式
--=======================================================================================
local main = function (  )
	encoded = encode(t) 
	decoded = decode(encoded)
	codeCheck()

	--測試無參數WebService
	wsRequest("http://headers.jsontest.com/" , nil , nil , nil , "GET" , networkListener )
	--測試帶參數WebService
	wsRequest("http://validate.jsontest.com/" , nil , nil , {json="%7Bname:zack%7D"} , "GET" , networkListener)
end

--=======================================================================================
--定義其他函式
--=======================================================================================
--將JSON字串轉換為Table
decode = function(str)
	local aTable = json.decode(str)
	print(aTable)
	return aTable
end

--將Table轉換為JSON字串
encode = function(table)
	local str_json = json.encode(table)
	print('str_json:' .. str_json)
	return str_json
end

--編碼檢查
codeCheck = function (  )
	if (t.data[3] == decoded.data[3]) then
		print('編碼成功')
	else
		print('編碼有問題')
	end
end

--網路偵聽器
networkListener = function ( event  )
	if ( event.isError ) then
    	print( "Network error!" )
    else
        print("Response:" .. event.response)
        local data = decode( event.response )
    	printTable( data )
    end
end

--對WebService進行Request
function wsRequest( ws_url , headers , body , params , method , networkListener)
	local headers = {}
	headers["Content-Type"] = "application/x-www-form-urlencoded"
	headers["Accept-Language"] = "zh-TW"
	if (method == "POST") then
		params = {}
		params.headers = headers
		params.body = body 
	end
	--print("body:" .. body)
	if ( method == "GET" ) then
		local _wsUrl = ws_url
		if ( params ) then
			_wsUrl = _wsUrl .. "?"
			for k, v in pairs(params) do
				_wsUrl = _wsUrl .. k .. "=" .. v
			end
		end
		print("_wsUrl:" .. _wsUrl)
		network.request( _wsUrl , method, networkListener )
	elseif ( method == "POST") then
		network.request( ws_url , method, networkListener, params )
	end
	
end

--將Table的所有Property都印出來
function printTable( theTable )
	print("Table length:" .. #theTable)
	for k, v in pairs( theTable ) do
	   print(k, v)
	end
end
--=======================================================================================
--呼叫主函式
--=======================================================================================
main()

