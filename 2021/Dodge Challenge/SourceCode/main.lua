--TODO

-- Sprite overlay layers not correct - part done
-- sfx
-- partical effects
-- screen shake, flash when hit

--DONE
-- start is always the same 3 vans in line 
-- debug mode
-- game speed in debug and increses 
-- menu screen
-- gameover - game stat needed
-- collison checking -half
-- font
-- music and looping

--GameStatus
-- 1 Menu
-- 2 Game
-- 3 Crash / life
-- 4 GameOver
-- 5 restart game


function love.load()
  
  GameMusic = love.audio.newSource("stonefortress.ogg","static")
  
  MenuMusic = love.audio.newSource("TremLoadingloopl.wav","static")
  
  MenuSFX1 = love.audio.newSource("menu.wav","static")
  MenuSFX2 = love.audio.newSource("menu.wav","static")
  GameOverSFX = love.audio.newSource("gameover.wav","static")
  CrashSFX = love.audio.newSource("crash.flac","static")
  
  font = love.graphics.newFont("Font.ttf", 24)
  fonttitle = love.graphics.newFont("Font.ttf", 54)
  FontSmall = love.graphics.newFont("Font.ttf", 10)
  
  Debugging = false

  --love.window.setMode(600,600)
  
  Road_Sprite = love.graphics.newImage("images/RoadMain.png")
  GameSpeed = 1
  GameStatus = 1
  MenuOptionSelected = 1
  CurrentSpeed = GameSpeed
  
  RestartSettings()
  
  TodaysHighScore = 0
  love.audio.play(MenuMusic)
  MenuMusic:setLooping(true)
end

function RestartSettings()
  Player = {}
  Player["Sprite"] = love.graphics.newImage("images/Player.png")
  Player["OrgX"] = 100 -- Orginal Setting
  Player["OrgY"] = 380 -- Orginal Setting
  Player["X"] = 100
  Player["Y"] = 380
  Player["Score"] = 0
  Player["Life"] = 3
  Player["Crash"] = false
  
  Top_Tree = {}
  Top_Tree["Sprite"] = love.graphics.newImage("images/Tree.png")
  Top_Tree["X"] = 600
  Top_Tree["Y"] = -75
  Top_Tree["Ran"] = math.random(3000)
  Top_Tree["Speed"] = 0.5
  
  Bottom_Tree = {}
  Bottom_Tree["Sprite"] = love.graphics.newImage("images/Tree.png")
  Bottom_Tree["X"] = 600
  Bottom_Tree["Y"] = 180
  Bottom_Tree["Ran"] = math.random(3000)
  Bottom_Tree["Speed"] = 0.5
  
  
  Van1 = {}
  Van1["Sprite"] = love.graphics.newImage("images/Van.png")
  Van1["X"] = 650
  Van1["Y"] = -5555
  Van1["oX"] = 650
  Van1["oY"] = -100 
  Van1["Ran"] = math.random(3000)
  
  Van2 = {}
  Van2["Sprite"] = love.graphics.newImage("images/Van.png")
  Van2["X"] = 650
  Van2["Y"] = -5555
  Van2["oX"] = 650
  Van2["oY"] = -50
  Van2["Ran"] = math.random(3000)
  
  Van3 = {}
  Van3["Sprite"] = love.graphics.newImage("images/Van.png")
  Van3["X"] = 650
  Van3["Y"] = -5555
  Van3["oX"] = 650
  Van3["oY"] = 0
  Van3["Ran"] = math.random(3000)
  
  Explo = {}
  Explo["Sprite"] = love.graphics.newImage("images/Explosion/explosion00.png") --images/Explosion/explosion00.png --images/Smoke/Smoke.png
  Explo["X"] = 0
  Explo["Y"] = 0
  
  
end


function love.update(dt)
 
 if GameStatus == 4 then --Game Over
  --if love.keyboard.isDown("space") then
  GameOverSFX:play()
  
    love.timer.sleep( 2)
    
    if Player["Score"] > TodaysHighScore then
      TodaysHighScore = Player["Score"]
    end
    
   RestartSettings()
   GameStatus = 1
   GameSpeed = 1
   
 
 --end
 end
 
 
if GameStatus == 3 then --crash
  --love.timer.sleep( 2)
--  if love.keyboard.isDown("space") then
    
    CurrentScore = Player["Score"]
    CurrentLife = Player["Life"]
    CrashSFX:play()
    
    RestartSettings()
    
    Player["Score"] = CurrentScore
    Player["Life"] = CurrentLife
    GameSpeed = CurrentSpeed
    GameStatus = 2
 -- end
  
