-- Script hoort bij de Zorginformatiebouwsteen (zib) MedicatieGebruik. (https://zibs.nl/wiki/MedicatieGebruik(NL))
-- De FHIR resource MedicationDispense is hier deels voor gebruikt. (https://www.hl7.org/fhir/medicationdispense.html#resource)

select
        ct.ifct_bsn                                                     as "patient_id"                                 -- Om welke patient gaat het. (FHIR - Subejct)
        , ck.ifck_km_omschrijving                                       as "product"                                    -- zib definieert het middel dat is gebruikt, dit is vrijwel steeds een geneesmiddel
        , null                                                          as "medicatie_voorschrift"                      -- zib definieert de afspraak of order voor het gebruik van de medicatie.
        , ck.ifck_startdatum                                            as "dosering_start_datum"                       -- zib definieert de datum en de tijd waarop het gebruik van de dosering is gestart of zal starten.
        , ck.ifck_einddatum                                             as "dosering_eind_datum"                        -- zib definieert de datum en de tijd waarop gestopt is met de dosering. Dit kan een afgesproken datum zijn of een staakdatum.
        , trunc(ck.ifck_einddatum) - trunc(ck.ifck_startdatum)          as "dosering_gebruiksduur"                      -- zib definieert de gebruiksduur die niet berekend kan worden uit de start en stop datum. Een voorbeeld hiervan is een tijdelijke slaapmedicatie.
        , null                                                          as "dosering_aantal_toedieningen"               -- zib definieert de beoogde duur van de gebruiksperiode.
        , ck.ifck_info_value2 || ' ' || ck.ifck_info_value3             as "dosering_keer_dosis"                        -- zib definieert de dosis per inname of toediening.
        , null                                                          as "medicatie_gebruik_status"                   -- zib MedicatieGebruik definieert MedicatieGebruikStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.2.1
        , null                                                          as "medicatie_reden_stoppen"                    -- zib MedicatieGebruik definieert MedicatieGebruikRedenVanStoppenCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.2.2
        , null                                                          as "medicatie_reden_onderbreken"                -- zib MedicatieGebruik definieert MedicatieGebruikRedenVanOnderbrekenCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.9.2.3
        , null                                                          as "toelichting"                                -- zib definieert een toelichting op het medicatie gebruik.
        , null                                                          as "medicatie_gebruik_reden"                    -- Waarom deze medicatie wordt gebruikt. (FHIR - partOf)
        , null                                                          as "medicatie_gebruik_type"                     -- Wat voor soort gebruik van de medicatie, vb trial (FHIR - type)

from mtdx.v_intf_contact ct
join mtdx.v_intf_kenmerk ck on ct.ifct_id = ck.ifck_ct_id

where ct.ifct_soort = 9 AND ck.ifck_kg_omschrijving = 'Medicatie'

--TESTEN ([a-zA-Z]+\ ?\/?[0-9]*\ ?\%?\ ?[a-zA-z]+\ [a-zA-Z]+[a-zA-Z]*\ *[a-zA-Z]*)
/*
select
        distinct ck.ifck_km_omschrijving

from mtdx.v_intf_kenmerk ck
where regexp_like(ck.ifck_km_omschrijving, '([a-z]|[A-Z])+\ ') AND ck.ifck_kg_omschrijving = 'Medicatie'
order by ck.ifck_km_omschrijving asc*/