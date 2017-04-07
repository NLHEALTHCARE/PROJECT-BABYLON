-- Script hoort bij de Zorginformatiebouwsteen MedischHulpmiddel. (https://zibs.nl/wiki/MedischHulpmiddel(NL))
-- De FHIR resource Device is hier deels voor gebruikt. (https://www.hl7.org/fhir/device.html#resource)

select
        ifhm_id                 as "product_id"                 -- zib's MedischHulpmiddel definieert ProductIDCodes: https://zibs.nl/wiki/MedischHulpmiddel(NL)#ProductIDCodelijst
        , null                  as "product_code_type"          -- zib's MedischHulpmiddel definieert ProductTypeCodes: https://zibs.nl/wiki/MedischHulpmiddel(NL)#ProductTypeCodelijst
        , ifhm_datum            as "begin_datum"                -- zib's definieert de startdatum dat het medische hulpmiddel voor het eerst is gebruikt.
        , null                  as "probleem"                   -- zib's definieert de medische reden voor het gebruik van het medische hulpmiddel.
        , null                  as "toelichting"                -- zib's definieert een toelichting bij het gebruik van het medische hulpmiddel of een toelichting van het medische hulpmiddel.
        , null                  as "anatomische_locatie"        -- zib's MedischHulpmiddel definieert HulpmiddelAnatomischeLocatieCodes: https://zibs.nl/wiki/MedischHulpmiddel(NL)#HulpmiddelAnatomischeLocatieCodelijst
        , null                  as "zorgaanbieder"              -- zib's definieert de zorgaanbieder waar het medische hulpmiddel is gebruikt.
        , null                  as "zorgverlener"               -- zib's definieert de zorgverlener die het medische hulpmiddel heeft gebruikt bij de patient.
        , ifhm_pat_bsn          as "patient_id"                 -- De patient waarbij het medische hulpmiddel is gebruikt. (FHIR - patient)

from mtdx.v_intf_hulpmiddel