end

 
  if GameStatus == 1 then
    if love.keyboard.isDown("up") then
      if MenuOptionSelected == 2 then
        MenuOptionSelected = 1
        MenuSFX1:play()
        
      end
    end

    if love.keyboard.isDown("down") then
      if MenuOptionSelected == 1 then
        MenuOptionSelected = 2
        MenuSFX2:play()
      end
    end
    if love.keyboard.isDown("d") then
      if Debugging == false then
        Debugging = true
        love.timer.sleep(2)
      else
        Debugging = false
        love.timer.sleep(2)
      end
      
    end
    
    if love.keyboard.isDown("space") then
      if MenuOptionSelected == 1 then
        RestartSettings()
        GameStatus = 2
        love.audio.stop(MenuMusic)
        love.audio.play(GameMusic)
        GameMusic:setLooping(true)
      else
        --quit game
        love.event.quit()
      end
    end
  end
  
  
  
  if GameStatus == 2 then -- game playing

  if love.keyboard.isDown("up") and Debugging == true then
    GameSpeed = GameSpeed + 1
  end

  if love.keyboard.isDown("down") and Debugging == true then
      GameSpeed = GameSpeed - 1

  end


  if love.keyboard.isDown("left") and Player["X"] > 1 then
    Player["Y"] = Player["Y"] - 2
    Player["X"] = Player["X"] - 2
  end
  if love.keyboard.isDown("right") and Player["X"] < 190 then
    Player["Y"] = Player["Y"] + 2
    Player["X"] = Player["X"] + 2
  end  
end

  if Top_Tree["X"] > (-75 - Top_Tree["Ran"]) and Top_Tree["Y"] < 600 then
    Top_Tree["X"] = Top_Tree["X"] - 2 * Top_Tree["Speed"] * GameSpeed
    Top_Tree["Y"] = Top_Tree["Y"] + 1 * Top_Tree["Speed"] * GameSpeed
  else
    Top_Tree["X"] = 600
    Top_Tree["Y"] = -75
    Top_Tree["Ran"] = math.random(3000)
    if GameStatus == 2 then
      Player["Score"] = Player["Score"] + 1
    end
--    GameSpeed = GameSpeed + 0.1
  end

  if Bottom_Tree["X"] > (-75 - Bottom_Tree["Ran"]) and Bottom_Tree["Y"] < 600 then
    Bottom_Tree["X"] = Bottom_Tree["X"] - 2 * Bottom_Tree["Speed"] * GameSpeed
    Bottom_Tree["Y"] = Bottom_Tree["Y"] + 1 * Bottom_Tree["Speed"] * GameSpeed
  else
    Bottom_Tree["X"] = 600
    Bottom_Tree["Y"] = 180
    Bottom_Tree["Ran"] = math.random(3000)
    if GameStatus == 2 then 
      Player["Score"] = Player["Score"] + 1
    end
--    GameSpeed = GameSpeed + 0.1
  end

--Vans

  if Van1["X"] > (-200 - Van1["Ran"]) and Van1["Y"] < 600 then
    Van1["X"] = Van1["X"] - 2 * GameSpeed
    Van1["Y"] = Van1["Y"] + 1 * GameSpeed
  else
    Van1["X"] = Van1["oX"]
    Van1["Y"] = Van1["oY"]
    Van1["Ran"] = math.random(3000)
    if GameStatus == 2 then
      Player["Score"] = Player["Score"] + 1
      GameSpeed = GameSpeed + 0.05
    end
  end

  if Van2["X"] > (-200 - Van2["Ran"]) and Van2["Y"] < 600 then
    Van2["X"] = Van2["X"] - 2 * GameSpeed 
    Van2["Y"] = Van2["Y"] + 1 * GameSpeed
  else
    Van2["X"] = Van2["oX"]
    Van2["Y"] = Van2["oY"]
    Van2["Ran"] = math.random(3000)
    if GameStatus == 2 then
      Player["Score"] = Player["Score"] + 1
      GameSpeed = GameSpeed + 0.05
    end
  end
  
  if Van3["X"] > (-200 - Van3["Ran"]) and Van3["Y"] < 600 then
    Van3["X"] = Van3["X"] - 2 * GameSpeed 
    Van3["Y"] = Van3["Y"] + 1 * GameSpeed
  else
    Van3["X"] = Van3["oX"]
    Van3["Y"] = Van3["oY"]
    Van3["Ran"] = math.random(3000)
    if GameStatus == 2 then
      Player["Score"] = Player["Score"] + 1
      GameSpeed = GameSpeed + 0.05
    end
  end

if Player["Life"] == 0 then
  
  GameStatus = 4
  love.audio.stop(GameMusic)
  love.audio.play(MenuMusic)
  MenuMusic:setLooping(true)
