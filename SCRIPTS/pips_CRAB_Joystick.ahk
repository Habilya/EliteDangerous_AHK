/*

*/

#NoEnv  ;; Рекомендуеться для производительности и совместимости с будущими рлизами платформы AHK.
#Singleinstance force ;; чтобы не открывался несколько раз
#Persistent ;; Держать открытым пока пользователь сам не закроет скрипт из панели или горячей клавишей

;; JoystickNumber
joyNb = 1

;; Валидация на наличие джойстика
GetKeyState, joyName, %joyNb%joyName
if joyName =
{
	MsgBox Где джой?
	ExitApp
}

;; Клавиши пипок
SYS = {Left}
ENG = {Up}
WEP = {Right}
RST = {Down}

;; задержка по 30 милисекунд между нажатиями
SetKeyDelay, 30

;; Таймер 100 милисекунд выполняющий функцию опроса Хатки
SetTimer, WatchPOV, 100

;; Опрос хатки джойстика
WatchPOV() {
	;; получаем позицию хатки джойстика.
	GetKeyState, pOVState, %joyNb%JoyPOV
	
	;; Для дебага..
	;; ToolTip test:%pOVState%
	
	;; Предотвращяет множественные срабатывания если хатка остаеться зажатой
	if previousPOVState = pOVState
	{
		return
	}
	
	;; Назначение функций на положения Хатки
	switch pOVState
	{
		case 27000:
			PIPCombinationGenerate(4, 2, 0)

		case 0:   
			PIPCombinationGenerate(0, 4, 2)

		case 9000: 
			PIPCombinationGenerate(4, 0, 2)

		case 18000:
			ResetPIPs()
	}
	
	previousPOVState = pOVState
	return
}

;; CTRL+0 закрыть скрипт если напортачил и начала творится лютая дичь...
^0::exitapp

;; Функция генирирующяя нажатия пипок по комбинации, тут ничего менять не надо XD

PIPCombinationGenerate(sysCount, engCount, wepCount) {
Global RST, WEP, ENG, SYS

	;; НАЧАЛО Валидация параметров
	;; Если параметры не верны, ничего не делать
	PIPS_MAX = 4
	PIPS_TOTAL = 6
	
	if(sysCount is not number or engCount is not number or wepCount is not number) {
		return
	}
	
	if(sysCount < 0 or engCount < 0 or wepCount < 0) {
		return
	}
	
	if(sysCount > PIPS_MAX or engCount > PIPS_MAX or wepCount > PIPS_MAX) {
		return
	}
	
	if((sysCount + engCount + wepCount) != PIPS_TOTAL) {
		return
	}	
	;; КОНЕЦ Валидация параметров
	
	combination = %sysCount%%engCount%%wepCount%
	send %RST%
	
	switch combination
	{
		case "114":
			send %WEP%
			send %WEP%
			return
		case "141":
			send %ENG%
			send %ENG%
			return
		case "411":
			send %SYS%
			send %SYS%
			return
		case "204":
			send %SYS%
			send %WEP%
			send %WEP%
			send %WEP%
			return
		case "330":
			send %SYS%
			send %SYS%
			send %ENG%
			send %ENG%
			return
		case "240":
			send %SYS%
			send %ENG%
			send %ENG%
			send %ENG%
			return
		case "033":
			send %ENG%
			send %ENG%
			send %WEP%
			send %WEP%
			return
		case "042":
			send %ENG%
			send %ENG%
			send %WEP%
			send %ENG%
			return
		case "402":
			send %SYS%
			send %SYS%
			send %WEP%
			send %SYS%
			return
		case "303":
			send %SYS%
			send %SYS%
			send %WEP%
			send %WEP%
			return
		case "420":
			send %SYS%
			send %SYS%
			send %ENG%
			send %SYS%
			return
		case "024":
			send %ENG%
			send %WEP%
			send %WEP%
			send %WEP%
			return
		case "123":
			send %SYS%
			send %WEP%
			send %WEP%
			send %WEP%
			send %ENG%
			send %ENG%
			return
		case "132":
			send %SYS%
			send %ENG%
			send %ENG%
			send %ENG%
			send %WEP%
			send %WEP%
			return
		case "321":
			send %SYS%
			send %SYS%
			send %WEP%
			send %SYS%
			send %ENG%
			send %ENG%
			return
		case "213":
			send %ENG%
			send %WEP%
			send %WEP%
			send %WEP%
			send %SYS%
			send %SYS%
			return
		case "312":
			send %SYS%
			send %SYS%
			send %ENG%
			send %SYS%
			send %WEP%
			send %WEP%
			return
		case "231":
			send %ENG%
			send %ENG%
			send %WEP%
			send %ENG%
			send %SYS%
			send %SYS%
			return
		default:
			return
	}
	
	return
}

ResetPIPs() {
Global RST, WEP, ENG, SYS
	send %RST%
}
