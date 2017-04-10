-- Script hoort bij de Zorginformatiebouwsteen (zib) FunctioneleOfMentaleStatus. (https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)) 
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ct.ifct_bsn             as "pat_id"                 -- Patientindentificatienummer. (FHIR - Subject)
        , mw.ifmw_achternaam    as "zorgverlener"               -- De zorgverlener die de functionele of mentale status heeft vastgesteld. (FHIR - performer)
        , vs.ifvs_naam          as "locatie"                    -- De locatie waar de functionele of mentale status van de patient is vastgesteld. (FHIR - performer)
        , null                  as "status_naam"                /* zib FunctioneleOfMentaleStatus definieert verschillende StatusNaamCodes:
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusNaamICFCodelijst,
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusNaamNOCCodelijst,
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusNaamOMAHACodelijst,
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusNaamSnomedCodelijst */
        , null                  as "status_waarde"              /* zib FunctioneleOfMentaleStatus definieert verschillende StatusWaardeCodes:
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusWaardeICFCodelijst,
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusWaardeNOCCodelijst,
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusWaardeOMAHACodelijst,
                                                                        https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusWaardeSnomedCodelijst */
        , null                  as "status_datum"               -- zib definieert de datum waarop de status is vastgesteld, alleen jaartal is toegestaan.
        , null                  as "toelichting"                -- zib definieert een toelichting als omschrijving van de functionele of mentale status.
        , null                  as "medisch_hulpmiddel"         -- zib definieert een medsiche hulpmiddel dat de patiënt ter beschikking heeft om de impact van de beperking of stoornis te verminderen.

from mtdx.v_intf_contact ct
join mtdx.v_intf_zorgactiviteit za on ct.ifct_id = za.ifza_ct_id
join mtdx.v_intf_vestiging vs on za.ifza_vest_id = vs.ifvs_id
join mtdx.v_intf_medewerker mw on za.ifza_eigenaar_code = mw.ifmw_code

where ct.ifct_soort = 9;