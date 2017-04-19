-- Script hoort bij de Zorginformatiebouwsteen (zib) Bloeddruk. (https://zibs.nl/wiki/Bloeddruk(NL))
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                 -- Om welke patient gaat het. (FHIR - subject)
        , mw.ifmw_achternaam            as "zorgverlener"               -- Welke zorgverlener heeft de bloeddruk gemeten.
        , null                          as "meetmethode"                -- zib Bloeddruk definieert MeetmethodeCodes: https://zibs.nl/wiki/Bloeddruk(NL)#MeetmethodeCodelijst
        , null                          as "manchet_type"               -- zib Bloeddruk definieert ManchetTypeCodes: https://zibs.nl/wiki/Bloeddruk(NL)#ManchetTypeCodelijst
        , null                          as "meet_locatie"               -- zib Bloeddruk definieert MeetLocatieCodes: https://zibs.nl/wiki/Bloeddruk(NL)#MeetLocatieCodelijst
        , null                          as "diastolische_eindpunt"      -- zib Bloeddruk definieert DiastolischEindpuntCodes: https://zibs.nl/wiki/Bloeddruk(NL)#DiastolischEindpuntCodelijst
        , null                          as "systolische_bloeddruk"      -- zib definieert de hoogste (piek) systemische arteriële bloeddruk - gemeten in de systolische of samentrekkingsfase van de hartslag.
        , null                          as "diastolische_bloeddruk"     -- zib definieert de laagste systemische arteriële bloeddruk - gemeten in de diastolische of ontspanningsfase van de hartslag.
        , null                          as "gemiddelde_bloeddruk"       -- zib definieert de gemiddelde bloeddruk gedurende één cyclus van samentrekken en ontspannen van het hart. Dit wordt geschat op basis van boven en onderdruk.
        , null                          as "bloeddruk_datum_tijd"       -- zib definieert de datum en tijd waarop de bloedwaarden zijn gemeten.
        , null                          as "toelichting"                -- zib definieert een toelichting over de gemeten bloeddruk, dit kan bijvoorbeeld de omstandigheden zijn waarin is gemeten.
        , null                          as "houding"                    -- zib Bloeddruk definieert HoudingCodes: https://zibs.nl/wiki/Bloeddruk(NL)#HoudingCodelijst
        
from mtdx.v_intf_contact ct
join mtdx.v_intf_zorgactiviteit za on ct.ifct_id = za.ifza_ct_id
join mtdx.v_intf_medewerker mw on za.ifza_eigenaar_code = mw.ifmw_code

where ct.ifct_soort = 9