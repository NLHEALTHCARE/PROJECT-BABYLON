-- Script hoort bij de Zorginformatiebouwsteen Patient. (https://zibs.nl/wiki/Patient(NL)) 
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)

select
   ifct_bsn                     as "identifier"                         -- PatientIdentificatienummer. (FHIR - identifier)
   , null                       as "in_gebruik"                         -- Is patientenrecord in gebruik. (FHIR - active)
   , null                       as "telefoon"                           -- zib's Patient definieert een Telefoonnummer.
   , null                       as "nummer_soort"                       -- zib's Patient definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
   , null                       as "mail_adres"                         -- zib's Patient definieert een EmailAdres.
   , null                       as "mail_soort"                         -- zib's Patient definieert het type EmailAdres.
   , ifct_straat_b              as "adres_straatnaam"                   -- AdresGegevens_straat.
   , ifct_huisnr_b              as "adres_straatnaam"                   -- AdresGegevens_huisnummer.
   , null                       as "adres_huisnummer_letter"            -- zib's Patient definieert bij AdresGegevens een Huisnummerletter.
   , ifct_gebouw_b              as "adres_huisnummer_toeboeging"        -- zib's Patient definieert bij AdresGegevens een Huisnummertoevoeging.
   , null                       as "adres_aanduiding_bij_nummer"        -- zib's Patient definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
   , ifct_postcode_b            as "adres_postcode"                     -- AdresGegevens_postcode.
   , ifct_plaats_b              as "adres_woonplaats"                   -- AdresGegevens_woonplaats.
   , null                       as "adres_gemeente"                     -- zib's Patient definieert bij AdresGegevens een Gemeente.
   , ifct_lnd_omschrijving_b    as "adres_land"                         -- zib's Patient definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
   , null                       as "address_extra_info"                 -- zib's Patient definieert bij AdresGegevens AdditioneleInformatie.
   , null                       as "naam_gebruik"                       -- zib's Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
   , null                       as "name_text"                          -- Volledige naam. (FHIR - name)
   , ifct_voornaam              as "naam_voornaam"                      -- Voornaam.
   , ifct_voorletters           as "naam_initialen"                     -- Initialen.
   , ifct_achternaam            as "name_familiy"                       -- Geslachtsnaam_Achternaam.
   , ifct_tussenvoegsels        as "name_given"                         -- Tussenvoegsels.
   , ifct_roepnaam              as "naam_roepnaam"                      -- Roepnaam.
   , ifct_geslacht              as "geslacht"                           -- Geslacht.
   , ifct_geboortedtm           as "geboortedatum"                      -- Geboortedatum.
   , ifct_vervaldtm             as "overlijdings_indicator"             -- OverlijdingsIndicator.
   , null                       as "datum_overlijden"                   -- DatumOverlijden.
   , ifct_burgelijke_staat      as "burgelijke_staat"                   -- BurgelijkeStaat.
   , ifct_is_meerling           as "multiple_birth"                     -- MeerlingIndicator.
   , null                       as "zorgverlener"                       -- Wie is de arts van deze patient. (FHIR - generalPractitioner)
   , null                       as "zorgaanbieder"                      -- Bij welke zorgaanbieder zit deze patient. (FHIR - managingOrganization)
   , null                       as "contact_relationship"               -- Soort Contactpersoon.
   , ifct_voorletters_partner   as "contact_voorvoegsels"               -- ContactVoorvoegsels.
   , ifct_achternaam_partner    as "contact_achternaam"                 -- ContactAchternaam.
   , null                       as "contact_identifier"                 -- Contact_Identificatienummer.
   , ifct_geslacht_partner      as "contact_gender"                     -- PartnerGeslacht.
   , null                       as "contact_meerling"                   -- zib's definieert bij Patient_Partner MeerlingIndicator.
   , null                       as "contact_periode_gebruik"            -- Periode waarin deze contact persoon wordt gebruikt. (FHIR - contact.period)
   , null                       as "contact_organisation"               -- Bij welke zorgaanbieder zit de contactpersoon. (FHIR - contact.organization)

from mtdx.v_intf_contact 
where ifct_soort = 9                                                    -- Dit zijn patienten