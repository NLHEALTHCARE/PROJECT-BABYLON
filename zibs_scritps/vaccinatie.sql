-- Script hoort bij de Zorginformatiebouwsteen (zib) Vaccinatie. (https://zibs.nl/wiki/Vaccinatie(NL)) 
-- De FHIR resource Immunization is hier deels voor gebruikt. (https://www.hl7.org/fhir/immunization.html#resource)

select
        ct.ifct_bsn             as "patient_id"                         -- Identificatie van de patient die de vaccin heeft gekregen. (FHIR - Patient)
        , null                  as "is_toegediend"                      -- Is de vaccinatie toegediend aan de patient. (FHIR - notGiven)
        , null                  as "product_code"                       /* zib Vaccinatie definieert verschillende  ProductCodeCodes:
                                                                                http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.11.1.4,
                                                                                http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.11.1.3,
                                                                                http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.11.1.5,
                                                                                http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.11.1.2,
                                                                                http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.11.1.1,
                                                                                http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.11.1.6
                                                                        */
        , null                  as "dosis"                              -- zib definieert de hoeveelheid van het gegegeven product in milimeters.
        , null                  as "vaccinatie_datum"                   -- zib definieert de datum (en eventuele tijd) dat het vaccin is toegediend.
        , null                  as "hervaccinatie_gewenste_datum"       -- zib defineert de datum waarop deze vaccinatie volgens de gegevens van de auteur herhaald zal moeten worden.
        , mw.ifmw_naam          as "zorgverlener"                       -- zib definieert de zorgverlener door wie de immunisatie is uitgevoerd.
        , vs.ifvs_naam          as "locatie"                            -- zib definieert de locatie waar de immunisatie is uitgevoerd.
        , null                  as "toelichting"                        -- zib definieert een toelichting over de vaccinatie die is toegediend (vb. "Vaccinatie volgens Rijksvaccinatieprogramma". - "Niet volgens Rijksvaccinatieprogramma", gevolgd door een verdere toelichting. - "Onbekend").
        , null                  as "reden_vaccinatie"                   -- De reden waarom de vaccinatie is toegediend. (FHIR - Encounter)
        , null                  as "fabrikant_vaccin"                   -- De fabrikant van de vaccin. (FHIR - manufacterer)
        , null                  as "reactie_vaccin"                     -- De mogelijke reactie die de patient heeft op het vaccin. (FHIR - reaction.detail)
        , null                  as "reactie_datum"                      -- De datum waarop de reactie is begonnen. (FHIR - raction.date)
        , null                  as "reactie_zelf_aangegeven"            -- Is de reactie op het vaccin door de patient zelf aangegeven. (FHIR - reaction.reported)

from mtdx.v_intf_contact ct
join mtdx.v_intf_zorgactiviteit za on ct.ifct_id = za.ifza_ct_id
join mtdx.v_intf_vestiging vs on za.ifza_vest_id = vs.ifvs_id
join mtdx.v_intf_medewerker mw on za.ifza_eigenaar_code = mw.ifmw_code

where ct.ifct_soort = 9