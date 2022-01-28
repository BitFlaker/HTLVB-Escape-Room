extends Button

export var bubbleColor := Color(1,1,1)
export var bubbleSize := Vector2(50, 40)
export var bubbleMessage := ""
export var xOffset := 0
var size := Vector2(6080, 5080)
var originalUnfixSize := Vector2(5000, 4000)
var tileScale := Vector2.ZERO

func _ready() -> void:
	$ChatBubbleIcon/Content.set_text(" ")
	$ChatBubbleIcon/Content.set_size(Vector2(bubbleSize.x, 8))
	$ChatBubbleIcon/Content.set_text(bubbleMessage)
	$ChatBubbleIcon/Content.set_size(Vector2(bubbleSize.x, 8))

func ResizeBubble() -> void:
	bubbleSize.y = $ChatBubbleIcon/Content.labelHeight
	rect_min_size = bubbleSize + Vector2(0,20)
	
	$ChatBubbleIcon.scale = Vector2(1, 1)
	tileScale.x = 100/float(getInTens(originalUnfixSize.x))
	tileScale.y = 100/float(getInTens(originalUnfixSize.x))
	size.x = bubbleSize.x + 1080 * tileScale.x
	size.y = bubbleSize.y + 1080 * tileScale.y
	var children =  get_children()
	for c in children:
		if "Bubble" in c.name:
			c.modulate = bubbleColor
	
	# Scaling Corners
	$ChatBubbleIcon/BubbleTopLeft.scale = tileScale
	$ChatBubbleIcon/BubbleTopRight.scale = tileScale * Vector2(-1,1)
	$ChatBubbleIcon/BubbleBottomLeft.scale = tileScale * Vector2(1,-1)
	$ChatBubbleIcon/BubbleBottomRigh.scale = tileScale * Vector2(-1,-1)
	
	# Scaling Connections between Corners
	$ChatBubbleIcon/BubbleTop.scale = Vector2(size.x - (tileScale.x * 1080 * 2), tileScale.x * 1080)
	$ChatBubbleIcon/BubbleBottom.scale = Vector2(size.x - (tileScale.x * 1080 * 2), tileScale.x * 1080)
	$ChatBubbleIcon/BubbleLeft.scale = Vector2(tileScale.y * 1080, size.y - (tileScale.y * 1080 * 2))
	$ChatBubbleIcon/BubbleRight.scale = Vector2(tileScale.y * 1080, size.y - (tileScale.y * 1080 * 2))
	
	# Scaling content rectangle
	$ChatBubbleIcon/BubbleContentRectangle.scale = Vector2(size.x - (tileScale.x * 1080 * 2), size.y - (tileScale.y * 1080 * 2))
	
	# Positioning Connections between Corners
	$ChatBubbleIcon/BubbleTop.position.x = bubbleSize.x/2
	$ChatBubbleIcon/BubbleLeft.position.y = bubbleSize.y/2
	$ChatBubbleIcon/BubbleRight.position = Vector2(bubbleSize.x, bubbleSize.y/2)
	$ChatBubbleIcon/BubbleBottom.position = Vector2(bubbleSize.x/2, bubbleSize.y)
	
	# Positioning Corners
	$ChatBubbleIcon/BubbleTopRight.position.x = bubbleSize.x
	$ChatBubbleIcon/BubbleBottomLeft.position.y = bubbleSize.y
	$ChatBubbleIcon/BubbleBottomRigh.position = bubbleSize
	$ChatBubbleIcon/BubbleContentRectangle.position = bubbleSize / Vector2(2,2)
	
	#Positioning ChatBubble
	$ChatBubbleIcon.position.y = tileScale.y * 1500 / 2
	$ChatBubbleIcon.position.x = tileScale.x * 2000 / 2 + xOffset

func getInTens(num:int) -> int:
	var decs := 1
	while(num > 0):
		num = num / 10
		decs = decs * 10
	return decs
