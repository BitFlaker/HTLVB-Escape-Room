/**
 * Reads Content from some file
 * @param {string} filename and path from file to read
 */
function loadFile(filePath) {
	var result = null;
	var xmlhttp = new XMLHttpRequest();
	xmlhttp.open("GET", filePath, false);	
	xmlhttp.send();
	if (xmlhttp.status==200) {
		result = xmlhttp.responseText;
	}
	return result;
}

/**
 * creates a HTML-element add adds it to the dom
 * @param {string} element The Elementtype to create
 * @param {HTMLElement} parent The parent element
 * @param {[{key: string, val: string}]} style The style of the element
 * @param {[{key: string, val: any}]} attributes The style of the element
 * @returns {HTMLElement} The created Element
 */
function createElemt(elemntType, parent, style, attributes) {
    var element = document.createElement(elemntType)
    if (style)
        for (i = 0; i < style.length; i++)
            element.style[style[i].key] = style[i].val

    if (attributes)
        for (i = 0; i < attributes.length; i++)
            element[attributes[i].key] = attributes[i].val

    parent.appendChild(element)
    return element
}

/**
 * Opens an embedded video
 * @param {string} videoUrl The videoPath of the page
 * @param {int} vidPosX The x position of the video
 * @param {int} vidPosY The y position of the video
 * @param {int} vidSizeX The width of the video
 * @param {int} vidSizeY The height of the video
 * @param {int} gameWidth The width of the game
 * @param {int} gameHeight The height of the game
 * @param {string} enableControls Sets if xontrols should be shown
 * @param {string} enableAutoplay Sets if the video should play automatically
 * @param {string} videoPlayerID Sets the id for the videoplayer element
 * @param {string} videoFormatType Defines the type of the video (for example mp4 or webm)
 */
function showVideo(videoUrl, vidPosX, vidPosY, vidSizeX, vidSizeY, gameWidth, gameHeight, enableControls, enableAutoplay, videoPlayerID, videoFormatType) {
	let aspectDivision = gameWidth / gameHeight
	let posXPercentage = vidPosX / gameWidth
	let posYPercentage = vidPosY / gameHeight
	let widthPercentage = vidSizeX / gameWidth
	let heightPercentage = vidSizeY / gameHeight
    let tobBarHeight = 0
    let tobBarMarginBottom = 0
	let ratio = window.innerWidth / window.innerHeight
    let posY = -(window.innerHeight-(window.innerHeight*posYPercentage))
	if (ratio < aspectDivision)
		posY = -((window.innerWidth/aspectDivision) - ((window.innerWidth/aspectDivision)*posYPercentage))-((window.innerHeight-(window.innerWidth/aspectDivision))/2)
    let posX = window.innerWidth * posXPercentage
	if (ratio > aspectDivision)
		posX = (aspectDivision * window.innerHeight * posXPercentage) + ((window.innerWidth-(aspectDivision*window.innerHeight))/2)
	
	let wd = widthPercentage * window.innerWidth
	if(ratio > aspectDivision)
		wd = aspectDivision * window.innerHeight * widthPercentage
	let hg = heightPercentage * window.innerHeight
	if(ratio < aspectDivision)
		hg = window.innerWidth / aspectDivision * heightPercentage

	let enableAP = ""
	let enableCtrls = ""
	if (enableControls === "true")
		enableCtrls = " "
	if (enableAutoplay === "true")
		enableAP = " "

    let vidContainer = createElemt('video', document.body, [
        { key: 'width', val: wd + 'px' },
        { key: 'height', val: hg + 'px' },
        { key: 'z-index', val: "3" },
        { key: 'position', val: "relative" },
        { key: 'float', val: "left" },
        { key: 'margin-top', val: posY + 'px' },
        { key: 'margin-left', val: posX + 'px' },
    ], [
		{ key: "id", val: videoPlayerID },
		{ key: "controls", val: enableCtrls },
		{ key: "autoplay", val: enableAP },
	])
	
	let sourceVid = createElemt('source', vidContainer, [
    ], [
        { key: "id", val: "sourceVid" },
        { key: 'src', val: videoUrl },
        { key: 'type', val: 'video/' + videoFormatType },
    ])
	
	if (!videoPlayerID.includes("KEEPVID")){
		vidContainer.addEventListener("ended", () => {
			document.body.removeChild(vidContainer)
		})
	}

    window.addEventListener("resize", () => {
		let ratio = window.innerWidth / window.innerHeight
		let posY = -(window.innerHeight-(window.innerHeight*posYPercentage))
		if (ratio < aspectDivision)
			posY = -((window.innerWidth/aspectDivision) - ((window.innerWidth/aspectDivision)*posYPercentage))-((window.innerHeight-(window.innerWidth/aspectDivision))/2)
		let posX = window.innerWidth * posXPercentage
		if (ratio > aspectDivision)
			posX = (aspectDivision * window.innerHeight * posXPercentage) + ((window.innerWidth-(aspectDivision*window.innerHeight))/2)
		
		
		let wd = widthPercentage * window.innerWidth
		if(ratio > aspectDivision)
			wd = aspectDivision * window.innerHeight * widthPercentage
		let hg = heightPercentage * window.innerHeight
		if(ratio < aspectDivision)
			hg = window.innerWidth / aspectDivision * heightPercentage
        vidContainer.style.marginTop = posY + 'px'
        vidContainer.style.marginLeft = posX + 'px'
        vidContainer.style.width = wd + 'px'
        vidContainer.style.height = hg + 'px'
    })
}

