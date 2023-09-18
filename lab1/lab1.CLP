(deffunction ask-question (?question $?allowed-values)
   (printout t ?question)
   (bind ?answer (readline))
   (if (lexemep ?answer) 
       then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer ?allowed-values)) do
      (printout t ?question)
      (bind ?answer (readline))
      (if (lexemep ?answer) 
          then (bind ?answer (lowcase ?answer))))
   ?answer)

(deffunction yes-or-no-p (?question)
   (bind ?response (ask-question ?question "yes" "no" "y" "n" "да" "нет" "д" "н"))
   (if (or (eq ?response "yes") (eq ?response "y")(eq ?response "да")(eq ?response "д"))
       then TRUE 
       else FALSE))

;----

(defrule print-goal ""
  (declare (salience 1))
  (sport ?item)
  =>
  (printout t crlf crlf)
  (printout t "Вид спорта, который Вы описали это ")
  (printout t crlf crlf)
  (format t " %s%n%n%n" ?item))

(defrule no-goal ""
  (declare (salience -1))
  (not (sport ?))
  =>
(printout t crlf crlf)
  (printout t "Такого спорта не существует или он нам не известен.")
  (printout t crlf crlf)
)

;----

(defrule sport1 ""
(not (sport ?))
(team "Да")
(gameWithBall "Да")
(gameWithFoot "Да")
(contactSport "Да")
=>
(assert (sport "Футбол"))
)


(defrule sport2 ""
(not (sport ?))
(team "Да")
(gameWithBall "Да")
(gameWithHand "Да")
(contactSport "Да")
=>
(assert (sport "Баскетбол"))
)


(defrule sport3 ""
(not (sport ?))
(team "Да")
(gameWithBall "Да")
(gameWithHand "Да")
(contactSport "Нет")
=>
(assert (sport "Волейбол"))
)


(defrule sport4 ""
(not (sport ?))
(team "Да")
(gameWithBall "Да")
(gameWithHand "Да")
(likeWeapon "Да")
(likeRun "Да")
=>
(assert (sport "Бейсбол"))
)


(defrule sport5 ""
(not (sport ?))
(gameWithBall "Да")
(gameWithRacket "Да")
=>
(assert (sport "Теннис"))
)


(defrule sport6 ""
(not (sport ?))
(gameWithBall "Да")
(stickGame "Да")
=>
(assert (sport "Гольф"))
)


(defrule sport7 ""
(not (sport ?))
(team "Да")
(gameWithBall "Нет")
(gameWithStick "Да")
(contactSport "Да")
=>
(assert (sport "Хоккей"))
)


(defrule sport8 ""
(not (sport ?))
(team "Нет")
(likeRun "Да")
(contactSport "Нет")
=>
(assert (sport "Легкая атлетика"))
)


(defrule sport9 ""
(not (sport ?))
(watersport "Да")
(contactSport "Нет")
(team "Нет")
=>
(assert (sport "Плавание"))
)


(defrule sport10 ""
(not (sport ?))
(watersport "Да")
(contactSport "Да")
(team "Да")
=>
(assert (sport "Водное поло"))
)


(defrule sport11 ""
(not (sport ?))
(contactSport "Нет")
(team "Нет")
(likeWeapon "Да")
(likeRun "Нет")
=>
(assert (sport "Стрельба"))
)


(defrule sport12 ""
(not (sport ?))
(contactSport "Да")
(team "Нет")
(likeWeapon "Нет")
(likeRun "Нет")
=>
(assert (sport "Бокс"))
)

;----

(defrule question1 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра командная?") then 
(assert (team "Да")) else
(assert (team "Нет"))
)
)


(defrule question2 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра ногами?") then 
(assert (gameWithFoot "Да")) else
(assert (gameWithFoot "Нет"))
)
)


(defrule question3 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра с мячом?") then 
(assert (gameWithBall "Да")) else
(assert (gameWithBall"Нет"))
)
)


(defrule question4 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра руками?") then 
(assert (gameWithHand "Да")) else
(assert (gameWithHand "Нет"))
)
)


(defrule question5 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра с ракеткой?") then 
(assert (gameWithRacket "Да")) else
(assert (gameWithRacket "Нет"))
)
)


(defrule question6 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра с клюшкой?") then 
(assert (gameWithStick "Да")) else
(assert (gameWithStick "Нет"))
)
)


(defrule question7 ""
(not (sport ?))
=>
(if (yes-or-no-p "Вам нравится оружие?") then 
(assert (likeWeapon "Да")) else
(assert (likeWeapon "Нет"))
)
)


(defrule question8 ""
(not (sport ?))
=>
(if (yes-or-no-p "Вам нравиться бегать?") then 
(assert (likeRun "Да")) else
(assert (likeRun "Нет"))
)
)


(defrule question9 ""
(not (sport ?))
=>
(if (yes-or-no-p "Водный вид спорта?") then 
(assert (watersport "Да")) else
(assert (watersport "Нет"))
)
)



(defrule question10 ""
(not (sport ?))
=>
(if (yes-or-no-p "Контактный вид спорта?") then 
(assert (contactSport "Да")) else
(assert (contactSport "Нет"))
)
)