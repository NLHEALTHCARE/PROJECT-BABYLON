-- Script hoort bij de Zorginformatiebouwsteen (zib) Lichaamsgewicht. (https://zibs.nl/wiki/Lichaamsgewicht(NL)) 
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                 -- Om welke patient gaat het. (FHIR - subject)
        , mw.ifmw_naam                  as "zorgverlener"               -- De zorgverlener die de meting heeft uitgevoerd. (FHIR - performer)
        , ck.ifck_info_value2           as "gewicht_waarde"             -- zib definieert het lichaamsgewicht van de patient in kg. Bij pasgeborenen onder 3 kg wordt het gewicht veelal in grammen uitgedrukt. Dit concept wordt ook gebruikt lichaamsgewicht te schatten, als het niet mogelijk is om het exacte lichaamsgewicht te meten.
        , null                          as "toelichting"                -- zib definieert een toelichting over de gewichtsmeting zoals problemen of factoren die invloed hebben op de gewichtsmeting.
        , ck.ifck_startdatum            as "gewicht_datum_tijd"         -- zib definieert de datum en eventuele tijdstip waarop het gewicht is gemeten of geschat.
        , 'https://zibs.nl/wiki/Lichaamsgewicht(NL)#KledingCodelijst'                          as "kleding"                    -- zib Lichaamsgewicht definieert KledingCodes: https://zibs.nl/wiki/Lichaamsgewicht(NL)#KledingCodelijst

from mtdx.v_intf_kenmerk ck
join mtdx.v_intf_contact ct on ck.ifck_ct_id = ct.ifct_id
join mtdx.v_intf_medewerker mw on ck.ifck_mw_id = mw.ifmw_id

where ct.ifct_soort = 9 AND ck.ifck_kg_code = 'BP_BMI'