-- Script hoort bij de Zorginformatiebouwsteen Zorgverlener . (https://zibs.nl/wiki/Zorgverlener(NL))
-- De FHIR resource Practitioner is hier deels voor gebruikt. (https://www.hl7.org/fhir/practitioner.html#resource)
-- Voor bepaalde CodeLijsten wordt gerefereerd naar de zib Patient, omdat deze CodeLijsten niet in de zib Zorgverlener zijn beschreven. (https://zibs.nl/wiki/Patient(NL))

select
      ifmw_agb                          as "zorgerverlener_identificatienr"             -- zib's definieert een Zorgindentificatienummer kan via AGB of UZI.
      , null                            as "in_gebruik"                                 -- Is de zorgverlener van dit dossier nog actief. (FHIR - active)
      , null                            as "naam_gebruik"                               -- zib's Patient definieert Naamgebruikcodes https://zibs.nl/wiki/Patient(NL)#NaamgebruikCodelijst
      , null                            as "name_text"                                  -- Volledige naam. (FHIR - name)
      , ifmw_voornaam                   as "naam_voornaam"                              -- Voornaam.
      , ifmw_voorletters                as "naam_initialen"                             -- Initialen.
      , ifmw_achternaam                 as "name_familiy"                               -- Geslachtsnaam_Achternaam.
      , ifmw_tussenvoegsels             as "name_given"                                 -- Tussenvoegsels.
      , null                            as "naam_roepnaam"                              -- Roepnaam.
      , null                            as "specialisme"                                -- zib's Zorgverlener definieert SpecialismeCodes volgens AGB of UZI: https://zibs.nl/wiki/Zorgverlener(NL)#SpecialismeAGBCodelijst en https://zibs.nl/wiki/Zorgverlener(NL)#SpecialismeUZICodelijst
      , ifmw_straat_pr                  as "adres_straatnaam"                           -- AdresGegevens_straat.
      , ifmw_huisnr_pr                  as "adres_straatnaam"                           -- AdresGegevens_huisnummer.
      , null                            as "adres_huisnummer_letter"                    -- zib's definieert bij AdresGegevens een Huisnummerletter.
      , ifmw_gebouw_pr                  as "adres_huisnummer_toevoeging"                -- zib's definieert bij AdresGegevens een Huisnummertoevoeging.
      , null                            as "adres_aanduiding_bij_nummer"                -- zib's definieert AanduidingBijNummerCodes: https://zibs.nl/wiki/Patient(NL)#AanduidingBijNummerCodelijst
      , ifmw_postcode_pr                as "adres_postcode"                             -- AdresGegevens_postcode.
      , ifmw_plaats_pr                  as "adres_woonplaats"                           -- AdresGegevens_woonplaats.
      , null                            as "adres_gemeente"                             -- zib's definieert bij AdresGegevens een Gemeente.
      , ifmw_lnd_omschrijving_pr        as "adres_land"                                 -- zib's definieert bij AdresGegevens twee verschillende LandCodes: https://zibs.nl/wiki/Patient(NL)#LandGBACodelijst
      , null                            as "address_extra_info"                         -- zib's definieert bij AdresGegevens AdditioneleInformatie.
      , null                            as "telefoon"                                   -- zib's definieert een Telefoonnummer.
      , null                            as "nummer_soort"                               -- zib's definieert NummerSoortCodes: https://zibs.nl/wiki/Patient(NL)#NummerSoortCodelijst
      , null                            as "mail_adres"                                 -- zib's definieert een EmailAdres.
      , null                            as "mail_soort"                                 -- zib's definieert het type EmailAdres.
      , null /*ifmw_vst_naam ?*/        as "zorgaanbieder"                              -- zib's definieert de organisatie waar de zorgverlener werkzaam is.
      , null                            as "zorgverlener_rol"                           -- zib's Zorgverlener definieert ZorgverlenerRolCodes: https://zibs.nl/wiki/Zorgverlener(NL)#ZorgverlenerRolCodelijst
      , ifmw_geslacht                   as "geslacht"                                   -- Het geslacht van de zorgverlener. (FHIR - gender)
  
from mtdx.v_intf_medewerker
