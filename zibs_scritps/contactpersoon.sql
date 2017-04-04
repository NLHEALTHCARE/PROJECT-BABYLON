-- Script hoort bij de Zorginformatiebouwsteen Contactpersoon. (https://zibs.nl/wiki/Contactpersoon(NL))
-- De FHIR resource RelatedPerson is hier deels voor gebruikt. (https://www.hl7.org/fhir/relatedperson.html#resource)
-- Voor bepaalde CodeLijsten wordt gerefereerd naar de zib Patient, omdat deze CodeLijsten niet in de zib Contactpersoon zijn beschreven. (https://zibs.nl/wiki/Patient(NL))

select
        ifct_tit_code_partner           as "identifier"                         -- id van de contactpersoon. (FHIR - identifier) -- ifct_code_p ???
        , null                          as "in_gebruik"                         -- Is het "dossier" van de contactpersoon actief. (FHIR - active)
        , ifct_naam                     as "contact_patient"                    -- De patiënt die gerelateerd is aan deze persoon. (FHIR - patient)
        , ifct_voornaam_partner         as "naam_voornaam"                      -- Voornaam van de contactpersoon.
        , ifct_voorletters_partner      as "naam_initialen"                     -- Initialen van de contactpersoon.
        , ifct_achternaam_partner       as "name_familiy"                       -- Geslachtsnaam_Achternaam van de contactpersoon.
        , ifct_tussenvoegsels_partner   as "name_given"                         -- Tussenvoegsels van de contactpersoon.
        , null                          as "telefoon"                           -- Telefoonnummer van de contactpersoon.
        , null                          as "nummer_soort"                       -- zib's definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
        , null                          as "mail_adres"                         -- EmailAdres van de contactpersoon.
        , null                          as "mail_soort"                         -- Type EmailAdres van de contactpersoon.
        , null                          as "roepnaam"                           -- Roepnaam van de contactpersoon.
        , null                          as "adres_straatnaam"                   -- AdresGegevens_straat van de contactpersoon.
        , null                          as "adres_straatnaam"                   -- AdresGegevens_huisnummer  van de contactpersoon.
        , null                          as "adres_huisnummer_letter"            -- zib's definieert bij AdresGegevens een Huisnummerletter.
        , null                          as "adres_huisnummer_toevoeging"        -- zib's definieert bij AdresGegevens een Huisnummertoevoeging.
        , null                          as "adres_aanduiding_bij_nummer"        -- zib's definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
        , null                          as "adres_postcode"                     -- AdresGegevens_postcode  van de contactpersoon.
        , null                          as "adres_woonplaats"                   -- AdresGegevens_woonplaats  van de contactpersoon.
        , null                          as "adres_gemeente"                     -- zib's definieert bij AdresGegevens een Gemeente.
        , null                          as "adres_land"                         -- zib's definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
        , null                          as "address_extra_info"                 -- zib's definieert bij AdresGegevens AdditioneleInformatie.
        , null                          as "rol_contactpersoon"                 -- zib's Contactpersoon definieert RolCodes: https://zibs.nl/wiki/Contactpersoon(NL)#RolCodelijst
        , null                          as "relatie"                            -- zib's Contactpersoon definieert RelatieCodes: https://zibs.nl/wiki/Contactpersoon(NL)#RelatieCodelijst

from mtdx.v_intf_contact
where ifct_soort = 9 --AND ifct_bsn = ""                                          -- Filteren op patiënten en een specifieke patiënt selecteren voor de contactpersoon