/**
 * Opens a closeable embedded HTML-page
 * @param {string} title The of the page
 * @param {string} url The url of the page
 */
function showWebsite(title, url) {
    let tobBarHeight = 30
    let tobBarMarginBottom = 0

    let container = createElemt('div', document.body, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: "100vh"
        },
        {
            key: 'position',
            val: "absolute"
        },
        {
            key: "top",
            val: "0px"
        },
        {
            key: "text-align",
            val: "left"
        },
        {
            key: "background",
            val: "lightgrey"
        },
        {
            key: "overflow",
            val: "hidden"
        },
    ], [{
        key: "id",
        val: "container"
    }, ])

    var loadingTextFontSize = Math.floor(tobBarHeight * 1.5)
    var loadingTextTop = window.innerHeight / 2
    if (loadingTextTop < tobBarHeight) loadingTextTop = loadingTextTop
    let loadingTextContainer = createElemt('div', container, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "align-items",
            val: "center"
        },
        {
            key: "justify-content",
            val: "center"
        },
        {
            key: "pointer-events",
            val: "none"
        },
        {
            key: "display",
            val: "flex"
        },
    ], )

    let loadingText = createElemt('div', loadingTextContainer, [{
            key: 'position',
            val: "absolute"
        },
        {
            key: "top",
            val: loadingTextTop + "px"
        },
        {
            key: "font-size",
            val: loadingTextFontSize - 4 + 'px'
        },
        {
            key: "overflow",
            val: "hidden"
        },
        {
            key: "z-positon",
            val: "-1"
        },
        {
            key: "padding",
            val: "10px"
        },
        {
            key: "border-radius",
            val: "10px"
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "background",
            val: "white"
        },
    ], [{
            key: "innerText",
            val: "Lädt..."
        },
        {
            key: "id",
            val: "loadingText"
        },
    ])

    let topBar = createElemt('div', container, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: tobBarHeight + 'px'
        },
        {
            key: "margin-bottom",
            val: tobBarMarginBottom + 'px'
        },
    ])

    let titel = createElemt('h1', topBar, [{
            key: "border",
            val: "none"
        },
        {
            key: "display",
            val: "inline"
        },
        {
            key: "font-size",
            val: tobBarHeight - 4 + 'px'
        },
        {
            key: "margin-left",
            val: '2px'
        },
        {
            key: "font-family",
            val: "sans-serif"
        },
    ], [{
        key: "innerText",
        val: title
    }, ])

    let closeButton = createElemt('img', topBar, [{
            key: "width",
            val: tobBarHeight + 'px'
        },
        {
            key: "height",
            val: tobBarHeight + 'px'
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "position",
            val: "absolute"
        },
        {
            key: "right",
            val: "0px"
        },
    ], [{
            key: "src",
            val: "/close.png"
        },
        {
            key: "onclick",
            val: () => {
                container.parentElement.removeChild(document.getElementById(container.id))
            }
        },
    ])

    let embeddedWebside = createElemt('iframe', container, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: window.innerHeight - tobBarHeight - tobBarMarginBottom + 'px'
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "align-self",
            val: "stretch"
        },
    ], [{
            key: "src",
            val: url
        },
        {
            key: "onload",
            val: () => {
                loadingText.parentElement.removeChild(document.getElementById(loadingText.id))
            }
        },
    ])

    window.addEventListener("resize", () => {
        embeddedWebside.style.height = window.innerHeight - tobBarHeight - tobBarMarginBottom + 'px'
    })
}


