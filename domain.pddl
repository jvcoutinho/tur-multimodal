(define (domain turmultimodal)

    (:requirements :strips :adl :equality)

    (:predicates
        (isAt ?who ?where) 
        (isStation ?where) 
        (isVisitationPoint ?where) 
        (isAdjTo ?where ?where)
        (isPerson ?who)
        (visited ?who ?where)
        (pedalled-30-min ?who)
        (waited-5-min ?who) 
        (hasBike ?who) 
        (numBikes ?where ?value)
        (successor ?number ?number)
        (return ?who ?where)
    )

    (:action pegar-bicicleta
        :parameters (?who ?where ?initialNumBikes ?finalNumBikes)
        :precondition (and 
                        (isPerson ?who)
                        (numBikes ?where ?initialNumBikes)
                        (not (= ?initialNumBikes zero))
                        (successor ?finalNumBikes ?initialNumBikes)
                        (waited-5-min ?who)
                        (isStation ?where)
                        (isAt ?who ?where)
                        (not (hasBike ?who)))
        :effect (and 
                    (hasBike ?who)
                    (not (numBikes ?where ?initialNumBikes))
                    (numBikes ?where ?finalNumBikes)
                    (not (waited-5-min ?who)))
    )

    (:action entregar-bicicleta
        :parameters (?who ?where ?initialNumBikes ?finalNumBikes)
        :precondition (and 
                        (isPerson ?who)
                        (numBikes ?where ?initialNumBikes)
                        (successor ?initialNumBikes ?finalNumBikes)
                        (isStation ?where)
                        (isAt ?who ?where)
                        (hasBike ?who))
        :effect (and 
                    (not (hasBike ?who))
                    (not (numBikes ?where ?initialNumBikes))
                    (numBikes ?where ?finalNumBikes)
                    (not (waited-5-min ?who))
                    (not (pedalled-30-min ?who)))
    )

    (:action pedalar
        :parameters (?who ?start ?end)
        :precondition (and 
                        (isPerson ?who)
                        (hasBike ?who)
                        (isAt ?who ?start)
                        (isAdjTo ?start ?end)
                        (isStation ?start)
                        (isStation ?end)
                        (not (pedalled-30-min ?who))
                        (not (visited ?who ?end))
                        (visited ?who ?start))
        :effect (and 
                    (not (isAt ?who ?start))
                    (isAt ?who ?end)
                    (pedalled-30-min ?who)
                    (visited ?who ?end))
    )

    (:action pedalar-volta
        :parameters (?who ?start ?end)
        :precondition (and 
                        (isPerson ?who)
                        (hasBike ?who)
                        (isAt ?who ?start)
                        (isAdjTo ?start ?end)
                        (isStation ?start)
                        (isStation ?end)
                        (not (pedalled-30-min ?who))
                        (visited ?who ?end)
                        (visited Joao vp-banco-do-brasil)
                        (visited Joao vp-paco-alfandega)
                        (visited Jose vp-igreja-rosario)
                        (visited Jose vp-mercado-sao-jose)
                        (visited Maria vp-praca-da-republica)
                        (visited Maria vp-mercado-sao-jose))
        :effect (and 
                    (isAt ?who ?end)
                    (not (isAt ?who ?start))
                    (return ?who ?end)
                    (pedalled-30-min ?who))
    )
    

    (:action caminhar
        :parameters (?who ?start ?end)
        :precondition (and 
                        (isPerson ?who)
                        (or
                            (isVisitationPoint ?start)
                            (isVisitationPoint ?end))
                        (isAdjTo ?start ?end)
                        (not (hasBike ?who))
                        (isAt ?who ?start))
        :effect (and 
                    (not (isAt ?who ?start))
                    (isAt ?who ?end))
    )
    
    (:action visitar-ponto
        :parameters (?who ?where)
        :precondition (and 
                        (isPerson ?who)
                        (isAt ?who ?where)
                        (isVisitationPoint ?where)
                        (or ;Se é João e a estação é Paço Alfândega, João visitou Banco do Brasil.
                            (not (= ?who Joao))
                            (not (= ?where vp-paco-alfandega))
                            (visited Joao vp-banco-do-brasil))
                        (or ;Se for Maria e o início é o Mercado, então José está lá.
                           (not (= ?who Maria))
                           (not (= ?where vp-mercado-sao-jose))
                           (isAt Jose vp-mercado-sao-jose))
                        (or ;Se for José e o início é o Mercado, então Maria está lá.
                            (not (= ?who Jose))
                            (not (= ?where vp-mercado-sao-jose))
                            (isAt Maria vp-mercado-sao-jose)))
                            
        :effect (and 
                    (visited ?who ?where)
                    (waited-5-min ?who))
    )

    (:action esperar-5-min
        :parameters (?who ?where)
        :precondition (and 
                        (isPerson ?who)
                        (isStation ?where)
                        (isAt ?who ?where)
                        (not (hasBike ?who))
                        (not (waited-5-min ?who)))
        :effect (waited-5-min ?who)
    )
)
