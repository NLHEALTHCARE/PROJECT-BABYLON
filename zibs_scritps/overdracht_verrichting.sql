-- Script hoort bij de Zorginformatiebouwsteen OverdrachtVerrichting. (https://zibs.nl/wiki/OverdrachtVerrichting(NL))
-- De FHIR resource Procedure is hier deels voor gebruikt. (https://www.hl7.org/fhir/procedure.html#resource)

select
        ifev_id                         as "identifier"                         -- id van de verrichting. (FHIR - identifier)
        , null /* ifev_omschrijving*/   as "patient"                            -- Om welke patient gaat het. (FHIR - subject)
        , ifev_datum                    as "verrichting_start_datum"            -- zib's definieert een start datum van de verrichting.
        , null                          as "verrichting_eind_datum"             -- zib's definieert een eind datum van de verrichting.
        , ifev_starttijd                as "verrichting_starttijd"              -- zib's definieert een starttijd van de verrichting.
        , ifev_eindtijd                 as "verrchting_eindtijd"                -- zib's definieert een eindtijd van de verrichting.
        , null                          as "anatomische_locatie"                -- zib's OverrdrachtVerrichting definieert VerrichtingAnatomischeLocatieCodes: https://zibs.nl/wiki/OverdrachtVerrichting(NL)#VerrichtingAnatomischeLocatieCodelijst
        , ifev_rdn_omschrijving         as "reden_van_verrichting"              -- zib's definieert een reden voor de uitvoering van de verrichting.
        , null                          as "verrichting_type"                   -- zib's OverdrachtVerrichting definieert VerrichtingTypeCodes: https://zibs.nl/wiki/OverdrachtVerrichting(NL)#VerrichtingTypeCodelijst
        , null                          as "product"                            -- zib's definieert een product dat tijdens de verrichting is geplaatst.
        , ifev_vst_naam                 as "zorgaanbieder"                      -- zib's definieert de locatie/zorgaanbieder waar de verrichting heeft plasst gevonden.
        , ifev_mdw_naam                 as "uitgevoerd_door"                    -- zib's definieert een zorgverlener die de verrichting heeft uitgevoerd.
        , null                          as "aangevraagd_door"                   -- zib's definieert een zorgverlener die de verrichting heeft aangevraagd.
        , null                          as "is_uitgevoerd"                      -- Is de verrichting uitgevoerd. (FHIR - notDone)
        , null                          as "reden_niet_uitgevoerd"              -- De reden waarom de verrichting niet is uitgevoerd. (FHIR - notDoneReason)
        , null                          as "resultaat_verrichting"              -- De resultaat van de verrichting als een verslag. (FHIR - report)
        , null                          as "complicaties"                       -- Mogelijke complicaties tijdens de verrichting. (FHIR - complication)
        , null                          as "complicatie_details"                -- Mogelijk nieuwe aandoening door complicatie. (FHIR - complicationDetail)
        , null                          as "vervolg_afspraak"                   -- Instructies voor een vervolg afspraak. (FHIR - followUp)
        , null                          as "extra_informatie"                   -- Extra informatie over de verrichting. (FHIR - note)

from mtdx.v_intf_activiteit