-- Script hoort bij de Zorginformatiebouwsteen OverdrachtVerrichting. (https://zibs.nl/wiki/OverdrachtVerrichting(NL))
-- De FHIR resource Procedure is hier deels voor gebruikt. (https://www.hl7.org/fhir/procedure.html#resource)

select
        st.ifst_id                                      as "identifier"                         -- id van de verrichting. (FHIR - identifier)
        , st.ifst_pat_naam                              as "patient"                            -- Om welke patient gaat het. (FHIR - subject)
        , to_char(st.ifst_startdatum,'DD-MM-YYYY')      as "verrichting_start_datum"            -- zib's definieert een start datum van de verrichting.
        , to_char(st.ifst_einddatum,'DD-MM-YYYY')       as "verrichting_eind_datum"             -- zib's definieert een eind datum van de verrichting.
        , to_char(st.ifst_startdatum,'HH24:MI:SS')      as "verrichting_starttijd"              -- zib's definieert een starttijd van de verrichting.
        , to_char(st.ifst_einddatum,'HH24:MI:SS')       as "verrchting_eindtijd"                -- zib's definieert een eindtijd van de verrichting.
        , 'https://zibs.nl/wiki/OverdrachtVerrichting(NL)#VerrichtingAnatomischeLocatieCodelijst'                          as "anatomische_locatie"                -- zib's OverrdrachtVerrichting definieert VerrichtingAnatomischeLocatieCodes: https://zibs.nl/wiki/OverdrachtVerrichting(NL)#VerrichtingAnatomischeLocatieCodelijst
        , st.ifst_diag_omschrijving                     as "reden_van_verrichting"              -- zib's definieert een reden voor de uitvoering van de verrichting.
        , 'https://zibs.nl/wiki/OverdrachtVerrichting(NL)#VerrichtingTypeCodelijst'                          as "verrichting_type"                   -- zib's OverdrachtVerrichting definieert VerrichtingTypeCodes: https://zibs.nl/wiki/OverdrachtVerrichting(NL)#VerrichtingTypeCodelijst
        , null                                          as "product"                            -- zib's definieert een product dat tijdens de verrichting is geplaatst.
        , st.ifst_vest_naam                             as "zorgaanbieder"                      -- zib's definieert de locatie/zorgaanbieder waar de verrichting heeft plasst gevonden.
        , st.ifst_ba_naam                               as "uitgevoerd_door"                    -- zib's definieert een zorgverlener die de verrichting heeft uitgevoerd.
        , vw.ifvw_mw_naam                               as "aangevraagd_door"                   -- zib's definieert een zorgverlener die de verrichting heeft aangevraagd.
        , null                                          as "is_uitgevoerd"                      -- Is de verrichting uitgevoerd. (FHIR - notDone)
        , null                                          as "reden_niet_uitgevoerd"              -- De reden waarom de verrichting niet is uitgevoerd. (FHIR - notDoneReason)
        , null                                          as "resultaat_verrichting"              -- De resultaat van de verrichting als een verslag. (FHIR - report)
        , null                                          as "complicaties"                       -- Mogelijke complicaties tijdens de verrichting. (FHIR - complication)
        , null                                          as "complicatie_details"                -- Mogelijk nieuwe aandoening door complicatie. (FHIR - complicationDetail)
        , null                                          as "vervolg_afspraak"                   -- Instructies voor een vervolg afspraak. (FHIR - followUp)
        , null                                          as "extra_informatie"                   -- Extra informatie over de verrichting. (FHIR - note)

from mtdx.v_intf_subtraject st
join mtdx.v_intf_contact ct on st.ifst_pat_id = ct.ifct_id
join mtdx.v_intf_medewerker mw on st.ifst_ba_id = mw.ifmw_id
join mtdx.v_intf_verwijs_info vw on st.ifst_id = vw.ifvw_st_id