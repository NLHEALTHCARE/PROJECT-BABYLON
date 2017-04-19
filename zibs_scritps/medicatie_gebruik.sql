-- Script hoort bij de Zorginformatiebouwsteen (zib) MedicatieGebruik. (https://zibs.nl/wiki/MedicatieGebruik(NL))
-- De FHIR resource MedicationDispense is hier deels voor gebruikt. (https://www.hl7.org/fhir/medicationdispense.html#resource)

select
        ct.ifct_bsn             as "patient_id"                                 -- Om welke patient gaat het. (FHIR - Subejct)
        , null                  as "product"                                    -- zib definieert het middel dat is gebruikt, dit is vrijwel steeds een geneesmiddel
        , null                  as "medicatie_voorschrift"                      -- zib definieert de afspraak of order voor het gebruik van de medicatie.
        , null                  as "dosering"                                   -- zib definieert de hoeveelheid en het gebruikspatroon, gerapporteerd door de patiënt of een zorgverlener.
        , null                  as "medicatie_gebruik_status"                   -- zib MedicatieGebruik definieert MedicatieGebruikStatusCodes: https://zibs.nl/wiki/MedicatieGebruik(NL)#MedicatieGebruikStatusCodelijst
        , null                  as "medicatie_reden_stoppen"                    -- zib MedicatieGebruik definieert MedicatieGebruikRedenVanStoppenCodes: https://zibs.nl/wiki/MedicatieGebruik(NL)#MedicatieGebruikRedenVanStoppenCodelijst
        , null                  as "medicatie_reden_onderbreken"                -- zib MedicatieGebruik definieert MedicatieGebruikRedenVanOnderbrekenCodes: https://zibs.nl/wiki/MedicatieGebruik(NL)#MedicatieGebruikRedenVanOnderbrekenCodelijst
        , null                  as "toelichting"                                -- zib definieert een toelichting op het medicatie gebruik.
        , null                  as "medicatie_gebruik_reden"                    -- Waarom deze medicatie wordt gebruikt. (FHIR - partOf)
        , null                  as "medicatie_gebruik_type"                     -- Wat voor soort gebruik van de medicatie, vb trial (FHIR - type)

from mtdx.v_intf_contact ct

where ct.ifct_soort = 9