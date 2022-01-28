extends Node2D

export var botBubbleColor := Color(0.21,0.5,1)
export var userBubbleColor := Color(0.34,0.83,0.45)
onready var bubble = preload("res://scenes/general/ChatBubble.tscn")
var last_user_answer = ""

# Setting possible answers for users (U) and reaction to the answer for the bot (B)
var U_basicAnswers := ["anmelde", "Abteilungen", "Schnuppertage"]
var B_basicAnswers := ["Warst du im Gym oder in der MS?", "Sieh dir bitte unsere Homepage an, um mehr über die Abteilungen zu erfahren.  Hast du noch Fragen zu den Schnuppertagen oder den Anmeldevoraussetzungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest.", "Sieh dir bitte unsere Homepage an, um mehr über die Schnuppertage zu erfahren.  Hast du noch Fragen zu den Anmeldevoraussetzungen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest."]
var U_AnVoAnswers := ["Gym", "MS"]
var B_AnVoAnswers := ["Bist du in Mathe, Deutsch und Englisch positiv?", "Bist du in allen Hauptfächern als \"Standard AHS\" mit den Noten 1, 2, 3 oder 4 eingeordnet?"]
var U_Gym_MDEp := ["Ja", "Nein"]
var B_Gym_MDEp := ["Super, dann bist du in der Schule aufgenommen. Je nachdem wie gut dein Reihungswert ist bekommst du deinen Abteilungs-Erstwunsch  oder vielleicht deinen Zweitwunsch. Möchtest du wissen, wie man den Reihungswert berechnet?", "Dann musst du in dem Fach mit der negativen Note eine Aufnahmeprüfung machen.  Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest."]
var U_Gym_MDEp_Yes := ["Ja", "Nein"]
var B_Gym_MDEp_Yes := ["Ok, schön. Rechne deine Mathematiknote mal 2. Dann addierst du die Deutschnote und anschliessend die Englischnote. Das Ergebnis ist dein Reihungswert. Je kleiner das Ergebnis ist, desto sicherer bekommst du einen Platz in deiner Wunschabteilung.  Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest.", "Ok.   Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest."]
var U_MS_MDEp := ["Ja", "Nein"]
var B_MS_MDEp := ["Super, dann bist du in der Schule aufgenommen. Je nachdem wie gut dein Reihungswert ist bekommst du deinen Abteilungs-Erstwunsch  oder vielleicht deinen Zweitwunsch. Möchtest du wissen, wie man den Reihungswert berechnet?", "Hast du vielleicht in deinen Fächern, bei denen du in \"Standard\" eingeordnet bist nichts schlechteres als eine 3?"]
var U_MS_MDEp_Yes := ["Ja", "Nein"]
var B_MS_MDEp_Yes := ["Wichtig sind die Noten der Fächer Mathematik, Deutsch und Englisch.   Du rechnest deine Mathematiknote mal 2. Dann addierst du deine Deutschnote und anschliessend deine Englischnote. Je kleiner das Ergebnis ist, desto sicherer bekommst du einen Platz in deiner Wunschabteilung.  Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest.", "Ok.   Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest."]
var U_MS_MDEp_No := ["Ja", "Nein"]
var B_MS_MDEp_No := ["Wenn du überall in deinen Fächern, in denen du mit \"Standard\" eingeordnet bist eine 1 oder 2 hast, dann bist du auf jeden Fall aufgenommen.  Hast du in einem oder mehreren \"Standard\"-Hauptfächern eine 3, dann bist du noch in der  Fachschule aufgenommen.  Für die höheren Abteilungen musst du eine Aufnahmeprüfung in dem Fach machen,  in dem du \"Standard\" bist und eine 3, 4 oder 5 hast.  Je nachdem wie gut dein Reihungswert ist bekommst du deinen Abteilungs-Erstwunsch  oder vielleicht deinen Zweitwunsch. Möchtest du wissen, wie man den Reihungswert berechnet?", "Dann musst du auf jeden Fall eine Aufnahmeprüfung machen.  Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest."]
var U_MS_MDEp_No_Yes := ["Ja", "Nein"]
var B_MS_MDEp_No_Yes := ["Wichtig sind die Noten der Fächer Mathematik, Deutsch und Englisch.       In den Fächern, bei denen du \"Standard AHS\" bist, rechnest du mit deinen Noten.       In den Fächern, bei denen du \"Standard\" bist musst du zuerst deine Noten plus 2 rechnen und rechnest mit der neuen Note weiter.    Nun rechnest du deine Mathematiknote mal 2. Dann addierst du deine Deutschnote und anschliessend deine Englischnote. Je kleiner das Ergebnis ist, desto sicherer bekommst du einen Platz in deiner Wunschabteilung.  Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen?", "Ok.  Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest."]

