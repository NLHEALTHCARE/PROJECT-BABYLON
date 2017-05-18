-- Script hoort bij de Zorginformatiebouwsteen MedischHulpmiddel. (https://zibs.nl/wiki/MedischHulpmiddel(NL))
-- De FHIR resource Device is hier deels voor gebruikt. (https://www.hl7.org/fhir/device.html#resource)

select
        null                            as "product_id"                 -- zib's MedischHulpmiddel definieert ProductIDCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.10.1.3
        , null                          as "product_code_type"          -- zib's MedischHulpmiddel definieert ProductTypeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.10.1.1
        , ifhm_datum                    as "begin_datum"                -- zib's definieert de startdatum dat het medische hulpmiddel voor het eerst is gebruikt.
        , ifhm_art_uitvoering           as "probleem"                   -- zib's definieert de medische reden voor het gebruik van het medische hulpmiddel.
        , ifhm_art_omschrijving         as "toelichting"                -- zib's definieert een toelichting bij het gebruik van het medische hulpmiddel of een toelichting van het medische hulpmiddel.
        , null                          as "anatomische_locatie"        -- zib's MedischHulpmiddel definieert HulpmiddelAnatomischeLocatieCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.10.1.2
        , null                          as "zorgaanbieder"              -- zib's definieert de zorgaanbieder waar het medische hulpmiddel is gebruikt.
        , null                          as "zorgverlener"               -- zib's definieert de zorgverlener die het medische hulpmiddel heeft gebruikt bij de patient.
        , ifhm_pat_bsn                  as "patient_id"                 -- De patient waarbij het medische hulpmiddel is gebruikt. (FHIR - patient)

from mtdx.v_intf_hulpmiddel