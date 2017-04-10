-- Script hoort bij de Zorginformatiebouwsteen (zib) Wilsverklaring. (https://zibs.nl/wiki/Wilsverklaring(NL)) 
-- De FHIR resource Consent is hier deels voor gebruikt. (https://www.hl7.org/fhir/consent.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                         -- Om welke patient gaat het. (FHIR - patient)
        , null                          as "wilsverklaring_type"                -- zib Wilsverklaring definieert WilsverklaringTypeCodes: https://zibs.nl/wiki/Wilsverklaring(NL)#WilsverklaringTypeCodelijst
        , null                          as "wilsverklaring_status"              -- De status van de wilsverklaring. (FHIR - status)
        , null                          as "wilsverklaring_datum"               -- zib definieert de datum waarop de wilsverklaring is vastgesteld.
        , null                          as "aandoening"                         -- zib definieert het probleem waar de wilsverklaring betrekking op heeft.
        , ct.ifct_achternaam_partner    as "vertegenwoordiger"                  -- zib definieert de persoon die de wettelijke vertegenwoordiger is of in de ondertekende volmacht als gevolmachtigde wordt benoemd.
        , null                          as "wilsverklaring_document"            -- zib definieert het brondocument met de wilsverklaring en de handtekening van de patient als een bijlage, voorbeeld pdf
        , null                          as "toelichting"                        -- zib definieert een toelichting bij de wilsverklaring.

from mtdx.v_intf_contact ct
where ct.ifct_soort = 9