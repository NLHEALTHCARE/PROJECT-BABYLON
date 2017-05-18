-- Script hoort bij de Zorginformatiebouwsteen (zib) Lichaamslengte. (https://zibs.nl/wiki/Lichaamslengte(NL)) 
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                 -- Om welke patient gaat het. (FHIR - subject)
        , mw.ifmw_naam                  as "zorgverlener"               -- Welke zorgverlener heeft gemeten. (FHIR - performer)
        , ck.ifck_info_value1           as "lengte_waarde"              -- zib definieert de waarde van de gemeten lichaamslengte
        , ck.ifck_startdatum            as "lengte_datum_tijd"          -- zib definieert de datum en eventueel de tijd waarop de lichaamslengte is gemeten.
        , null                          as "toelichting"                -- zib definieert een toelichting op de meting van de lichaamslengte.
        , null                          as "positie"                    -- zib Lichaamslengte definieert PositieCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.12.2.1
        
from mtdx.v_intf_kenmerk ck
join mtdx.v_intf_contact ct on ck.ifck_ct_id = ct.ifct_id
join mtdx.v_intf_medewerker mw on ck.ifck_mw_id = mw.ifmw_id

where ct.ifct_soort = 9 AND ck.ifck_kg_code = 'PD.10'