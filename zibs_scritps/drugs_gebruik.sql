-- Script hoort bij de Zorginformatiebouwsteen (zib) DurgsGebruik. (https://zibs.nl/wiki/DrugsGebruik(NL))
-- De FHIR resource Observation zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ifct_bsn                as "patient_id"                 -- Id om de patient te herkennen. (FHIR - Subject)
        , null                  as "start_datum"                -- zib definieert de datum waarop gestart is met het drugs gebruik.
        , null                  as "stop_datum"                 -- zib definieert de daatum waario gestopt is met het drugs gebruik.
        , null                  as "hoeveelheid"                -- zib definieert het aantal eenheden (pillen, joint, shots, etc) per dag, week, maand of jaar of de freqentie van gebruik.
        , null                  as "toelichting"                -- zib definieert toelichting/opmerkingen over het drugs gebruik.
        , null                  as "soort_middel"               -- zib DurgsGebruik definieert DrugsOfGeneesmiddelSoortCodes: https://zibs.nl/wiki/DrugsGebruik(NL)#DrugsOfGeneesmiddelSoortCodelijst
        , null                  as "status_drugs_gebruik"       -- zib DrugsGebruik definieert DrugGebruikStatusCodes: https://zibs.nl/wiki/DrugsGebruik(NL)#DrugGebruikStatusCodelijst
        , null                  as "toedienings_wijze"          -- zib DrugsGebruik definieert ToedieningswegCodes: https://zibs.nl/wiki/DrugsGebruik(NL)#ToedieningswegCodelijst

from mtdx.v_intf_contact
where ifct_soort = 9                                            -- Filteren op patienten.