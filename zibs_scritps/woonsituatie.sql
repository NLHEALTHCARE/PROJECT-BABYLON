-- Script hoort bij de Zorginformatiebouwsteen (zib) Woonsituatie. (https://zibs.nl/wiki/Woonsituatie(NL)) 
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)

select
        null                            as "woning_type"                        -- zib Woonsituatie definieert WoningTypeCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.7.8.1
        , null                          as "toelichting"                        -- zib definieert in vrije tekst problemen of details rondom de woonsituatie van de patient die relevant kunnen zijn.
        ,ct.ifct_bsn                    as "patient_id"                         -- Om welke patient gaat het. (FHIR - identifier)
        , ct.ifct_straat_b              as "adres_straatnaam"                   -- AdresGegevens_straat.
        , ct.ifct_huisnr_b              as "adres_huisnummer"                   -- AdresGegevens_huisnummer.
        , null                          as "adres_huisnummer_letter"            -- zib Patient definieert bij AdresGegevens een Huisnummerletter.
        , ct.ifct_gebouw_b              as "adres_huisnummer_toevoeging"        -- zib Patient definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                          as "adres_aanduiding_bij_nummer"        -- zib Patient definieert AanduidingBijNummerCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.7
        , ct.ifct_postcode_b            as "adres_postcode"                     -- AdresGegevens_postcode.
        , ct.ifct_plaats_b              as "adres_woonplaats"                   -- AdresGegevens_woonplaats.
        , null                          as "adres_gemeente"                     -- zib Patient definieert bij AdresGegevens een Gemeente.
        , ct.ifct_lnd_omschrijving_b    as "adres_land"                         -- zib Patient definieert bij AdresGegevens twee verschillende LandCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.9 en http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.8
        , null                          as "address_extra_info"                 -- zib Patient definieert bij AdresGegevens AdditioneleInformatie.
        

from mtdx.v_intf_contact ct
where ct.ifct_soort = 9