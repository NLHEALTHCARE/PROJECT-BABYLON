-- Script hoort bij de Zorginformatiebouwsteen (zib) Voedingsadvies. (https://zibs.nl/wiki/Voedingsadvies(NL)) 
-- De FHIR resource NutritionOrder is hier deels voor gebruikt. (https://www.hl7.org/fhir/nutritionorder.html#resource)
-- VerpleegkundigeActie is weggelaten omdat deze niet in de Basisgegevensset Zorg zit en niet relevant is voor de bewegingszorg.

select
        ct.ifct_bsn             as "patient_id"                 -- Om welke patient gaat het. (FHIR - patient)
        , null                  as "reden"                      -- Reden voor dit voedingsadvies. (FHIR - Encounter)
        , null                  as "dieet_type"                 -- zib definieert de omschrijving van het type dieet.
        , null                  as "consistentie"               -- zib definieert de omschrijving van de consistentie van de voeding.
        , null                  as "toelichting"                -- zib definieert een toelichting op het voedingadvies.
        , null                  as "allergie"                   -- Bestaande allergieen die de patient heeft. (FHIR - allergyIntolerance)
        , null                  as "status_voedingsadvies"      -- Wat is de status van het huidige voedingsadvies, is het nog een concept, wordt deze al gebruikt of is deze al verouderd. (FHIR - status)

from mtdx.v_intf_kenmerk ck
join mtdx.v_intf_contact ct on ck.ifck_ct_id = ct.ifct_id
where ck.ifck_kg_omschrijving LIKE 'Allergie%' ct.ifct_soort = 9