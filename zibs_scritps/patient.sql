-- Script hoort bij de Zorginformatiebouwsteen (zib) Patient. (https://zibs.nl/wiki/Patient(NL)) 
-- De FHIR resource Patient is hier deels voor gebruikt. (https://www.hl7.org/fhir/patient.html#resource)

select
        ct.ifct_bsn                     as "identifier"                         -- PatientIdentificatienummer. (FHIR - identifier)
        , null                          as "in_gebruik"                         -- Is patientenrecord in gebruik. (FHIR - active)
        , br.ifbr_waarde                as "telefoon"                           -- zib Patient definieert een Telefoonnummer.
        , null                          as "nummer_soort"                       -- zib Patient definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
        , null                          as "mail_adres"                         -- zib Patient definieert een EmailAdres.
        , null                          as "mail_soort"                         -- zib Patient definieert EmailSoortCodes: https://zibs.nl/wiki/Patient(NL)#EmailSoortCodelijst.
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
        , null                          as "naam_gebruik"                       -- zib Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
        , null                          as "name_text"                          -- Volledige naam. (FHIR - name)
        , ct.ifct_voornaam              as "naam_voornaam"                      -- Voornaam.
        , ct.ifct_voorletters           as "naam_initialen"                     -- Initialen.
        , ct.ifct_achternaam            as "name_familiy"                       -- Geslachtsnaam_Achternaam.
        , ct.ifct_tussenvoegsels        as "name_given"                         -- Tussenvoegsels.
        , ct.ifct_roepnaam              as "naam_roepnaam"                      -- Roepnaam.
        , ct.ifct_geslacht              as "geslacht"                           -- Geslacht.
        , ct.ifct_geboortedtm           as "geboortedatum"                      -- Geboortedatum.
        , ct.ifct_vervaldtm             as "overlijdings_indicator"             -- OverlijdingsIndicator.
        , null                          as "datum_overlijden"                   -- DatumOverlijden.
        , ct.ifct_burgelijke_staat      as "burgelijke_staat"                   -- BurgelijkeStaat.
        , ct.ifct_is_meerling           as "multiple_birth"                     -- MeerlingIndicator.
        , mw.ifmw_achternaam            as "zorgverlener"                       -- Wie is de arts van deze patient. (FHIR - generalPractitioner)
        , vs.ifvs_naam                  as "zorgaanbieder"                      -- Bij welke zorgaanbieder zit deze patient. (FHIR - managingOrganization)
        , null                          as "contact_relationship"               -- Soort Contactpersoon.
        , ct.ifct_voorletters_partner   as "contact_voorvoegsels"               -- ContactVoorvoegsels.
        , ct.ifct_achternaam_partner    as "contact_achternaam"                 -- ContactAchternaam.
        , null                          as "contact_identifier"                 -- Contact_Identificatienummer.
        , ct.ifct_geslacht_partner      as "contact_gender"                     -- PartnerGeslacht.
        , null                          as "contact_meerling"                   -- zib definieert bij Patient_Partner MeerlingIndicator.
        , null                          as "contact_periode_gebruik"            -- Periode waarin deze contact persoon wordt gebruikt. (FHIR - contact.period)
        , null                          as "contact_organisation"               -- Bij welke zorgaanbieder zit de contactpersoon. (FHIR - contact.organization)

from mtdx.v_intf_contact ct
join mtdx.v_intf_bereikbaar br on ct.ifct_id = br.ifbr_ifct_id
join mtdx.v_intf_zorgactiviteit za on ct.ifct_id = za.ifza_ct_id
join mtdx.v_intf_vestiging vs on za.ifza_vest_id = vs.ifvs_id
join mtdx.v_intf_medewerker mw on za.ifza_eigenaar_code = mw.ifmw_code

where ct.ifct_soort = 9                                                          -- Dit zijn patienten