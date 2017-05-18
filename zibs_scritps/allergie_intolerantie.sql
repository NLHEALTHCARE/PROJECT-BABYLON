-- Script hoort bij de Zorginformatiebouwsteen (zib) AllergieIntolerantie. (https://zibs.nl/wiki/AllergieIntolerantie(NL)) 
-- De FHIR resource AllergyIntolerance is hier deels voor gebruikt. (https://www.hl7.org/fhir/allergyintolerance.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                         -- Om welke patient gaat de allergische reactie. (FHIR - Patient)
        , mw.ifmw_achternaam            as "zorgverlener"                       -- De zorgverlener die de Allergie heeft geconstanteerd. (FHIR  - Recorder)
        , ct.ifct_achternaam            as "patient_naam"                       -- De mogelijke patient die informatie over de allergie heeft gegegeven. (FHIR - asserter)
        , mw.ifmw_naam                  as "zorgverlener_naam"                  -- De mogelijke zorgverlener die informatie over de allergie heeft gegegeven. (FHIR - asserter)
        , ct.ifct_achternaam_partner    as "contactpersoon"                     -- De mogelijke contactpersoon die informatie over de allergie heeft gegegeven. (FHIR - asserter)
        , null                          as "veroorzakende_stof"                 /* zib AllergieIntolerantie definieert verschillende VeroorzakendeStofCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#VeroorzakendeStofAllergeneStoffenCodelijst
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.17,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.19,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.14,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.13,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.15
                                                                                */
        , null                          as "allergie_categorie"                 -- zib AllergieIntolerantie definieert AllergieCategorieCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.2
        , null                          as "allergie_status"                    -- zib AllergieIntolerantie definieert AllergieStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.3
        , null                          as "begin_datum_tijd"                   -- zib definieert de datum en tijd waarop de allergie is vastgesteld, dit kan exacte datum en tijd zijn of een globaleaanduiding van de datum.
        , null                          as "mate_van_kritiek_zijn"              -- zib AllergieIntolerantie definieert MateVanKritiekZijnCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.4
        , null                          as "laatste_reactie_datum_tijd"         -- zib definieert de datum en tijd waarop de laatste keer een reactie heeft plaats gevonden.
        , null                          as "toelichting"                        -- zib definieert een toelichting over de allergie die niet in een van de andere velden kan worden ingevuld.
        , null                          as "symptoom"                           -- zib AllergieIntolerantie definieert SymptoomCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.5
        , null                          as "specifieke_stof"                    /* zib AllergieIntolerantie definieert verschillende SpecifiekeStofCodes:
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.16,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.18,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.10,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.9,
                                                                                   http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.11
                                                                                */
        , null                          as "waarschijnlijkheid"                 -- zib AllergieIntolerantie definieert WaarschijnlijkheidCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.8
        , null                          as "reactie_beschrijving"               -- zib definieert een tekstuele beschrijving van de reactie.
        , null                          as "ernst"                              -- zib AllergieIntolerantie definieert ErnstCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.6
        , null                          as "wijze_van_blootstelling"            -- zib AllergieIntolerantie definieert WijzeVanBlootstellingCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.8.2.12
        , null                          as "reactie_tijdstip"                   -- zib definieert de datum en de tijd waarop de reactie plaastvond.
        , null                          as "reactie_duur"                       -- zib definieert de tijdsduur van de reactie.

from mtdx.v_intf_kenmerk ck
join mtdx.v_intf_contact ct on ck.ifck_ct_id = ct.ifct_id
join mtdx.v_intf_medewerker mw on ck.ifck_mw_id = mw.ifmw_id

where ck.ifck_kg_omschrijving LIKE 'Allergie%' AND ct.ifct_soort = 9