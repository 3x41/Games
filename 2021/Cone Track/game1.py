from random import randint
import pgzrun

TITLE = "Cone Track"
WIDTH = 700
HEIGHT = 600
SPEED = 1
car = Actor("car", center=(300, 300))
CourseTime = 0
cardir = 1
car.pos = 250, 400
TodaysBestScore = 0
trackLeft = []
trackRight = []
trackCount = 0
trackPosition = 250
trackWidth = 120
trackDirection = False
gameStatus = 3
Invins = False
InvState = False
MyScore = 0
TrackLengh = 500


def Reset():
    global trackLeft, trackRight, trackCount, trackPosition, trackWidth, trackDirection, gameStatus, CourseTime, SPEED, car, MyScore
    SPEED = 1
    trackLeft.clear()
    trackRight.clear()
    trackCount = 0
    trackPosition = 250
    trackWidth = 120
    trackDirection = False
    car.pos = 250, 400
    CourseTime = 0
    makeTrack()
    gameStatus = 0
    MyScore = 0


def draw():
    # InvTimer = 0
    global gameStatus, cardir, trackCount, CourseTime, MyScore
    # screen.clear()
    screen.fill((128, 128, 128))
    if gameStatus == 0:
        if Invins == False:
            car.draw()
        b = 0
        while b < len(trackLeft):
            trackLeft[b].draw()
            trackRight[b].draw()
            b += 1
    if gameStatus == 1 or gameStatus == 3:
        screen.blit("rflag", (0, 0))
        screen.draw.text("Score", (70, 150), color="black")
        screen.draw.text(str(MyScore), (70, 180), fontsize=72, color="orange")
        screen.draw.text("Todays Best ", (500, 150), color="black")
        screen.draw.text(str(TodaysBestScore), (500, 180), fontsize=72, color="orange")
    if gameStatus == 2:
        screen.blit("cflag", (0, 0))
        screen.draw.text("Score", (70, 150), color="black")
        screen.draw.text(str(MyScore), (70, 180), fontsize=72, color="orange")
        screen.draw.text("Todays Best ", (500, 150), color="black")
        screen.draw.text(str(TodaysBestScore), (500, 180), fontsize=72, color="orange")

    RED = 200, 0, 0
    BOX = Rect((10, 10), (680, 50))
    screen.draw.filled_rect(BOX, RED)
    screen.draw.text("Distance   " + str(trackCount), (30, 30), color="orange")
    screen.draw.text(
        "               Speed     " + str(round(SPEED, 2)), (230, 30), color="orange"
    )
    screen.draw.text(
        "                          Time        " + str(round(CourseTime, 2)),
        (430, 30),
        color="orange",
    )


def update(dt):
    global gameStatus, trackCount, cardir, SPEED, InvState, CourseTime, TodaysBestScore, TrackLengh, MyScore
    t = 0
    #   pos = (90,90)
    if gameStatus == 0:
        CourseTime += dt

        if t < 500 * dt and Invins == False:
            InvState = True
        else:
            InvState = False
        car.image = "car"
        if keyboard.left and trackCount > 4:
            car.x -= 2
            car.image = "carleft"
            # car.angle_to(pos)
        if keyboard.right and trackCount > 4:
            car.x += 2
            car.image = "carright"
        if keyboard.up:
            SPEED += 0.1
        if keyboard.down:
            if SPEED > 0.5:
                SPEED -= 0.1
        updateTrack()
    if trackCount > TrackLengh:
        gameStatus = 2
        MyScore = round((trackCount * round(CourseTime, 2) - round(SPEED, 2)), 1)
        if float(MyScore) > float(TodaysBestScore):
            TodaysBestScore = str(MyScore)
        if keyboard.space:
            Reset()

    if gameStatus == 1 or gameStatus == 3:
        # Game Over
        if keyboard.space:
            Reset()


def makeTrack():
    global trackCount, trackPosition, trackWidth, trackLeft, trackRight
    trackLeft.append(Actor("cone", pos=(trackPosition - trackWidth, 0)))
    trackRight.append(Actor("cone", pos=(trackPosition + trackWidth, 0)))
    trackCount += 1


def updateTrack():
    global trackCount, trackPosition, trackWidth, trackDirection, gameStatus, TodaysBestScore, CourseTime, SPEED, MyScore
    b = 0
    while b < len(trackLeft):
        if Invins == False:
            if car.colliderect(trackLeft[b]) or car.colliderect([trackRight[b]]):
                MyScore = round(
                    (trackCount * round(CourseTime, 2) - round(SPEED, 2)), 1
                )
                if float(MyScore) > float(TodaysBestScore):
                    TodaysBestScore = str(MyScore)
                gameStatus = 1
        trackLeft[b].y += SPEED
        trackRight[b].y += SPEED
        b += 1
    if trackLeft[len(trackLeft) - 1].y > 64:  # default 32 gap between cones
        if trackDirection == False:
            trackPosition += 16
        if trackDirection == True:
            trackPosition -= 16
        if randint(0, 4) == 1:
            trackDirection = not trackDirection
        if trackPosition > 700 - trackWidth:
            trackDirection = True
        if trackPosition < trackWidth:
            trackDirection = False
        makeTrack()


makeTrack()

pgzrun.go()
