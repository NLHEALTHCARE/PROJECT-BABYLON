-- Script hoort bij de Zorginformatiebouwsteen (zib) AlcoholGebruik. (https://zibs.nl/wiki/AlcoholGebruik(NL))
-- De FHIR resource Observation zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ifct_bsn                as "patient_id"                 -- Id om de patient te herkennen. (FHIR - Subject)
        , null                  as "toelichting"                -- zib definieert toelichting/opmerkingen over het alcohol gebruik.
        , null                  as "status_alcohol_gebruik"     -- zib AloholGebruik definieert  AlcoholGebruikStatusCodes: https://zibs.nl/wiki/AlcoholGebruik(NL)#AlcoholGebruikStatusCodelijst
        , null                  as "start_datum"                -- zib definieert de datum waarop gestart is met drinken.
        , null                  as "stop_datum"                 -- zib definieert de datum waarop gestopt is met drinken.
        , null                  as "hoeveelheid"                -- zib definieert de hoeveelheid alcohol dat geconsumeerd wordt in eenheden alcoholische drank per tijdseenheid.

from mtdx.v_intf_contact
where ifct_soort = 9                                            -- Filteren op patienten.
