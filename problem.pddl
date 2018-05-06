(define (problem turmultimodal) (:domain turmultimodal)
    
    (:objects 
        ;Bike stations.
        st-praca-do-diario  st-praca-da-republica   st-cais-do-apolo
        st-mercado-sao-jose st-santa-rita   st-alfandega

        ;Visitation points.
        vp-paco-alfandega   vp-banco-do-brasil  vp-mercado-sao-jose
        vp-igreja-rosario   vp-praca-da-republica

        ;People
        Joao    Maria   Jose
    )

    (:init
        ;Locations
        (isStation st-praca-do-diario)
        (isStation st-alfandega)
        (isStation st-cais-do-apolo)
        (isStation st-mercado-sao-jose)
        (isStation st-praca-da-republica)
        (isStation st-santa-rita)
        (isVisitationPoint vp-banco-do-brasil)
        (isVisitationPoint vp-igreja-rosario)
        (isVisitationPoint vp-mercado-sao-jose)
        (isVisitationPoint vp-paco-alfandega)
        (isVisitationPoint vp-praca-da-republica)
        
        ;Adjacency.
        (isAdjTo st-praca-do-diario st-praca-da-republica)
        (isAdjTo st-praca-do-diario st-mercado-sao-jose)
        (isAdjTo st-praca-do-diario vp-igreja-rosario)
        (isAdjTo vp-igreja-rosario st-praca-do-diario)

        (isAdjTo st-praca-da-republica st-praca-do-diario)
        (isAdjTo st-praca-da-republica st-cais-do-apolo)
        (isAdjTo st-praca-da-republica vp-praca-da-republica)
        (isAdjTo vp-praca-da-republica st-praca-da-republica)

        (isAdjTo st-cais-do-apolo st-praca-da-republica)
        (isAdjTo st-cais-do-apolo st-alfandega)
        (isAdjTo st-cais-do-apolo vp-banco-do-brasil)
        (isAdjTo vp-banco-do-brasil st-cais-do-apolo)

        (isAdjTo st-alfandega st-cais-do-apolo)
        (isAdjTo st-alfandega st-santa-rita)
        (isAdjTo st-alfandega vp-paco-alfandega)
        (isAdjTo vp-paco-alfandega st-alfandega)

        (isAdjTo st-santa-rita st-alfandega)
        (isAdjTo st-santa-rita st-mercado-sao-jose)

        (isAdjTo st-mercado-sao-jose st-santa-rita)
        (isAdjTo st-mercado-sao-jose st-praca-do-diario)
        (isAdjTo st-mercado-sao-jose vp-mercado-sao-jose)
        (isAdjTo vp-mercado-sao-jose st-mercado-sao-jose)

        ;Initial locations.
        (isAt Joao st-praca-do-diario)
        (isAt Maria st-alfandega)
        (isAt Jose st-cais-do-apolo)

        ;No waiting at the beginning.
        (waited-5-min Joao)
        (waited-5-min Maria)
        (waited-5-min Jose)
    )

    (:goal (and
                (isAt Joao st-praca-do-diario)
                (isAt Maria st-alfandega)
                (isAt Jose st-cais-do-apolo)
                (visited Joao vp-banco-do-brasil)
                (visited Joao vp-paco-alfandega)
                (visited Jose vp-igreja-rosario)
                (visited Jose vp-mercado-sao-jose)
                (visited Maria vp-praca-da-republica)
                (visited Maria vp-mercado-sao-jose))
    )
)
