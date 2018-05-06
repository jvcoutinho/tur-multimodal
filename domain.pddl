(define (domain turmultimodal)

    (:requirements :strips)

    (:predicates
        (isAt ?who ?where) ; One's a place.
        (isStation ?where) ;É uma estação.
        (isVisitationPoint ?where) ;Ponto de visitação.
        (isAdjTo ?where ?where) ;isAdj(x,y) = x é isAdjacente a y
        (visited ?who ?where) ;visited(x, y) = x visitou y
        (pedalled-30-min ?who) ;pedalled(x) = x pedalou entre 2 estações
        (waited-5-min ?who) ;waited(x) = x esperou 5 minutos
        (hasBike ?who) ;hasBike(x) = x tem uma bicicleta
    )

    ; Ações
    (:action pegar-bicicleta
        :parameters (?who ?where)
        :precondition (and 
                            (waited-5-min ?who)
                            (not (hasBike ?who))
                            (isStation ?where)
                            (isAt ?who ?where))
                            ;(>= (numBikes ?where) 1))
        :effect (and
                    (not (waited-5-min ?who))
                    (hasBike ?who))
                    ;(decrease (numBikes ?where) 1))    
    )

    (:action entregar-bicicleta
        :parameters (?who ?where)
        :precondition (and
                            (pedalled-30-min ?who)
                            (hasBike ?who)
                            (isStation ?where)
                            (isAt ?who ?where))
        :effect (and
                    (not (hasBike ?who))
                    (not (pedalled-30-min ?who))
                    (not (waited-5-min ?who)))
                    ;(increase (numBikes ?where) 1))    
    )

    (:action esperar-5-min
        :parameters (?who ?where)
        :precondition (and 
                        (isStation ?where)
                        (isAt ?who ?where)
                        (not (pedalled-30-min ?who)))
        :effect (waited-5-min ?who)
    )

    (:action caminhar
        :parameters (?who ?start ?destination)
        :precondition (and
                        (or 
                            (isVisitationPoint ?destination)
                            (isVisitationPoint ?start))
                        (isAdjTo ?start ?destination)
                        (isAt ?who ?start)
                        (not (hasBike ?who)))
        :effect (and 
                    (not (isAt ?who ?start))
                    (isAt ?who ?destination))
    )

    (:action visitar-ponto
        :parameters (?who ?where)
        :precondition (and 
                        (isAt ?who ?where)
                        (isVisitationPoint ?where)
                        (or ;Se é João e a estação é Paço Alfândega, João visitou Banco do Brasil.
                            (not (= ?who Joao))
                            (not (= ?where vp-paco-alfandega))
                            (visited ?who vp-banco-do-brasil)))
                                
        :effect (and 
                    (visited ?who ?where)
                    (waited-5-min ?who))
    )

    (:action pedalar
        :parameters (?who ?start ?destination)
        :precondition (and
                        (hasBike ?who)
                        (isAdjTo ?start ?destination)
                        (isAt ?who ?start)
                        (isStation ?start)
                        (isStation ?destination)
                        (not (pedalled-30-min ?who)))
        :effect (and 
                    (not (isAt ?who ?start))
                    (isAt ?who ?destination)
                    (pedalled-30-min ?who))
    )
)
