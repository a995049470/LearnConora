-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local spriteHead = "Resources/Sprites/"

-- 加载和启用物理引擎
local physics = require( "physics" )  
physics.start()
physics.setGravity( 0, 0 )
-- 随机种子
math.randomseed( os.time() )

local sheetOptions = 
{
    frames = 
    {
        {   -- 1) asteroid 1
            x = 0,
            y = 0,
            width = 102,
            height = 85
        },
        {   -- 2) asteroid 2
            x = 0,
            y = 85,
            width = 90,
            height = 83
        },
        {   -- 3) asteroid 3
            x = 0,
            y = 168,
            width = 100,
            height = 97
        },
        {   -- 4) ship
            x = 0,
            y = 265,
            width = 98,
            height = 79
        },
        {   -- 5) laser
            x = 98,
            y = 265,
            width = 14,
            height = 40
        },
    },
}
local objectSheet = graphics.newImageSheet( spriteHead.."gameObjects.png", sheetOptions )

local lives = 3
local score = 0
local died = false

local asteroidTable = {}

local ship
local gameLoopTimer
local livesText
local scoreText

-- 顺序决定层级
local backGroup = display.newGroup()
local mainGroup = display.newGroup()
local uiGroup = display.newGroup()

-- 设置背景和飞船
local background = display.newImageRect( backGroup, spriteHead.."background.png",  800, 1200 )
background.x = display.contentCenterX
background.y = display.contentCenterY
ship = display.newImageRect( mainGroup, objectSheet, 4, 98, 79 )
ship.x = display.contentCenterX
ship.y = display.contentHeight - 100
physics.addBody( ship, { radius = 30, isSensor = true } )
ship.myName = "ship"

-- 放置UI标签
livesText = display.newText( uiGroup, "Lives:"..lives, 200, 80, native.systemFont, 36 )
scoreText = display.newText( uiGroup, "Score:"..score, 400, 80, native.systemFont, 36 )

--屏蔽状态栏
display.setStatusBar( display.HiddenStatusBar )

local function updateText()
    livesText.text = "Lives:"..lives
    scoreText.text = "Score:"..score
end