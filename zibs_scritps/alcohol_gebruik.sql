-- Script hoort bij de Zorginformatiebouwsteen (zib) AlcoholGebruik. (https://zibs.nl/wiki/AlcoholGebruik(NL))
-- De FHIR resource Observation zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ifct_bsn                as "patient_id"                 -- Id om de patient te herkennen. (FHIR - Subject) OID: http://decor.nictiz.nl/decor/services/RetrieveOID?prefix=hl7org&id=2.16.840.1.113883.2.4.6.3&format=html&language=nl-NL
        , null                  as "toelichting"                -- zib definieert toelichting/opmerkingen over het alcohol gebruik.
        , null                  as "status_alcohol_gebruik"     -- zib AloholGebruik definieert  AlcoholGebruikStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.7.3.2
        , null                  as "start_datum"                -- zib definieert de datum waarop gestart is met drinken.
        , null                  as "stop_datum"                 -- zib definieert de datum waarop gestopt is met drinken.
        , null                  as "hoeveelheid"                -- zib definieert de hoeveelheid alcohol dat geconsumeerd wordt in eenheden alcoholische drank per tijdseenheid.

from mtdx.v_intf_contact
where ifct_soort = 9                                            -- Filteren op patienten.
