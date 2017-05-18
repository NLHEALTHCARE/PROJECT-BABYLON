-- Script hoort bij de Zorginformatiebouwsteen (zib) OverdrachtLaboratoriumUitslag. (https://zibs.nl/wiki/OverdrachtLaboratoriumUitslag(NL))
-- De FHIR resource Observation is hier deels voor gebruikt. (https://www.hl7.org/fhir/observation.html#resource)

select
        ct.ifct_bsn                     as "patient_id"                 -- Om welke patient gaat het. (FHIR - subject)
        , mw.ifmw_achternaam            as "zorgverlener"               -- Welke zorgverlener heeft de test uitgevoerd. (FHIR - performer)
        , null                          as "monster_nummer"             -- zib definieert een identificerend nummer van het afgenomen materiaal. In de transmurale setting bestaat dit nummer uit een monsternummer inclusief de identificatie van de uitgevende organisatie, om uniek te zijn buiten de grenzen van een organisatie.
        , null                          as "monster_materiaal"          -- zib OverdrachtLaboratoriumUitslag definieert MonstermateriaalCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.6
        , null                          as "afname_datum_tijd"          -- zib definieert de datum en het tijdstip waarop materiaal is afgenomen.
        , null                          as "afname_procedure"           -- zib OverdrachtLaboratoriumUitslag definieert AfnameprocedureCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.2
        , null                          as "toelichting"                -- zib definieert een toelichting over de afname, vb: afname na (glucose)stimulus of medicijn inname.
        , null                          as "test_naam"                  -- zib OverdrachtLaboratoriumUitslag definieert TestNaamCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.3
        , null                          as "test_methode"               -- zib OverdrachtLaboratoriumUitslag definieert TestmethodeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.4
        , null                          as "test_datum_tijd"            -- zib definieert de datum en eventueel het tijdstip waarop de test is uitgevoerd.
        , null                          as "uitslag"                    -- zib definieert de uitslag van een test. Afhankelijk van de soort test bestaat de uitslag uit een waarde met eenheid of uit een gecodeerde waarde (ordinaal of nominaal).
        , null                          as "referentie_bovengrens"      -- zib definieert de geldende referentie bovenwaarde van de met de test gemeten waarde voor de patient.
        , null                          as "referentie_ondergrens"      -- zib definieert de geldende referentie onderwaarde van de met de test gemeten waarde voor de patient.
        , null                          as "resultaat_vlaggen"          -- zib OverdrachtLaboratoriumUitslag definieert ResultaatVlaggenCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.7
        , null                          as "onderzoek"                  -- zib OverdrachtLaboratoriumUitslag definieert OnderzoekCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.5
        , null                          as "resultaat_status"           -- zib OverdrachtLaboratoriumUitslag definieert ResultaatStatusCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.8
        , null                          as "toelichting"                -- zib definieert opmerkingen over de uitslag zoals bijvoorbeeld tekstuele interpretatie en advies bij een uitslag.
        , null                          as "resultaat_type"             -- zib OverdrachtLaboratoriumUitslag definieert ResultaatTypeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.13.1.1
        
from mtdx.v_intf_contact ct
join mtdx.v_intf_zorgactiviteit za on ct.ifct_id = za.ifza_ct_id
join mtdx.v_intf_medewerker mw on za.ifza_eigenaar_code = mw.ifmw_code

where ct.ifct_soort = 9