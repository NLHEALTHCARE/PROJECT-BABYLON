-- Script hoort bij de Zorginformatiebouwsteen (zib) DurgsGebruik. (https://zibs.nl/wiki/DrugsGebruik(NL))
-- De FHIR resource Observation zijn hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ifct_bsn                as "patient_id"                 -- Id om de patient te herkennen. (FHIR - Subject)
        , null                  as "start_datum"                -- zib definieert de datum waarop gestart is met het drugs gebruik.
        , null                  as "stop_datum"                 -- zib definieert de daatum waario gestopt is met het drugs gebruik.
        , null                  as "hoeveelheid"                -- zib definieert het aantal eenheden (pillen, joint, shots, etc) per dag, week, maand of jaar of de freqentie van gebruik.
        , null                  as "toelichting"                -- zib definieert toelichting/opmerkingen over het drugs gebruik.
        , null                  as "soort_middel"               -- zib DurgsGebruik definieert DrugsOfGeneesmiddelSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.7.4.1
        , null                  as "status_drugs_gebruik"       -- zib DrugsGebruik definieert DrugGebruikStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.7.4.2
        , null                  as "toedienings_wijze"          -- zib DrugsGebruik definieert ToedieningswegCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.7.4.3

from mtdx.v_intf_contact
where ifct_soort = 9                                            -- Filteren op patienten.