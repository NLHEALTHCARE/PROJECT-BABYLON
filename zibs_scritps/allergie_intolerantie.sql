-- Script hoort bij de Zorginformatiebouwsteen (zib) AllergieIntolerantie. (https://zibs.nl/wiki/AllergieIntolerantie(NL)) 
-- De FHIR resource AllergyIntolerance is hier deels voor gebruikt. (https://www.hl7.org/fhir/allergyintolerance.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                         -- Om welke patient gaat de allergische reactie. (FHIR - Patient)
        , mw.ifmw_achternaam            as "zorgverlener"                       -- De zorgverlener die de Allergie heeft geconstanteerd. (FHIR  - Recorder)
        , ct.ifct_achternaam            as "patient_naam"                       -- De mogelijke patient die informatie over de allergie heeft gegegeven. (FHIR - asserter)
        , null                          as "zorgverlener_naam"                  -- De mogelijke zorgverlener die informatie over de allergie heeft gegegeven. (FHIR - asserter)
        , ct.ifct_achternaam_partner    as "contactpersoon"                     -- De mogelijke contactpersoon die informatie over de allergie heeft gegegeven. (FHIR - asserter)
        , null                          as "veroorzakende_stof"                 /* zib AllergieIntolerantie definieert verschillende VeroorzakendeStofCodes:
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#VeroorzakendeStofAllergeneStoffenCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#VeroorzakendeStofHPKCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#VeroorzakendeStofSNKCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#VeroorzakendeStofSSKCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#VeroorzakendeStofThesaurus122Codelijst */
        , null                          as "allergie_categorie"                 -- zib AllergieIntolerantie definieert AllergieCategorieCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#AllergieCategorieCodelijst
        , null                          as "allergie_status"                    -- zib AllergieIntolerantie definieert  AllergieStatusCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#AllergieStatusCodelijst
        , null                          as "begin_datum_tijd"                   -- zib definieert de datum en tijd waarop de allergie is vastgesteld, dit kan exacte datum en tijd zijn of een globaleaanduiding van de datum.
        , null                          as "mate_van_kritiek_zijn"              -- zib AllergieIntolerantie definieert MateVanKritiekZijnCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#MateVanKritiekZijnCodelijst
        , null                          as "laatste_reactie_datum_tijd"         -- zib definieert de datum en tijd waarop de laatste keer een reactie heeft plaats gevonden.
        , null                          as "toelichting"                        -- zib definieert een toelichting over de allergie die niet in een van de andere velden kan worden ingevuld.
        , null                          as "symptoom"                           -- zib AllergieIntolerantie definieert SymptoomCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#SymptoomCodelijst
        , null                          as "specifieke_stof"                    /* zib AllergieIntolerantie definieert verschillende SpecifiekeStofCodes:
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#SpecifiekeStofAllergeneStoffenCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#SpecifiekeStofHPKCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#SpecifiekeStofSNKCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#SpecifiekeStofSSKCodelijst,
                                                                                        https://zibs.nl/wiki/AllergieIntolerantie(NL)#SpecifiekeStofThesaurus122Codelijst */
        , null                          as "waarschijnlijkheid"                 -- zib AllergieIntolerantie definieert WaarschijnlijkheidCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#WaarschijnlijkheidCodelijst
        , null                          as "reactie_beschrijving"               -- zib definieert een tekstuele beschrijving van de reactie.
        , null                          as "ernst"                              -- zib AllergieIntolerantie definieert ErnstCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#ErnstCodelijst
        , null                          as "wijze_van_blootstelling"            -- zib AllergieIntolerantie definieert WijzeVanBlootstellingCodes: https://zibs.nl/wiki/AllergieIntolerantie(NL)#WijzeVanBlootstellingCodelijst
        , null                          as "reactie_tijdstip"                   -- zib definieert de datum en de tijd waarop de reactie plaastvond.
        , null                          as "reactie_duur"                       -- zib definieert de tijdsduur van de reactie.

from mtdx.v_intf_contact ct
join mtdx.v_intf_zorgactiviteit za on ct.ifct_id = za.ifza_ct_id
join mtdx.v_intf_medewerker mw on za.ifza_eigenaar_code = mw.ifmw_code

where ct.ifct_soort = 9