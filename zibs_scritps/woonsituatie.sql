-- Script hoort bij de Zorginformatiebouwsteen (zib) Woonsituatie. (https://zibs.nl/wiki/Woonsituatie(NL)) 
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)

select
        'https://zibs.nl/wiki/Woonsituatie(NL)#WoningTypeCodelijst'                            as "woning_type"                        -- zib Woonsituatie definieert WoningTypeCodes: https://zibs.nl/wiki/Woonsituatie(NL)#WoningTypeCodelijst
        , null                          as "toelichting"                        -- zib definieert in vrije tekst problemen of details rondom de woonsituatie van de patient die relevant kunnen zijn.
        ,ct.ifct_bsn                    as "patient_id"                         -- Om welke patient gaat het. (FHIR - identifier)
        , ct.ifct_straat_b              as "adres_straatnaam"                   -- AdresGegevens_straat.
        , ct.ifct_huisnr_b              as "adres_huisnummer"                   -- AdresGegevens_huisnummer.
        , null                          as "adres_huisnummer_letter"            -- zib Patient definieert bij AdresGegevens een Huisnummerletter.
        , ct.ifct_gebouw_b              as "adres_huisnummer_toevoeging"        -- zib Patient definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                          as "adres_aanduiding_bij_nummer"        -- zib Patient definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
        , ct.ifct_postcode_b            as "adres_postcode"                     -- AdresGegevens_postcode.
        , ct.ifct_plaats_b              as "adres_woonplaats"                   -- AdresGegevens_woonplaats.
        , null                          as "adres_gemeente"                     -- zib Patient definieert bij AdresGegevens een Gemeente.
        , ct.ifct_lnd_omschrijving_b    as "adres_land"                         -- zib Patient definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
        , null                          as "address_extra_info"                 -- zib Patient definieert bij AdresGegevens AdditioneleInformatie.
        

from mtdx.v_intf_contact ct
where ct.ifct_soort = 9