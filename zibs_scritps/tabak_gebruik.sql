-- Script hoort bij de Zorginformatiebouwsteen (zib) TabakGebruik. (https://zibs.nl/wiki/TabakGebruik(NL))
-- De FHIR resource Observation zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ifct_bsn                as "patient_id"                 -- Id om de patient te herkennen. (FHIR - Subject)
        , null                  as "toelichting"                -- zib definieert toelichting/opmerkingen over het tabak gebruik.
        , null                  as "soort_tabak_gebruik"        -- zib TabakGebruik definieert SoortTabakGebruikCodes: https://zibs.nl/wiki/TabakGebruik(NL)#SoortTabakGebruikCodelijst
        , null                  as "status_tabak_gebruik"       -- zib TabakGebruik definieert TabakGebruikStatusCodes: https://zibs.nl/wiki/TabakGebruik(NL)#TabakGebruikStatusCodelijst
        , null                  as "start_datum"                -- zib definieert de start datum van het roken.
        , null                  as "stop_datum"                 -- zib definieert de datum waarop gestopt is met roken.
        , null                  as "hoeveelheid"                -- zib definieert het aantal sigaretten, sigaren of gram shag per dag, week, maand of jaar.
        , null                  as "pack_years"                 -- zib definieert een eenheid waarin de totale blootstelling aan tabaksrook bij rokers beschreven wordt.

from mtdx.v_intf_contact
where ifct_soort = 9                                            -- Filteren op patienten.