/**
 * Opens a webpage in a new Tab
 * @param {string} url The url of the page
 */
function openInNewTab(url, alertText) {
    let container = createElemt('div', document.body, [{
            key: "width",
            val: "100vw"
        },
        {
            key: "height",
            val: "100vh"
        },
        {
            key: 'position',
            val: "absolute"
        },
        {
            key: "top",
            val: "0px"
        },
        {
            key: "text-align",
            val: "left"
        },
        {
            key: "background-color",
            val: "hsla(260, 100%, 5%, 0.5)"
        },
        {
            key: "overflow",
            val: "hidden"
        },
        {
            key: "display",
            val: "flex"
        },
        {
            key: "align-items",
            val: "center"
        },
    ], [{
        key: "id",
        val: "container"
    }, ])

    let box = createElemt('div', container, [{
            key: "padding",
            val: "10px"
        },
        {
            key: "border-radius",
            val: "10px"
        },
        {
            key: "border",
            val: "none"
        },
        {
            key: "background",
            val: "white"
        },
        {
            key: "left",
            val: "0"
        },
        {
            key: "right",
            val: "0"
        },
        {
            key: "top",
            val: "0"
        },
        {
            key: "bottom",
            val: "0"
        },
        {
            key: "margin",
            val: "auto"
        },
    ], [])

    let text = createElemt('p', box, [], [{
        key: 'innerText',
        val: alertText ?? 'Das Model wird in einem neuen Tab geöffnet.'
    }])

    let buttonStyle = [{
        key: "color",
        val: "blue"
    }, {
        key: "background",
        val: "lightgrey"
    }, {
        key: "padding",
        val: "5px"
    }, {
        key: "border-radius",
        val: "5px"
    }, {
        key: "margin",
        val: "5px"
    }, {
        key: "border",
        val: "none"
    }, {
        key: "text-decoration",
        val: "none"
    }, ]

    let buttonClose = createElemt('a', box, buttonStyle,
        [{
                key: "innerText",
                val: "abbrechen"
            },
            {
                key: "onclick",
                val: () => {
                    container.parentElement.removeChild(document.getElementById(container.id))
                }
            },
        ])
    let buttonOpen = createElemt('a', box, buttonStyle,
        [{
                key: "innerText",
                val: "ok"
            },
            {
                key: "href",
                val: url
            },
            {
                key: "target",
                val: '_blank'
            },
            {
                key: "onclick",
                val: () => {
                    container.parentElement.removeChild(document.getElementById(container.id))
                }
            },
        ])
}

function is_touch_device() {
    if ("ontouchstart" in window || window.TouchEvent)
        return true;

    if (window.DocumentTouch && document instanceof DocumentTouch)
        return true;

    const prefixes = ["", "-webkit-", "-moz-", "-o-", "-ms-"];
    const queries = prefixes.map(prefix => `(${prefix}touch-enabled)`);

    return window.matchMedia(queries.join(",")).matches;
}