end

  if GameStatus == 2 and Player["Life"] > 0 then
    Player["Crash"] = false
    -- Check for hits
    if CheckForCollisions() then
    CurrentSpeed = GameSpeed
    GameSpeed = 0

      if Player["Life"] > 0 then
      Player["Life"] = Player["Life"] -1
      --Player["Y"] = 0
      --Player["Crash"] = true
      GameStatus = 3
      --play SFX
      
      --delay then continue
      
     --wait for key to continue then mini reset car,trees and vans
      else
      --end game
      --Player["Life"] = "DEAD"
      
      end
  end
end

end

function love.draw()
  
  love.graphics.setColor(0,0,1,0.2) --rgba
 love.graphics.rectangle("fill", 0,0,600,600)
 

 
 
  love.graphics.setColor(1,1,1) --rgba

if Debugging == false then
  
  love.graphics.setFont(font)
 end
 
  --Road Background
  love.graphics.draw(Road_Sprite,0,0)
  
  
  love.graphics.draw(Top_Tree["Sprite"],Top_Tree["X"],Top_Tree["Y"])
  
  
  love.graphics.draw(Van1["Sprite"],Van1["X"],Van1["Y"])
  
    --Player
  love.graphics.draw(Player["Sprite"],Player["X"],Player["Y"])
  
  
 
  --Vans
  
  
  if GameStatus ~= 1 then
    love.graphics.draw(Van2["Sprite"],Van2["X"],Van2["Y"])
  end
  love.graphics.draw(Van3["Sprite"],Van3["X"],Van3["Y"])
 
 --Trees to show speed
  
  love.graphics.draw(Bottom_Tree["Sprite"],Bottom_Tree["X"],Bottom_Tree["Y"])
  

if GameStatus == 3 then
 love.graphics.draw(Explo["Sprite"],Player["X"]+30,Player["Y"]-40,0,0.2,0.2)
 
end

  
  if Debugging == true then
    DebugMode()
  end
  
  love.graphics.print("Player Score : " .. tostring(Player["Score"]), 10,40)
  love.graphics.print("Player Life : " .. tostring(Player["Life"]), 10,70)

  love.graphics.print("Todays High Score : " .. tostring(TodaysHighScore), 10,10,0)
  
  
  --hit
  if Player["Crash"] == true then

    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", 0,0,10,10)
  end

  if GameStatus == 1 then
    MenuDraw()  
  end


end

function MenuDraw()
  love.graphics.setColor(1,1,1,0.5) --rgba
  if MenuOptionSelected == 1 then
    love.graphics.rectangle("fill",180,280,200,70)
    love.graphics.rectangle("line",180,380,200,70)
  else
    love.graphics.rectangle("line",180,280,200,70)
    love.graphics.rectangle("fill",180,380,200,70)
    
  end
  
  love.graphics.rectangle("fill",0,180,600,80)
  love.graphics.setColor(0,0,0) --rgba
  if Debugging == false then
  
love.graphics.setFont(fonttitle)
else
love.graphics.setFont(FontSmall)

  end
  love.graphics.print("Dodge Challenge",80,195,0)
  love.graphics.setColor(0,0,0) --rgba
if Debugging == false then
  
love.graphics.setFont(font)
  end
  love.graphics.print("        Play",200,300,0)
  love.graphics.print("        Exit",200,400,0)
  
  love.graphics.setColor(1, 1, 1) --rgba
  if Debugging == false then
  
  love.graphics.setFont(FontSmall)
  end
  love.graphics.print("Controls:   Use the arrow keys and spacebar.               Aim is to Avoid everything!",100,570)
 love.graphics.print("Coded by Alex Garwood 2021, WWW.3X41.UK",170,590)
 love.graphics.print("Debugging Mode:" .. tostring(Debugging),470,10)
 
 
 if Debugging == false then
  
  love.graphics.setFont(font)
end

end

function CheckForCollisions()

Results = false
--Player
PlayerCheck = {Player["X"] + 30,Player["Y"] + 2,45,25}

--Trees
TopTreeCheck = {Top_Tree["X"]+10,Top_Tree["Y"]+90,30,40}
BottomTreeCheck = {Bottom_Tree["X"]+10,Bottom_Tree["Y"]+110,50,30}

if Results == false then
Results = CheckCollision(PlayerCheck[1],PlayerCheck[2],PlayerCheck[3],PlayerCheck[4],TopTreeCheck[1],TopTreeCheck[2],TopTreeCheck[3],TopTreeCheck[4])
end

