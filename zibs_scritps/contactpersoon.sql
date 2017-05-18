-- Script hoort bij de Zorginformatiebouwsteen (zib) Contactpersoon. (https://zibs.nl/wiki/Contactpersoon(NL))
-- De FHIR resource RelatedPerson is hier deels voor gebruikt. (https://www.hl7.org/fhir/relatedperson.html#resource)
-- Voor bepaalde CodeLijsten wordt gerefereerd naar de zib Patient, omdat deze CodeLijsten niet in de zib Contactpersoon zijn beschreven. (https://zibs.nl/wiki/Patient(NL))

select
        ifct_bsn                        as "identifier"                         -- id van de contactpersoon. (FHIR - identifier) 
        , null                          as "in_gebruik"                         -- Is het "dossier" van de contactpersoon actief. (FHIR - active)
        , ifct_naam                     as "contact_patient"                    -- De patiënt die gerelateerd is aan deze persoon. (FHIR - patient)
        , ifct_voornaam_partner         as "naam_voornaam"                      -- Voornaam van de contactpersoon.
        , ifct_voorletters_partner      as "naam_initialen"                     -- Initialen van de contactpersoon.
        , ifct_achternaam_partner       as "name_familiy"                       -- Geslachtsnaam_Achternaam van de contactpersoon.
        , ifct_tussenvoegsels_partner   as "name_given"                         -- Tussenvoegsels van de contactpersoon.
        , null                          as "telefoon"                           -- Telefoonnummer van de contactpersoon.
        , null                          as "nummer_soort"                       -- zib definieert NummerSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.3
        , null                          as "mail_adres"                         -- EmailAdres van de contactpersoon.
        , null                          as "mail_soort"                         -- zib definieert EmailSoortCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.4
        , null                          as "roepnaam"                           -- Roepnaam van de contactpersoon.
        , null                          as "adres_straatnaam"                   -- AdresGegevens_straat van de contactpersoon.
        , null                          as "adres_huisnummer"                   -- AdresGegevens_huisnummer  van de contactpersoon.
        , null                          as "adres_huisnummer_letter"            -- zib definieert bij AdresGegevens een Huisnummerletter.
        , null                          as "adres_huisnummer_toevoeging"        -- zib definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                          as "adres_aanduiding_bij_nummer"        -- zib definieert AanduidingBijNummerCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.7
        , null                          as "adres_postcode"                     -- AdresGegevens_postcode  van de contactpersoon.
        , null                          as "adres_woonplaats"                   -- AdresGegevens_woonplaats  van de contactpersoon.
        , null                          as "adres_gemeente"                     -- zib definieert bij AdresGegevens een Gemeente.
        , null                          as "adres_land"                         -- zib definieert bij AdresGegevens twee verschillende LandCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.9 en http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.0.1.8
        , null                          as "address_extra_info"                 -- zib definieert bij AdresGegevens AdditioneleInformatie.
        , null                          as "rol_contactpersoon"                 -- zib Contactpersoon definieert RolCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.3.1.2
        , null                          as "relatie"                            -- zib Contactpersoon definieert RelatieCodes: http://decor.nictiz.nl/art-decor/decor-valuesets--zib1bbr-?id=2.16.840.1.113883.2.4.3.11.60.40.2.3.1.1

from mtdx.v_intf_contact
where ifct_soort = 9 --AND ifct_bsn = ""                                          -- Filteren op patiënten en een specifieke patiënt selecteren voor de contactpersoon