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
   (if (or (eq ?response yes) (eq ?response y)(eq ?response да)(eq ?response д))
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
(inventar "Мяч")
(people 22)
(team "Да")
(bodypart "Нога")
(place "Поле")
=>
(assert (sport "Футбол"))
)




(defrule sport2 ""
(not (sport ?))
(inventar "Мяч")
(people 10)
(team "Да")
(bodypart "Рука")
(place "Площадка")
=>
(assert (sport "Баскетбол"))
)



(defrule sport3 ""
(not (sport ?))
(inventar "Мяч и ракетка")
(people 2)
(team "Нет")
(bodypart "Рука")
(place "Площадка")
=>
(assert (sport "Тенис"))
)
;----

(defrule question1 ""
(not (sport ?))
=>
(if 
(eq 
(ask-question "Какой инвентарь используется в игре? (Варианты ответа: Мяч, Мяч и ракетка)" "мяч" "мяч и ракетка") 
"мяч") then (assert (inventar "Мяч")) else
(assert (inventar "Мяч и ракетка"))
)
)


(defrule question2 ""
(not (sport ?))
=>
(bind ?answer (ask-question "Сколько игроков в игре?(Варианты ответа: 2, 10, 22)" "2" "10" "22" ))
(if (eq ?answer 2)
then (assert (people 2)) )
(if (eq ?answer 22)
then (assert (people 22)) )
(if (eq ?answer 10)
then (assert (people 10)) )
)


(defrule question3 ""
(not (sport ?))
=>
(if (yes-or-no-p "Игра командная?") then 
(assert (team "Да")) else
(assert (team "Нет"))
)
)



(defrule question4 ""
(not (sport ?))
=>
(bind ?answer (ask-question "Какой частью тела играют в игру?(Варианты ответа: Рука, Нога, Голова)" "рука" "нога" "голова"))
(if (eq ?answer рука)
then (assert (bodypart "Рука")) )
(if (eq ?answer нога)
then (assert (bodypart "Нога")) )
(if (eq ?answer голова)
then (assert (bodypart "Голова")) )
)




(defrule question5 ""
(not (sport ?))
=>
(bind ?answer (ask-question "Где играют в игру?(Варианты ответа: Поле, Площадка)" "поле" "площадка"))
(if (eq ?answer поле)
then (assert (place "Поле")) )
(if (eq ?answer площадка)
then (assert (place "Площадка")) )

)