if Results == false then
Results = CheckCollision(PlayerCheck[1],PlayerCheck[2],PlayerCheck[3],PlayerCheck[4],BottomTreeCheck[1],BottomTreeCheck[2],BottomTreeCheck[3],BottomTreeCheck[4])
end

--Van1
Van1Check = {Van1["X"]+100,Van1["Y"]+125,25,25}
Van2Check = {Van2["X"]+100,Van2["Y"]+125,25,25}
Van3Check = {Van3["X"]+100,Van3["Y"]+125,25,25}

if Results == false then
Results = CheckCollision(PlayerCheck[1],PlayerCheck[2],PlayerCheck[3],PlayerCheck[4],Van1Check[1],Van1Check[2],Van1Check[3],Van1Check[4])
end

if Results == false then
Results = CheckCollision(PlayerCheck[1],PlayerCheck[2],PlayerCheck[3],PlayerCheck[4],Van2Check[1],Van2Check[2],Van2Check[3],Van2Check[4])
end

if Results == false then
Results = CheckCollision(PlayerCheck[1],PlayerCheck[2],PlayerCheck[3],PlayerCheck[4],Van3Check[1],Van3Check[2],Van3Check[3],Van3Check[4])
end

  return Results
end



function DebugMode()
  
     
  --Debug Lines
  love.graphics.setColor(1, 1, 1,0.2) --rgba
  love.graphics.line(50,0,50,600)
  love.graphics.line(100,0,100,600)
  love.graphics.line(150,0,150,600)
  love.graphics.line(200,0,200,600)
  love.graphics.line(250,0,250,600)
  love.graphics.line(300,0,300,600)
  love.graphics.line(350,0,350,600)
  love.graphics.line(400,0,400,600)
  love.graphics.line(450,0,450,600)
  love.graphics.line(500,0,500,600)
  love.graphics.line(550,0,550,600)
  
  love.graphics.line(0,50,600,50)
  love.graphics.line(0,100,600,100)
  love.graphics.line(0,150,600,150)
  love.graphics.line(0,200,600,200)
  love.graphics.line(0,250,600,250)
  love.graphics.line(0,300,600,300)
  love.graphics.line(0,350,600,350)
  love.graphics.line(0,400,600,400)
  love.graphics.line(0,450,600,450)
  love.graphics.line(0,500,600,500)
  love.graphics.line(0,550,600,550)
  
  love.graphics.setColor(1, 0, 0) --rgba
  local mousex = love.mouse.getX()
  love.graphics.line(mousex,0, mousex,600)
  local mousey = love.mouse.getY()
  love.graphics.line(0,mousey, 600,mousey)

  love.graphics.print("Mouse X : " .. tostring(mousex), 400,10)
  love.graphics.print("Mouse Y : " .. tostring(mousey), 400,20)
  
  
  --coll testing rects
  love.graphics.setColor(0, 0, 1)
  love.graphics.rectangle("fill",Player["X"]+30,Player["Y"]+2,45,25) --player
  love.graphics.rectangle("fill",Top_Tree["X"]+10,Top_Tree["Y"]+90,30,40) --top tree
  love.graphics.rectangle("fill",Bottom_Tree["X"]+10,Bottom_Tree["Y"]+110,50,30) --bottom tree
  
  love.graphics.rectangle("fill",Van1["X"]+100,Van1["Y"]+125,25,25) --bottom tree
  if GameStatus == 2 then
    love.graphics.rectangle("fill",Van2["X"]+100,Van2["Y"]+125,25,25) --bottom tree
  end
  love.graphics.rectangle("fill",Van3["X"]+100,Van3["Y"]+125,25,25) --bottom tree
  
  
  love.graphics.setColor(1, 1, 1)
  
  --Debug Info
  love.graphics.print("Player X : " .. tostring(Player["X"]), 200,10)
  love.graphics.print("Player Y : " .. tostring(Player["Y"]), 200,20)
  
  love.graphics.print("Top Tree X : " .. tostring(Top_Tree["X"]), 200,30)
  love.graphics.print("Top Tree Y : " .. tostring(Top_Tree["Y"]), 200,40)
  love.graphics.print("Bottom Tree X : " .. tostring(Bottom_Tree["X"]), 200,50)
  love.graphics.print("Bottom Tree Y : " .. tostring(Bottom_Tree["Y"]), 200,60)
  love.graphics.print("Game Speed : " .. tostring(GameSpeed), 200,90)
  love.graphics.print("Game Status : " .. tostring(GameStatus), 200,100)
end

-- Collision detection function;
-- Returns true if two boxes overlap, false if they don't;
-- x1,y1 are the top-left coords of the first box, while w1,h1 are its width and height;
-- x2,y2,w2 & h2 are the same, but for the second box.
function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end
