-- Script hoort bij de Zorginformatiebouwsteen (zib) FunctioneleOfMentaleStatus. (https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)) 
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ct.ifct_bsn                                     as "pat_id"                     -- Patientindentificatienummer. (FHIR - Subject)
        , mw.ifmw_naam                                  as "zorgverlener"               -- De zorgverlener die de functionele of mentale status heeft vastgesteld. (FHIR - performer)
        , null /*vst.ifvs_naam*/                        as "locatie"                    -- De locatie waar de functionele of mentale status van de patient is vastgesteld. (FHIR - performer)
        , null                                          as "status_naam"                /* zib FunctioneleOfMentaleStatus definieert verschillende StatusNaamCodes:
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.3,
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.2,
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.1,
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.4
                                                                                        */
        , null                                          as "status_waarde"              /* zib FunctioneleOfMentaleStatus definieert verschillende StatusWaardeCodes: https://zibs.nl/wiki/FunctioneleOfMentaleStatus(NL)#StatusWaardeICFCodelijst
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.6,
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.7,
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.5,
                                                                                           http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.4.26.8
                                                                                        */
        , to_char(ck.ifck_startdatum,'DD-MM-YYYY')      as "status_datum"               -- zib definieert de datum waarop de status is vastgesteld, alleen jaartal is toegestaan.
        , ck.ifck_km_omschrijving                       as "toelichting"                -- zib definieert een toelichting als omschrijving van de functionele of mentale status.
        , null                                          as "medisch_hulpmiddel"         -- zib definieert een medsiche hulpmiddel dat de patiënt ter beschikking heeft om de impact van de beperking of stoornis te verminderen.

from mtdx.v_intf_kenmerk ck
join mtdx.v_intf_contact ct on ck.ifck_ct_id = ct.ifct_id
--join mtdx.v_intf_vestiging vst on ck.ifck_vest_id = vst.ifvs_id
join mtdx.v_intf_medewerker mw on ck.ifck_mw_id = mw.ifmw_id

where ct.ifct_soort = 9 AND (ck.ifck_kg_omschrijving = 'Psychisch' OR ck.ifck_kg_omschrijving = 'Lichamelijk' OR ck.ifck_kg_omschrijving = 'Lichamelijke beperking')