var isWaitingForAnswers := 0
var userAnswers := [U_basicAnswers, U_AnVoAnswers, U_Gym_MDEp, U_Gym_MDEp_Yes, U_MS_MDEp, U_MS_MDEp_Yes, U_MS_MDEp_No, U_MS_MDEp_No_Yes]
var botAnswers := [B_basicAnswers, B_AnVoAnswers, B_Gym_MDEp, B_Gym_MDEp_Yes, B_MS_MDEp, B_MS_MDEp_Yes, B_MS_MDEp_No, B_MS_MDEp_No_Yes]
var cntr = 0

func _on_TextEditor_text_entered(new_text: String) -> void:
	if new_text.replacen(" ", "").length() == 0: return
	SendUserMessage(new_text)
	$Messager/TextEditor.text = ""
	last_user_answer = new_text
	$BotAnswerTimer.start()

func SendBotMessage(text:String) -> void:
	var flag = bubble.instance()
	flag.bubbleColor = botBubbleColor
	flag.bubbleSize = Vector2(250, 50)
	flag.bubbleMessage = text
	$Messager/MessageViewer/MessageContainer.add_child(flag)
	$Messager/MessageViewer.scroll_vertical_enabled = true
	$Messager/MessageViewer.gotNewMessage = true

func SendUserMessage(text:String) -> void:
	cntr = cntr + 1
	var flag = bubble.instance()
	flag.bubbleColor = userBubbleColor
	flag.bubbleSize = Vector2(250, 50)
	flag.bubbleMessage = text
	flag.xOffset = $Messager/MessageViewer.rect_size.x - flag.bubbleSize.x - 30
	$Messager/MessageViewer/MessageContainer.add_child(flag)
	if cntr > 6: $Messager/MessageViewer.scroll_vertical_enabled = true
	$Messager/MessageViewer.gotNewMessage = true

func HandleUserInputMessage(text:String) -> void:
	if text.to_lower() == "reihungswert" or text.to_lower() == "muster niki":
		SendBotMessage("Rechne die Mathematiknote mal 2. Dann addierst du die Deutschnote und anschliessend die Englischnote. Das Ergebnis ist der Reihungswert. Hast du sonst noch Fragen zu den Anmeldevoraussetzungen, den Schnuppertagen oder den Abteilungen? Tippe die Begriffe ein, über die du mehr erfahren möchtest.")
		isWaitingForAnswers = 0
		return
	var answerPos = GetPositionInAnswerArray(text)
	if answerPos != -1:
		SendBotMessage(botAnswers[isWaitingForAnswers][answerPos])
		
		# In the following, the isWaitingForAnswers variable gets set to the value, which should select the variable in the userAnswers Array, that gets the acceptable answers
		# Depending on the value the user entered, it has to jump to the right position in the array.
		if isWaitingForAnswers == 0 and answerPos == 0: isWaitingForAnswers = 1
		elif isWaitingForAnswers == 0: isWaitingForAnswers = 0
		elif isWaitingForAnswers == 1 and answerPos == 0: isWaitingForAnswers = 2
		elif isWaitingForAnswers == 1 and answerPos == 1: isWaitingForAnswers = 4
		elif isWaitingForAnswers == 2 and answerPos == 0: isWaitingForAnswers = 3
		elif isWaitingForAnswers == 2 and answerPos == 1: isWaitingForAnswers = 0
		elif isWaitingForAnswers == 3: isWaitingForAnswers = 0
		elif isWaitingForAnswers == 4 and answerPos == 0: isWaitingForAnswers = 5
		elif isWaitingForAnswers == 4 and answerPos == 1: isWaitingForAnswers = 6
		elif isWaitingForAnswers == 5: isWaitingForAnswers = 0
		elif isWaitingForAnswers == 6 and answerPos == 0: isWaitingForAnswers = 7
		elif isWaitingForAnswers == 6 and answerPos == 1: isWaitingForAnswers = 0
		elif isWaitingForAnswers == 7: isWaitingForAnswers = 0
	else: 
		SendBotMessage("Sorry, dabei kann ich dir leider nicht weiterhelfen. Hast du Fragen zu den Anmeldevoraussetzungen, zu den Abteilungen oder den Schnuppertagen? Tippe die Begriffe ein, über die du mehr erfahren möchtest.")
		isWaitingForAnswers = 0

func GetPositionInAnswerArray(text:String) -> int:
	if text.to_lower().find("anmelde") == 0: text = "anmelde"
	var returnVal = -1
	for i in userAnswers[isWaitingForAnswers]:
		if i.to_lower() == text.to_lower():
			return returnVal + 1
		returnVal = returnVal + 1
	return -1

func _on_BotAnswerTimer_timeout() -> void:
	HandleUserInputMessage(last_user_answer)
